#!/bin/bash
#If launched with volume /etc/fuel
if [ -f /etc/fuel/astute.yaml ]; then
  rm -f /etc/astute.yaml
  ln -s /etc/fuel/astute.yaml /etc/astute.yaml
fi
#Deprecated start
#Run this image with --link $nailgundb:db
#gateway=$(/sbin/ip route | awk '/default/ { print $3 }')
#dbhost="${DB_PORT_5432_TCP_ADDR:-$gateway}"
#Deprecated end

#Run puppet to apply custom config
puppet apply -v /root/init.pp

#Set up nailgun DB
/opt/nailgun/bin/nailgun_syncdb
/opt/nailgun/bin/nailgun_fixtures
/usr/bin/supervisord
