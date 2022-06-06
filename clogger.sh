#!/bin/bash

red=`tput setaf 1`
green=`tput setaf 2`
reset=`tput sgr0`

command -v locate > /dev/null || printf "\n${red}CRITICAL ERROR! ABORTING! (Err: locate NOT INSTALLED)${reset}\n\n"

touch log.txt
$currentdir=$(pwd)
rm -rf users.txt
touch users.txt
cd /home
printf "%s\n" * >$currentdir/user.txt
echo "root" >> $currentdir/user.txt
cd $currentdir


startlogging() {
  
}

if [ $1 == "initialize" ]; then
  echo "Moving 'clogger.sh' to '/usr/local/bin'..."
  mv clogger.sh /usr/local/bin/clogger
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
  
  
  
