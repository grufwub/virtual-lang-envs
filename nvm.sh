#!/bin/bash

source /etc/setup.d/vars.sh

NVM_ROOT="${LIBS_ROOT}/nvm"
NVM_LATEST="v0.33.11"

if [[ -d "${NVM_ROOT}" ]] ; then
	whiptail --title "nvm folder exists" --msgbox "The folder ${NVM_ROOT} already exists. To reinstall please run:\n$ sudo rm -rf ${NVM_ROOT}\nThen remove the related 'nvm' entries in ${LIBS_ROOT}/profile" 10 80
	exit 0
fi

mkdir ${LIBS_ROOT}/nvm
chown :wlinux ${LIBS_ROOT}/nvm -R
chmod 777 ${LIBS_ROOT}/nvm -R
echo '### NVM SHELL SETUP ####'				| sudo tee -a ${LIBS_ROOT}/profile

curl -o- https://raw.githubusercontent.com/creationix/nvm/master/install.sh | NVM_DIR="${NVM_ROOT}" PROFILE="${LIBS_ROOT}/profile" bash

# Export to virtualenv libraries shell-profile
echo '### NVM SHELL SETUP ###'				| sudo tee -a ${LIBS_ROOT}/profile
echo ''											| sudo tee -a ${LIBS_ROOT}/profile
