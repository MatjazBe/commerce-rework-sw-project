#!/bin/bash

# Provides commands that should run as www-data to avoid permission issues.
drush () {
  IQ_COMMAND_WITH_ARGS="HOME=/project/ drush $@"
  su www-data -p -s /bin/bash -c "$IQ_COMMAND_WITH_ARGS"
}
composer () {
  IQ_COMMAND_WITH_ARGS="HOME=/project/ composer $@"
  su www-data -p -s /bin/bash -c "$IQ_COMMAND_WITH_ARGS"
}
drupal () {
  IQ_COMMAND_WITH_ARGS="HOME=/project/ drupal $@"
  su www-data -p -s /bin/bash -c "$IQ_COMMAND_WITH_ARGS"
}
git () {
  IQ_COMMAND_WITH_ARGS="HOME=/project git $@"
  su www-data -p -s /bin/bash -c "$IQ_COMMAND_WITH_ARGS"
}
ssh () {
  IQ_COMMAND_WITH_ARGS="HOME=/project ssh -o StrictHostKeyChecking=no $@"
  su www-data -p -s /bin/bash -c "$IQ_COMMAND_WITH_ARGS"
}

echo "You should now be able to use drush, composer, drupal, git and ssh as the www-data user"