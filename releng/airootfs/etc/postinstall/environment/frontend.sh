#!/bin/zsh

COL=$(tput cols)
WLCM1="Music CPR Frontend Setup and Conguration"
WLCM2="KEEP THIS WINDOW OPEN WHILE WORKING"

# terminate dev server w/ `kill -USR2` if necessary
fe_running=false
handle_fe_running () {
  fe_running=true ;
  exit 0;
}
trap handle_fe_running USR2

CPRDIR="~/MusicCPR/dev/local/CPR-Music/"
cd $CPRDIR
asdf local nodejs 22.3.0

npm i
npm run dev

