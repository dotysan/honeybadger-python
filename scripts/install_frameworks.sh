#!/bin/sh
set -e

# TODO: use? --force-reinstall

if [ "$DJANGO_VERSION" ]
then
    pip install --upgrade Django==$DJANGO_VERSION
fi

if [ "$FLASK_VERSION" ]
then
    pip install --upgrade Flask==$FLASK_VERSION
fi
