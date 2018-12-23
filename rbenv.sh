#!/bin/bash

source /etc/setup.d/vars.sh

RBENV_ROOT="${LIBS_ROOT}/rbenv"
RB_LATEST="2.5.1"

if [[ -d "${RBENV_ROOT}" ]] ; then
	whiptail --title "Rbenv folder exists" --msgbox "The folder ${RBENV_ROOT} already exists. To reinstall please run:\n$ sudo rm -rf ${RBENV_ROOT}\nThen remove the related 'rbenv' entries in ${LIBS_ROOT}/profile" 10 80
	exit 0
fi

# Clone rbenv source
git clone https://github.com/rbenv/rbenv.git --depth=1		"${RBENV_ROOT}"
git clone https://github.com/rbenv/ruby-build.git --depth=1	"${RBENV_ROOT}/plugins/ruby-build"

# Compile dynamic bash extension to speed up rbenv (no worries if it fails)
cd ${RBENV_ROOT} && src/configure && make -C src

# Export to virtualenv libraries shell-profile
echo '### RBENV SHELL SETUP ####'		| sudo tee -a ${LIBS_ROOT}/profile
echo 'export RBENV_ROOT="${LIBS_ROOT}/rbenv"'	| sudo tee -a ${LIBS_ROOT}/profile
echo 'export PATH=${RBENV_ROOT}/bin:$PATH'	| sudo tee -a ${LIBS_ROOT}/profile
echo 'eval "$(rbenv init -)"'			| sudo tee -a ${LIBS_ROOT}/profile
echo '### RBENV SHELL SETUP ####'		| sudo tee -a ${LIBS_ROOT}/profile
source ${LIBS_ROOT}/profile

# Install c compiler (for installing python environment)
sudo apt update -y
sudo apt install git-core curl zlib1g-dev build-essential libssl-dev libssl1.0-dev libreadline-dev libyaml-dev libsqlite3-dev sqlite3 libxml2-dev libxslt1-dev libcurl4-openssl-dev software-properties-common libffi-dev -y

# Install latest version of Python
rbenv install ${RB_LATEST} --verbose
rbenv global ${RB_LATEST}
rbenv -v
gem install bundler
rbenv rehash
