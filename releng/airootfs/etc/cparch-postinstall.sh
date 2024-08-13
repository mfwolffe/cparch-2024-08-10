#!/bin/zsh

# don't beg user for password first thing after OS install
sed -i ‘s/%wheel ALL=(ALL:ALL) NOPASSWD: ALL/# %wheel ALL=(ALL:ALL) NOPASSWD: ALL/g’ /etc/sudoers
sed -i ‘s/# %wheel ALL=(ALL:ALL) ALL/%wheel ALL=(ALL:ALL) ALL/g’ /etc/sudoers

# postgres
# pgadmin
# node
# vscode
# git things

chsh -s /bin/zsh || eval "echo 'changing default shell failed' ; exit 1"

#
#                        █████    ██████ 
#                       ░░███    ███░░███
#   ██████    █████   ███████   ░███ ░░░ 
#  ░░░░░███  ███░░   ███░░███  ███████   
#   ███████ ░░█████ ░███ ░███ ░░░███░    
#  ███░░███  ░░░░███░███ ░███   ░███     
# ░░████████ ██████ ░░████████  █████    
#  ░░░░░░░░ ░░░░░
#

printf "\nInstalling asdf:\n"
git clone https://github.com/asdf-vm/asdf.git ~/.asdf --branch v0.14.0 || eval "echo 'Cloning asdf git repo failed' ; exit 1"

echo  "Appending completions to ~/.zshrc:"
printf "\n. \"\$HOME/.asdf/asdf.sh\"\n" >> ~/.zshrc
printf "\n# append completions to fpath\nfpath=(\${ASDF_DIR}/completions \$fpath)\n" >> ~/.zshrc
printf "\n# initialise completions with ZSH's compinit\nautoload -Uz compinit && compinit\n" >> ~/.zshrc
echo "sourcing ~/.zshrc"
source ~/.zshrc

asdf plugin add python
asdf plugin add nodejs
asdf install python 3.12.3
asdf install nodejs 22.3.0
asdf global python 3.12.3
asdf global nodejs 22.3.0

#
# POSTGRES
#
/bin/zsh ./etc/postinstall/postgres.sh


# TODO @mfwolffe:
#                   * finish postinstall
#                       * postgres
#                       * forks/clones
#                       * vscode???
#                       * everything else???
#                       *  


# cleanup
systemctl disable cparch-postinstall.service
rm -f /etc/systemd/system/cparch-postinstall.service
rm -f /etc/cparch-postinstall.sh