#!/bin/zsh

COL=$(tput cols)
WLCM1="Git Configuration"
WLCM2="Please enter the information requested below"

printf "%*s\n" $(((${#WLCM1}+$COL)/2)) "$WLCM1"
printf "%*s\n\n" $(((${#WLCM2}+$COL)/2)) "$WLCM2"

printf "Please enter git username: "
read input
git config --global user.name $input

printf "Please enter git email address: "
read input
git config --global user.email $input

EXTMSG="Confirm your settings below then close this window."

printf "\n%*s\n" $(((${#EXTMSG}+$COL)/2)) "$EXTMSG"
git config list | grep -e "name\|email"

exit

