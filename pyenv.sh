#!/bin/bash

source /etc/setup.d/vars.sh

PYENV_ROOT="${LIBS_ROOT}/pyenv"
PY_LATEST="3.7.1"

if [[ -d "${PYENV_ROOT}" ]] ; then
	whiptail --title "Pyenv folder exists" --msgbox "The folder ${PYENV_ROOT} already exists. To reinstall please run:\n$ sudo rm -rf ${PYENV_ROOT}\nThen remove the related 'pyenv' entries in ${LIBS_ROOT}/profile" 10 80
	exit 0
fi

git clone https://github.com/pyenv/pyenv.git --depth=1				"${PYENV_ROOT}"
git clone https://github.com/pyenv/pyenv-doctor.git --depth=1		"${PYENV_ROOT}/plugins/pyenv-doctor"
git clone https://github.com/pyenv/pyenv-installer.git --depth=1	"${PYENV_ROOT}/plugins/pyenv-installer"
git clone https://github.com/pyenv/pyenv-update.git --depth=1		"${PYENV_ROOT}/plugins/pyenv-update"
git clone https://github.com/pyenv/pyenv-virtualenv.git --depth=1	"${PYENV_ROOT}/plugins/pyenv-virtualenv"
git clone https://github.com/pyenv/pyenv-which-ext.git --depth=1	"${PYENV_ROOT}/plugins/pyenv-which-ext"

# Export to virtualenv libraries shell-profile
echo '### PYENV SHELL SETUP ####'				| sudo tee -a ${LIBS_ROOT}/profile
echo 'export PYENV_ROOT="${LIBS_ROOT}/pyenv"'	| sudo tee -a ${LIBS_ROOT}/profile
echo 'export PATH="${PYENV_ROOT}/bin:${PATH}"'	| sudo tee -a ${LIBS_ROOT}/profile
echo 'eval "$(pyenv init -)"'					| sudo tee -a ${LIBS_ROOT}/profile
echo 'eval "$(pyenv virtualenv-init -)"'		| sudo tee -a ${LIBS_ROOT}/profile
echo '### PYENV SHELL SETUP ###'				| sudo tee -a ${LIBS_ROOT}/profile
echo ''											| sudo tee -a ${LIBS_ROOT}/profile
source ${LIBS_ROOT}/profile

# Install c compiler (for installing python environment)
sudo apt update -y
sudo apt install -y make build-essential libssl-dev zlib1g-dev libbz2-dev libreadline-dev libsqlite3-dev wget curl llvm libncurses5-dev xz-utils tk-dev libxml2-dev libxmlsec1-dev libffi-dev -y

# Install latest version of Python
pyenv install ${PY_LATEST} --verbose
pyenv global ${PY_LATEST}
pyenv -v
pyenv rehash
