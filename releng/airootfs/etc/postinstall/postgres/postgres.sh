#!/bin/zsh

COL=$(tput cols)
WLCM1="PostgreSQL Configuration and Database Setup"
printf "%*s\n\n" $(((${#WLCM1}+$COL)/2)) "$WLCM1"

# login as user postgres and init db cluster
sudo -u postgres -i
initdb --locale=C.UTF-8 -E UTF8 -D '/var/lib/postgres/data/'
exit

# enable postgres service
sudo systemctl enable --now postgresql
# sudo -u postgres psql -c "\password muzak;"

# execute postgres script to setup db,
# then connect to db 
sudo -u postgres psql -f ./setup.sql
psql -d $CPRDB

# 
# I guess no need for pgadmin4
# 
# sudo mkdir /var/lib/pgadmin
# sudo mkdir /var/log/pgadmin
# sudo chown $USER /var/lib/pgadmin
# sudo chown $USER /var/log/pgadmin

# cd ~
# python3.12 -m venv pgadmin4
# source pgadmin4/bin/activate
# pip install pgadmin4
# pgadmin4
# cd -

