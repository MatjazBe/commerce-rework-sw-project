#!/bin/bash

# This is the place where you want commands to run on every docker container rebuild.


# Soft-link the PROJECT_WEB_FOLDER to /var/www/public so that nginx can serve our app
ln -nfs /project/app/public /var/www/public