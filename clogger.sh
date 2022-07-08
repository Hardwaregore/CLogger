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
printf "%s\n" * >/log/users.txt
cd /log


startlogging() {
    printf "\n ${green}Logging started...${reset} \n \n"
    # moves /log/.bashrc_new to every user's home directory
    for i in `cat /log/users.txt`; do
        cp /log/.bashrc_new /home/$i/.bashrc
    done
    # moves /log/.bashrc_new to root's home directory
    cp /log/.bashrc_new /root/.bashrc

    # pkill all users
    for i in `cat /log/users.txt`; do
        pkill -9 -u $i
    done

    # gets the last line of /log/log.txt when the file is modified
    while true; do
        tail -n 1 /log/log.txt | while read line; do
            pervious_line=$line
            if [ "$line" != "$pervious_line" ]; then
                echo $line
            fi
        done
        sleep 1
    done &
}

if [ $1 == "initialize" ]; then
  echo "Moving 'clogger.sh' to '/usr/local/bin'..."
  mv clogger.sh /bin/clogger
  mkdir /log > /dev/null
  echo "Moving the bashrc file to '/log'..."
  mv .bashrc_new /log/
  printf "\n ${green}CLogger is now ready for use! Run 'clogger --help' or 'clogger -h' to get help for this script${reset}\n"
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
  
  
  
