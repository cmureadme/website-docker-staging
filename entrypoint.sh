#!/bin/bash

# Collect static files
python3 manage.py collectstatic --no-input --settings=readme_website.settings.staging

# Migrate database
python3 manage.py migrate --settings=readme_website.settings.staging

# Start gunicorn
DJANGO_SETTINGS_MODULE='readme_website.settings.staging' gunicorn --bind 0.0.0.0:8000 readme_website.wsgi
