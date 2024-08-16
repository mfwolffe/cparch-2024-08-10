#!/bin/zsh

COL=$(tput cols)
WLCM1="Music CPR Backend Setup and Conguration"
WLCM2="KEEP THIS WINDOW OPEN WHILE WORKING"

# terminate dev server w/ `kill -USR1` if necessary
server_up=false
handle_server_up () {
  server_up=true ; 
  exit 0 ;
}
trap handle_server_up USR1


CPRDIR="~/MusicCPR/dev/local"
cd $CPRDIR

asdf local python 3.12.3

python -m venv musenv
source musenv/bin/activate

cd CPR-Music-Backend/teleband

# prob don't want verbose?
# just throw in eventual logs?
tar -xvzf ~/MusicCPR/dev/media/media.tar.gz 

cd ../../dev/local/CPR-Music-Backend/
touch .env && printf "DATABASE_URL=postgres:///teleband\n" >> .env

python -m pip install --upgrade pip
python -m pip install -r requirements/local.txt

python manage.py migrate 
DJANGO_SUPERUSER_PASSWORD=muzak \ 
python manage.py createsuperuser --noinput --username mahler --email mahler@gustav.zwei

python manage.py runserver

