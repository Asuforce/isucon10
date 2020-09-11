#!/bin/sh

set -e

NOW=`date +%Y%m%d-%H%M%S`

sudo sh <<SCRIPT
  mv /var/log/nginx/access_log.tsv /var/log/nginx/access_log.tsv.${NOW}
  systemctl restart nginx

  ################ CAUTION: Input application name ################
  systemctl restart <APP-NAME>.ruby
SCRIPT
