#!/usr/bin/env bash
##############################################
# Pull black list from mmotti regex list     #
# Or remove all regex blacklist entries from #
# Pi-hole sqlite database                    #
##############################################
arg=$1

if [ "$arg" == "update" ] ; then
  echo "Pulling regex blacklist ..."
  if [ -f regex.list ] ; then
    rm regex.list
  fi

  echo "Pulling regex blacklist ..."
  wget https://raw.githubusercontent.com/mmotti/pihole-regex/master/regex.list
  sed -i '/^#/d' regex.list
  sed -i '/^$/d' regex.list

  echo "Adding regex ..."
  pihole --regex $( cat regex.list )
elif [ "$arg" == "remove" ] ; then
    echo "Removing regex entries  ..."
#https://discourse.pi-hole.net/t/bulk-deletion-of-blacklist-whitelist-entries/32925/6
    sqlite3 /etc/pihole/gravity.db "delete from domainlist where type=3"
else
  printf "Usage\n update : Download regex blacklist and add to Pi-hole\n remove : Remove regex blacklist items added with this script\n"
fi
