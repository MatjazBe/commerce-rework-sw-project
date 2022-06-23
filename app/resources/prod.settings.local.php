<?php

// @codingStandardsIgnoreFile

$config['file.settings']['make_unused_managed_files_temporary'] = TRUE;
$config_directories['sync'] = '../config/sync';

$databases['default']['default'] = [
  'database' => '',
  'username' => '',
  'password' => '',
  'host' => '',
  'port' => '3306',
  'driver' => 'mysql',
  'prefix' => '',
];

$settings['trusted_host_patterns']=array('^DOMAIN1$','^DOMAIN2$');
