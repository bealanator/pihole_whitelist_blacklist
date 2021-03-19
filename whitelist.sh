
arg=$1

if [ "$arg" == "update" ] ; then
  echo "Pulling whitelist ..."
  if [ -f whitelist.txt ] ; then
    rm whitelist.txt
  fi

  if [ -f whitelist.list ] ; then
    rm whitelist.list
  fi

  wget https://raw.githubusercontent.com/anudeepND/whitelist/master/domains/whitelist.txt
  echo "Pulling regex whitelist ..."
  wget https://raw.githubusercontent.com/mmotti/pihole-regex/master/whitelist.list
  sed -i '/#/d' whitelist.list
  sed -i '/#/d' whitelist.txt
  sed -i '/^$/d' whitelist.txt
  sed -i '/^$/d' whitelist.list

  echo "Adding domains to whitelist ..."
    pihole -w $( cat whitelist.txt )
  echo "Adding regex whitelist  ..."
    pihole -w $( cat whitelist.list )
elif [ "$arg" == "remove" ] ; then
  if [ ! -f whitelist.txt ] || [ ! -f whitelist.list ] ; then
    rm whitelist.txt whitelist.list
    echo "Pulling whitelist ..."
    wget https://raw.githubusercontent.com/anudeepND/whitelist/master/domains/whitelist.txt
    echo "Pulling regex whitelist ..."
    wget https://raw.githubusercontent.com/mmotti/pihole-regex/master/whitelist.list
    sed -i '/#/d' whitelist.list
    sed -i '/#/d' whitelist.txt
    sed -i '/^$/d' whitelist.txt
    sed -i '/^$/d' whitelist.list
  fi
    echo "Removing white list entries  ..."
    pihole -w -d $( cat whitelist.txt )
    echo "Removeing regex whitelist ..."
    pihole -w -d $( cat whitelist.list )
else
  printf "Usage\n update : Download whitelist and add to Pi-hole\n remove : Remove whitelist items added with this script\n"
fi
