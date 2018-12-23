#!/bin/bash

WLINUX_GROUP="wlinux"
export LIBS_ROOT="/home/.envs"

sudo addgroup ${WLINUX_GROUP}
sudo usermod -aG ${WLINUX_GROUP} ${USER}

if [[ ! -d "${LIBS_ROOT}" ]] ; then
	echo "${LIBS_ROOT} does not exist. Creating..."
	sudo mkdir ${LIBS_ROOT}
	echo "Setting correct permissions"
	sudo chown :${WLINUX_GROUP} ${LIBS_ROOT}
	sudo chmod 777 ${LIBS_ROOT}
fi

if [[ ! -f "${LIBS_ROOT}/profile" ]] ; then
	sudo touch ${LIBS_ROOT}/profile
	sudo chown :${WLINUX_GROUP} ${LIBS_ROOT}/profile
	sudo chmod 777 ${LIBS_ROOT}/profile
	echo 'export LIBS_ROOT="/home/.envs"' 	| sudo tee -a ${LIBS_ROOT}/profile
	echo ''									| sudo tee -a ${LIBS_ROOT}/profile
fi
