# Run from WSL2/Bash/Mac OS Terminal (outside of the container), like this:
# sh app/resources/drushRemoteDump.sh > app/resources/live.sql.gz

# Finding the variables
# $CLUSTER-NAME: The context the public web resides (e.g. do-fra1-dev-cluster-1, do-fra1-prod-cluster-1, ...)
# $NAMESPACE: The namespace of the workload, usually "dev-drpl-commerce-rework" or "prod-drpl-commerce-rework". Use `kex bash` to find the correct name.
# $DEPLOYMENT-NAME: The deployment name, usually usually "commerce-rework-drpl". Use `kex bash` to find the correct name.

REMOTE_INSTANCE_K_CONTEXT='$CLUSTER-NAME'
REMOTE_INSTANCE_K_NAMESPACE='$NAMESPACE';
REMOTE_INSTANCE_K_DEPLOYMENT='$DEPLOYMENT-NAME';
DRUPAL_STRUCTURE_TABLES='cache*,field_deleted_data_*,field_deleted_revision_*,key_value_expire,old_*,queue,sessions,watchdog,*_bk';
kubectl --context $REMOTE_INSTANCE_K_CONTEXT exec --namespace $REMOTE_INSTANCE_K_NAMESPACE deploy/$REMOTE_INSTANCE_K_DEPLOYMENT -- \
  drush --root /var/www/public sql-dump --gzip --structure-tables-list=$DRUPAL_STRUCTURE_TABLES
