#!/bin/zsh

# don't beg user for password first thing after OS install
sed -i ‘s/%wheel ALL=(ALL:ALL) NOPASSWD: ALL/# %wheel ALL=(ALL:ALL) NOPASSWD: ALL/g’ /etc/sudoers
sed -i ‘s/# %wheel ALL=(ALL:ALL) ALL/%wheel ALL=(ALL:ALL) ALL/g’ /etc/sudoers

COL=$(tput cols)
WLCM1="MUSIC CPARCH OPERATING SYSTEM POSTINSTALL SCRIPT"
WLCM2="Matthew Forrester Wolffe"

printf "%*s\n" $(((${#WLCM1}+$COL)/2)) "$WLCM1"
printf "%*s\n\n\n" $(((${#WLCM2}+$COL)/2)) "$WLCM2"

chsh -s /bin/zsh || eval "echo 'changing default shell failed' ; exit 1"

printf "\nInstalling asdf:\n"
git clone https://github.com/asdf-vm/asdf.git ~/.asdf --branch v0.14.0 || eval "echo 'Cloning asdf git repo failed' ; exit 1"

echo  "Appending completions to ~/.zshrc:"
printf "\n. \"\$HOME/.asdf/asdf.sh\"\n" >> ~/.zshrc
printf "\n# append completions to fpath\nfpath=(\${ASDF_DIR}/completions \$fpath)\n" >> ~/.zshrc
printf "\n# initialise completions with ZSH's compinit\nautoload -Uz compinit && compinit\n" >> ~/.zshrc
echo "sourcing ~/.zshrc"
source ~/.zshrc

asdf plugin add python
asdf install python 3.12.3
asdf global python 3.12.3
asdf plugin add nodejs
asdf install nodejs 22.3.0
asdf global nodejs 22.3.0

konsole --hold -e "$(find . -name git-config.sh)" &
wait
konsole --hold -e "$(find . -name postgres.sh)" &
wait
konsole --hold -e "$(find . -name clone-repos.sh)" &
wait

konsole --hold -e "$(find . -name backend.sh)" &
konsole --hold -e "$(find . -name frontend.sh)" &

firefox --new-tab "http://localhost:3000/"
firefox --new-tab "http://localhost:8000"

# kill -USR1
# kill -USR2

# cleanup
systemctl disable cparch-postinstall.service
rm -f /etc/systemd/system/cparch-postinstall.service
rm -f /etc/cparch-postinstall.sh