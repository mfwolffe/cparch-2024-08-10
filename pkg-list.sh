#!/bin/bash
# this script is just to make @mfwolffe's life easier

BKPTH=./pkglst-bk

if [ ! -d $BKPTH ]; then
  mkdir $BKPTH
fi

BKNM=packages-bk-$(date +'%m-%d:%T').txt

cp releng/packages.x86_64 $BKPTH/$BKNM

pacman -Qen | sed 's/ .*//' | cat - $BKPTH/$BKNM | sort --unique > releng/packages.x86_64

