#!/bin/sh
# Installs crucial eddos dependencies

. ./eddos-core/hooks/eddos_share.sh
echo "Updating Fedora.  You may be prompted for a password."
sudo dnf -y update

transparent_install rcm

echo "Bootstrapping rcm."
dest="${XDG_CONFIG_HOME:-$HOME/.config}/rcm/rcrc"
if [ ! -e "$dest" ]; then
	mkdir -p ${XDG_CONFIG_HOME:-$HOME/.config}/rcm
	ln -s $PWD/eddos-core/rcm/rcrc ${XDG_CONFIG_HOME:-$HOME/.config}/rcm/rcrc
fi

echo "Running installer."
rcup
