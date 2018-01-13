# NMAP SCRIPT BY: ABDUL AZIZ
## "AUTOMATION OF NETWORK SCANNING"
###### Description:
This is a Nmap Script that contains a combination of different Linux based utilities in
bash terminal and how can we use them to format our output to make things look clean.
I used the following utilities:
- [x] **grep**
- [x] **awk**
- [x] **cut**
- [x] **nmap**

## Usage:
**`chmod +x nmap_script.sh`**

**`./nmap_script.sh`**

## TROUBLESHOOTING:

Make sure you change the **NETWORK_INTERFACES="wlan0"** in **_declaring_variables_** function on **_line # 24_** in **nmap_script.sh** file to your own network interface that you are using such as **_eth0_** or etc.

## COMPATIBLE:
###### TESTED ON:
- [x] Ubuntu 12.04 and above.
- [x] Debian 5.0 and above.
- [x] Kali Linux 2.0 and above.
- [x] Backtrack R5
- [x] Parrot OS 3.10.1 -- December 15th 2017
