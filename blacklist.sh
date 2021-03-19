
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
  if [ ! -f regex.list ] ; then
    echo "Pulling regex blacklist ..."
    wget https://raw.githubusercontent.com/mmotti/pihole-regex/master/regex.list
    sed -i '/^#/d' regex.list
    sed -i '/^$/d' regex.list
  fi
    echo "Removing regex entries  ..."
    pihole --regex -d $( cat regex.list )
else
  printf "Usage\n update : Download regex blacklist and add to Pi-hole\n remove : Remove regex blacklist items added with this script\n"
fi
