#!/bin/zsh

#
# Script that sets up postgresql within the
# cparch VM
#

# login as user postgres
sudo -u postgres -i
initdb --locale $LANG -E UTF8 -D '/var/lib/postgres/data/'
exit

sudo systemctl enable --now postgresql
sudo -u postgres psql -c "\password muzak;"

sudo mkdir /var/lib/pgadmin
sudo mkdir /var/log/pgadmin
sudo chown $USER /var/lib/pgadmin
sudo chown $USER /var/log/pgadmin

cd ~
python3.12 -m venv pgadmin4
source pgadmin4/bin/activate
pip install pgadmin4
pgadmin4
cd -