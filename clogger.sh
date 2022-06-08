#!/bin/bash

red=`tput setaf 1`
green=`tput setaf 2`
reset=`tput sgr0`

if [ "$(id -u)" != "0" ]; then
    printf "\n ${red}CRITICAL ERROR! ABORTING! (Err: NOT root)${reset} \n \n" 1>&2
    exit 1
fi

mkdir /log > /dev/null
cd /log
touch log.txt
rm -rf users.txt
touch users.txt
cd /home
printf "%s\n" * >/log/user.txt
echo "root" >> /log/user.txt
cd /log


startlogging() {
  mv /log/.bashrc_new 
}

if [ $1 == "initialize" ]; then
  echo "Moving 'clogger.sh' to '/usr/local/bin'..."
  mv clogger.sh /usr/local/bin/clogger
  mkdir /log > /dev/null
  echo "Moving the bashrc file to '/log'..."
  mv .bashrc_new /log
  printf "\n ${green}CLogger is now ready for use! Run `clogger --help` or `clogger -h` to get help for this script${reset}"
  exit 1
  
elif [ $1 == "start" ]; then
  startlogging
  exit 1
  
elif [ $1 == "log" ]; then
  cat log.txt
  exit 1
  
elif [ $1 == "clear" ]; then
  rm -rf log.txt
  touch log.txt
  exit 1
  
elif [ $1 == "--help" || $1 == "-h" ]; then
  cat /cloggerhelp.txt
  exit 1
  
fi
  
  
  
