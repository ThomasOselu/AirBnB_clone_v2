#!/usr/bin/python3
'''module - multi-routes:
define index(), and plus some other endpoints
'''
from flask import Flask

app = Flask(__name__)


@app.route('/', strict_slashes=False)
def index():
    '''return `Hello, World` text'''
    return ('Hello HBNB!')


@app.route('/hbnb', strict_slashes=False)
def hbnb():
    '''display HBNB'''
    return ('HBNB')


@app.route('/c/<text>', strict_slashes=False)
def url_text(text):
    '''
    pass URL parameters to endpoint control
    the 'text' variable will be of type string
    '''
    return ("C {text.replace('_', ' ')}")


if __name__ == '__main__':
    app.run(host='0.0.0.0', port=5000)
