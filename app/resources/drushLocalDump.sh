# Run from inside container/VS code:
# sh app/resources/drushLocalDump.sh > app/resources/local.sql.gz

DRUPAL_STRUCTURE_TABLES='cache*,field_deleted_data_*,field_deleted_revision_*,key_value_expire,old_*,queue,sessions,watchdog,*_bk';
drush --root /var/www/public sql-dump --gzip --structure-tables-list=$DRUPAL_STRUCTURE_TABLES
