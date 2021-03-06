#!/usr/bin/env bash
####################################################
# Main script used to call other scripts correctly #
####################################################
if [ $(whoami) != "root" ] ; then
  echo "Please run with sudo/root"
  exit 1
fi

args=$1

if [ "$args" == "add_whitelist" ] ; then
  bash $(pwd)/whitelist/whitelist.sh update
  bash $(pwd)/whitelist/common_whitelist_add.sh
elif [ "$args" == "remove_whitelist" ] ; then
  bash $(pwd)/whitelist/whitelist.sh remove
#  bash $(pwd)/whitelist/common_whitelist_remove.sh
elif [ "$args" == "add_blacklist" ] ; then
  bash $(pwd)/blacklist/blacklist.sh update
elif [ "$args" == "remove_blacklist" ] ; then
  bash $(pwd)/blacklist/blacklist.sh remove
else
  echo "Usage"
  echo " add_whitelist : Add anudeepND whitelist, mmotti's whitelist for regex and commonly whitelistd Pi-hole domains"
  echo " remove_whitelist : Remove all whitelist entries"
  echo " add_blacklist : Add mmotti regex blacklist"
  echo " remove_blacklist : Remove all blacklist entries"
  restart="no"
fi
if [ "$restart" != "no" ] ; then
  echo "Restarting DNS services ..."
  pihole restartdns
fi
