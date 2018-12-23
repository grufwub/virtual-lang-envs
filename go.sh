#!/bin/bash

source /etc/setup.d/vars.sh

GOENV_ROOT="${LIBS_ROOT}/go"
GO_LATEST="1.11.2"

if [[ -d "${GOENV_ROOT}" ]] ; then
	echo "$GOENV_ROOT} already exists. To reinstall, please run:"
	echo "$ sudo rm -rf ${GOENV_ROOT}"
	echo "Then remove the related 'go' commands in ${LIBS_ROOT}/profile"
	whiptail --title "Go folder exists" --msgbox "The folder ${GOENV_ROOT} already exists. To reinstall please run:\n$ sudo rm -rf ${GOENV_ROOT}\nThen remove the related 'go' entries in ${LIBS_ROOT}/profile" 10 80
	exit 0
fi

TMPDIR=$(mktemp -d)
wget "https://dl.google.com/go/go${GO_LATEST}.linux-amd64.tar.gz" -O "${TMPDIR}/go.linux-amd64.tar.gz"
tar -C ${LIBS_ROOT} -xvf "${TMPDIR}/go.linux-amd64.tar.gz"
rm -rf ${TMPDIR}

echo '### GO SHELL SETUP ###'				| sudo tee -a ${LIBS_ROOT}/profile
echo 'export GOROOT="${LIBS_ROOT}/go"' 		| sudo tee -a ${LIBS_ROOT}/profile
echo 'export GOPATH="/home/${USER}/go"'		| sudo tee -a ${LIBS_ROOT}/profile
echo 'export PATH="${GOROOT}/bin:${PATH}"'	| sudo tee -a ${LIBS_ROOT}/profile
echo '### GO SHELL SETUP ###'				| sudo tee -a ${LIBS_ROOT}/profile
echo ''										| sudo tee -a ${LIBS_ROOT}/profile

source ${LIBS_ROOT}/profile
mkdir "/home/${USER}/go"