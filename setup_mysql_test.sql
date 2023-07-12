-- MySQL server setup for development - test server;
-- script creates database, db user and grants relevant privileges;

CREATE DATABASE IF NOT EXISTS hbnb_test_db;

-- user auth: caching_sha2_password auth plugin
CREATE USER IF NOT EXISTS 'hbnb_test'@'localhost' IDENTIFIED BY 'hbnb_test_pwd';

GRANT ALL PRIVILEGES ON hbnb_test_db.* TO 'hbnb_test'@'localhost';
GRANT SELECT ON performance_schema.* TO 'hbnb_test'@'localhost';
FLUSH PRIVILEGES;
