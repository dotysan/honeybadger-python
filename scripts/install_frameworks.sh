#!/bin/sh

if [ "$DJANGO_VERSION" ]
then
    pip install Django==$DJANGO_VERSION
fi

if [ "$FLASK_VERSION" ]
then
    pip install Flask==$FLASK_VERSION
fi
