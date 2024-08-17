#!/bin/zsh

COL=$(tput cols)
WLCM1="Music CPR Frontend Setup and Conguration"
WLCM2="KEEP THIS WINDOW OPEN WHILE WORKING"

CPRDIR="~/MusicCPR/dev/local/CPR-Music/"
cd $CPRDIR
asdf local nodejs 22.3.0

npm i
npm run dev & kill -SIGUSR1 $PPID

