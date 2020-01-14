#!/bin/sh
# Installs crucial eddos dependencies

. ./eddos-core/hooks/eddos_share.sh
transparent_install rcm

echo "Bootstrapping rcm."
dest="${XDG_CONFIG_HOME:-$HOME/.config}/rcm/rcrc"
if [ ! -e "$dest" ]; then
	ln -s $PWD/eddos-core/rcm/rcrc ${XDG_CONFIG_HOME:-$HOME/.config}/rcm/rcrc
fi

echo "Running installer."
rcup
