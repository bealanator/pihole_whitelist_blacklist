#!/usr/bin/env bash
########################################################
# Script to pull whitelist from anudeepND's whitelist  #
# and from mmotti's regex whitelist or remove from     #
# Pi-hole sqllite database                             #
########################################################

arg=$1

if [ "$arg" == "update" ] ; then
  echo "Pulling whitelist ..."
  if [ -f whitelist.txt ] ; then
    rm whitelist.txt
  fi

  if [ -f whitelist.list ] ; then
    rm whitelist.list
  fi
  bash $(pwd)/whitelist/gen_whitelist.sh
  wget https://raw.githubusercontent.com/anudeepND/whitelist/master/domains/whitelist.txt
  echo "Pulling regex whitelist ..."
  wget https://raw.githubusercontent.com/mmotti/pihole-regex/master/whitelist.list
  sed -i '/#/d' whitelist.list
  sed -i '/#/d' whitelist.txt
  sed -i '/^$/d' whitelist.txt
  sed -i '/^$/d' whitelist.list

  echo "Adding domains to whitelist ..."
  bash $(pwd)/whitelist/common_whitelist_add.sh
  echo "Adding regex whitelist  ..."
    pihole -w $( cat whitelist.list )
elif [ "$arg" == "remove" ] ; then
  echo "Removing whitelist entries  ..."
# https://discourse.pi-hole.net/t/bulk-deletion-of-blacklist-whitelist-entries/32925/6
  sqlite3 /etc/pihole/gravity.db "delete from domainlist where type=0"
else
  printf "Usage\n update : Download whitelist and add to Pi-hole\n remove : Remove whitelist items added with this script\n"
fi
