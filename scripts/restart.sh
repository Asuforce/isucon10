#!/bin/sh

set -e

NOW=`date +%Y%m%d-%H%M%S`

sudo sh <<SCRIPT
  mv /var/log/mysql/slow.log /var/log/mysql/slow.log.${NOW}
  systemctl restart mysql
SCRIPT
