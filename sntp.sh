#!/bin/bash
# sh sntp.sh -c{COLOR} -u {URL} -n {NOTE}

# Colors
RED="\033[31m"
GREEN="\033[32m"
YELLOW="\033[33m"
BLUE="\033[34m"
PURPLE="\033[35m"
CYAN="\033[36m"
END="\033[0m"
TIMETRUE=false

DEFAULT_URL="pool.ntp.org"
DEFAULT_COLOR="GREEN"
DEFAULT_NOTE="127"  # Default MIDI note (C1)
NOTE_FLAG="false"


while getopts ":u:c:n:h:x" opt; do
  case $opt in
    u) URL="$OPTARG";;
    c) COLOR="$OPTARG";;
    n)
      if [[ "$OPTARG" =~ ^[0-9]+$ ]]; then
        NOTE="$OPTARG"
      else
        echo -e "${RED}Error: Note must be a number.${END}"
        exit 1
      fi
      ;;
    h) 
      echo -e "Usage: sntp.sh -u <URL> -c <COLOR> -n <NOTE> \n\nOptions: \n-u <URL> \t\t The URL of the NTP server (example: pool.ntp.org) \n-c <COLOR> \t\t The color of the output (RED, GREEN, YELLOW, BLUE, PURPLE, CYAN) \n-n <NOTE> \t\t The MIDI note to play (must be a number, default: 127 for C1) \n-h \t\t\t Display this help message"
      exit 0
      ;;
    x) NOTE_FLAG="true";;
    \?) 
      echo -e "${RED}Invalid option: -$OPTARG${END}"
      exit 1
      ;;
  esac
done

# Set default values if not provided
URL=${URL:-$DEFAULT_URL}
COLOR=${COLOR:-$DEFAULT_COLOR}
NOTE=${NOTE:-$DEFAULT_NOTE}

# Check if the sntp command is installed
if ! command -v sntp &> /dev/null; then
    echo  "${RED}The sntp command is not installed.${END}"
    exit 1
fi

# Check if the sendmidi command is installed
if ! command -v sendmidi &> /dev/null; then
    echo  "${RED}The sendmidi command is not installed.${END}"
    exit 1
fi

clear
echo  "${!COLOR}Checking time from different NTP servers \n${END}"
echo  "${!COLOR} ${URL} \n${END}"

# Set the variable to true
TIMETRUE=true


while ${TIMETRUE}; do
    echo "${!COLOR}$(sntp ${URL})${END}"

    #sendmidi dev "IAC-Treiber WEBMidi" on ${NOTE} 127 127
    #sendmidi dev "IAC-Treiber WEBMidi" off ${NOTE} 127 127
    
    sleep 1
done
