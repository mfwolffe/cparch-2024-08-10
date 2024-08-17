#!/bin/zsh

DONE=0
fe_running=0
be_running=0
COL=$(tput cols)

handle_exit () {
  if [ $DONE -eq 1 ] ; then
    # cleanup
    systemctl disable cparch-postinstall.service ;
    rm -f /etc/systemd/system/cparch-postinstall.service ;
    rm -f /etc/cparch-postinstall.sh ;
    pkill -P $$ ;
    echo "Exiting..." ;
    exit 0 ;
  else
    echo "Setup incomplete. please run again??" ;
    exit 1 ;
  fi
}
trap handle_exit EXIT

handle_fe_running () {
  fe_running=1 ;
  firefox --new-tab "http://localhost:3000/"
  if [ $be_running -eq 1 ]
}
trap handle_fe_running USR1

handle_be_running () {
  be_running=1
  firefox --new-tab "http://localhost:8000/admin/"
  if [ $fe_running -eq 1 ]
}
trap handle_be_running USR2

# don't beg user for password first thing after OS install
sed -i ‘s/%wheel ALL=(ALL:ALL) NOPASSWD: ALL/# %wheel ALL=(ALL:ALL) NOPASSWD: ALL/g’ /etc/sudoers
sed -i ‘s/# %wheel ALL=(ALL:ALL) ALL/%wheel ALL=(ALL:ALL) ALL/g’ /etc/sudoers

WLCM1="MUSIC CPARCH OPERATING SYSTEM POSTINSTALL SCRIPT"
WLCM2="Matthew Forrester Wolffe"

printf "%*s\n" $(((${#WLCM1}+$COL)/2)) "$WLCM1"
printf "%*s\n\n\n" $(((${#WLCM2}+$COL)/2)) "$WLCM2"

chsh -s /bin/zsh || exit 1

printf "\nInstalling asdf:\n"
git clone https://github.com/asdf-vm/asdf.git ~/.asdf --branch v0.14.0 || exit 1

echo  "Appending completions to ~/.zshrc:"
printf "\n. \"\$HOME/.asdf/asdf.sh\"\n" >> ~/.zshrc || exit 1
printf "\n# append completions to fpath\nfpath=(\${ASDF_DIR}/completions \$fpath)\n" >> ~/.zshrc || exit 1
printf "\n# initialise completions with ZSH's compinit\nautoload -Uz compinit && compinit\n" >> ~/.zshrc || exit 1
echo "sourcing ~/.zshrc"
source ~/.zshrc || exit 1

asdf plugin add python || exit 1
asdf install python 3.12.3 || exit 1
asdf global python 3.12.3 || exit 1
asdf plugin add nodejs || exit 1
asdf install nodejs 22.3.0 || exit 1
asdf global nodejs 22.3.0 || exit 1

konsole --hold -e "$(find . -name git-config.sh)" &
wait
konsole --hold -e "$(find . -name postgres.sh)" &
wait
konsole --hold -e "$(find . -name clone-repos.sh)" &
wait

konsole --hold -e "$(find . -name backend.sh)" &
konsole --hold -e "$(find . -name frontend.sh)" &

