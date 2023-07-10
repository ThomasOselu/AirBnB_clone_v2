#!/usr/bin/env bash
# bash: script to set up web servers for deployment of web_static/:

# install Nginx if not installed
if ! command -v nginx > /dev/null 2>&1; then
    sudo apt-get update -y
    sudo apt-get install -y nginx
fi

# create necessary directories if not exist:
sudo mkdir -p /data/web_static/releases/test/
sudo mkdir -p /data/web_static/shared/

# create (fake) index.html file served out by server:
# echo 'Hello World!' > /data/web_static/releases/test/index.html
echo -e "<html>\n  <head>\n  </head>\n  <body>\n    Hello World!\n  </body>\n</html>" | sudo tee /data/web_static/releases/test/index.html > /dev/null

# create or recreate symbolic link
# give ownership of /data/ folder to ubuntu user and group recursively
sudo rm -f /data/web_static/current
sudo ln -sf /data/web_static/releases/test/ /data/web_static/current
sudo chown -R ubuntu /data/
sudo chgrp -R ubuntu /data/

# configure Nginx
printf %s "server {
    listen      80 default_server;
    listen      [::]:80 default_server;
    root        /var/www/html;
    index       index.html index.htm;

    location /hbnb_static {
        alias /data/web_static/current;
        index index.html index.htm;
    }

    location	 /redirect_me {
        return  301 https://stackoverflow.com/;
    }

    error_page	404 /404.html;
    location	/404 {
        root	/var/www/html;
    internal;
    }

    add_header X-Served-By \$hostname;
}
" > /etc/nginx/sites-available/default

sudo service nginx restart
