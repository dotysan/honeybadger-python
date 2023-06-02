#!/bin/sh
set -ev

if [ "$DJANGO_VERSION" ]
then pip install Django==$DJANGO_VERSION
fi

if [ "$FLASK_VERSION" ]
then
    pip install itsdangerous==2.0.1
    pip install Jinja2==3.0.3
    pip install werkzeug==2.0.3
    pip install Flask==$FLASK_VERSION
fi

echo "OK"
