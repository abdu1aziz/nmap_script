#!/bin/bash
#
#
# Author: Abdul Aziz
#
#
# Description:
#           nmap; scan the network as recon and send back reports.
#
function text_colors
{
  # :::::ALL ARE BOLD:::::
  NColor='\033[0m'          # No Color
  BBlack='\033[1;30m'       # Black
  BRed='\033[1;31m'         # Red
  BGreen='\033[1;32m'       # Green
  BYellow='\033[1;33m'      # Yellow
  BBlue='\033[1;34m'        # Blue
  BPurple='\033[1;35m'      # Purple
  BCyan='\033[1;36m'        # Cyan
  BWhite='\033[1;37m'       # White
}

function declaring_variables
{
  NETWORK_INTERFACE="wlan0"  # CHOOSE YOUR DESIRED INTERFACE FOR NETWORK SCAN.
  LOG_FILE="tmp/network-map.log"  # LOG FILE LOCATION.
  IP_ADDR=$(ip addr show | grep $NETWORK_INTERFACE | grep inet | awk '{print $2}' | cut -d "/" -f 1) # SNIPS OUT YOUR IP ADDRESS.
  CIDR=$(ip addr show | grep $NETWORK_INTERFACE | grep inet | awk '{print $2}' | cut -d "/" -f 2) # SNIPS OUT CIDR/SUBNET OF NETWORK.
  OPTIONS="-sP" # WHAT OPTION TO USE FOR SCAN.
}

function nmap_pkg_check # FUNCTION CHECKS IF NMAP PACKAGE IS INSTALLED ON YOUR DEVICE.
{
  NMAP_CHECK=$(dpkg-query -l nmap | grep ii | cut -d " " -f 3) # SEARCH FOR NMAP PACKAGE.
  if [[ $NMAP_CHECK == 'nmap' ]]; then                         # IF PACKAGE ALREADY EXSISTS.
    printf "${BGreen}[+] Nmap Already Installed..."
    printf "\n[+] Moving on to Scan Network.....${NColor}"
  else
    printf "\n${BRed}[-] Nmap Not Installed...${NColor}"
    printf "\n${BBlue}[*] Installing Nmap now.....${NColor}"
    sudo apt-get install nmap                                  # IF NOT THEN INSTALL THE PACKAGE.
  fi
}

function clean_up                                              # CLEARING LOG FILES TO SAVE NEW DATA.
{
  printf "\n${BYellow}[!] Please Wait While Clean Up is Running....${NColor}"
  if [[ -s $LOG_FILE ]]; then                                  # IF FILE IS NOT EMPTY.
    printf "\n${BBlue}[*] '$LOG_FILE' FILE NOT EMPTY\n${BYellow}[!] Cleaning up '$LOG_FILE' FILE.... ${NColor}"
    rm -rf $LOG_FILE                                           # REMOVE THE FILE.
    touch $LOG_FILE                                            # CREATE A NEW FILE.
    if [[ ! -s $LOG_FILE ]]; then                              # CHECK AGAIN IF FILE IS NOW EMPTY & PROCEDE.
      printf "\n${BGreen}[+] ALERT: FILE CLEARED SUCCESSFULLY...${NColor}"
    else
      printf "\n${BRed}[-] FAILED CLEARNING FILE\n${BBlue}[*] TRY RUNNING SCRIPT WITH sudo. ${NColor}"
    fi
  else
    printf "\n${BGreen}\n[+] FILE IS EMPTY\n${NColor}" # IF FILE IS EMPTY SKIP THE STEP ABOVE AND PROCEDE.
  fi
}

function print_data  # PRINTS YOUR SYSTEM NETWORK INFORMATION
{
printf "

${BCyan}[>] YOUR IP ADDRESS: ${BPurple} $1 ${NColor}
${BCyan}[>] YOUR CIDR      : ${BPurple} $2 ${NColor}
${BCyan}[>] NMAP OPTIONS   : ${BPurple} $3 ${NColor}

"
}

function execute_command # Executes NMAP COMMAND AND STORES RESULTS IN A LOG FILE
{
  printf "\n${BBlue}[*] Please Be Paitent While Network is being Scanned......."
  nmap $OPTIONS -Pn $IP_ADDR/$CIDR > $LOG_FILE  # COMMAND TO EXECUTE
  printf "\n${BGreen}[+] Network Scan Successful. Results saved in '$LOG_FILE'\n\n ${NColor}"
}

#All Function Being Executed....
text_colors
nmap_pkg_check
declaring_variables
clean_up
print_data $IP_ADDR $CIDR $OPTIONS
execute_command









#THE END
