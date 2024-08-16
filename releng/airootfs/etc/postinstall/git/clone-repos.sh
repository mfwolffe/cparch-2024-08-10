#!/bin/zsh

COL=$(tput cols)
WLCM1="MusicCPR Repository Setup"
printf "%*s\n\n" $(((${#WLCM1}+$COL)/2)) "$WLCM1"

CPRDIR="~/MusicCPR/dev/local"
cd $CPRDIR

USERNAME=$(git config get user.name)
FEREPO="CPR-Music-${USERNAME}"
BEREPO="CPR-Music-Backend-${USERNAME}"

FEURL="https://github.com/Lab-Lab-Lab/CPR-Music-${FEREPO}"
BEURL="https://github.com/Lab-Lab-Lab/CPR-Music-Backend-${BEREPO}"

git clone $FEURL
git clone $BEURL

EXTMSG="Repositories cloned. Please close this window."
printf "\n\n%*s\n" $(((${#WLCM1}+$COL)/2)) "$EXTMSG"

exit
