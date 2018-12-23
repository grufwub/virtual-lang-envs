#!/bin/bash

source /etc/setup.d/vars.sh

RUSTENV_ROOT="${LIBS_ROOT}/rust"
RUST_LATEST="1.11.2"

if [[ -d "${RUSTENV_ROOT}" ]] ; then
	whiptail --title "Rust folder exists" --msgbox "The folder ${RUSTENV_ROOT} already exists. To reinstall please run:\n$ sudo rm -rf ${RUSTENV_ROOT}\nThen remove the related 'rust' entries in ${LIBS_ROOT}/profile" 10 80
	exit 0
fi

mkdir ${RUSTENV_ROOT}

echo '### RUST SHELL SETUP ###'								| sudo tee -a ${LIBS_ROOT}/profile
echo 'export RUSTENV_ROOT="${LIBS_ROOT}/rust"'				| sudo tee -a ${LIBS_ROOT}/profile
echo 'export RUSTUP_HOME="${RUSTENV_ROOT}/rustup"' 			| sudo tee -a ${LIBS_ROOT}/profile
echo 'export CARGO_HOME="${RUSTENV_ROOT}/cargo"'			| sudo tee -a ${LIBS_ROOT}/profile
echo 'export PATH="${CARGO_HOME}/bin:${PATH}"'				| sudo tee -a ${LIBS_ROOT}/profile
echo '### RUST SHELL SETUP ###'								| sudo tee -a ${LIBS_ROOT}/profile
echo ''														| sudo tee -a ${LIBS_ROOT}/profile

curl -sSf https://sh.rustup.rs -o "${RUSTENV_ROOT}/rustup.rs"
source ${LIBS_ROOT}/profile && sh "${RUSTENV_ROOT}/rustup.rs" -y --no-modify-path
rm ${RUSTENV_ROOT}/rustup.rs