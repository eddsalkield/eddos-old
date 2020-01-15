#!/bin/sh
# Installs crucial eddos dependencies

. ./eddos-core/hooks/eddos_share.sh
echo "Updating Fedora.  You may be prompted for a password."
sudo dnf -y update

#transparent_install rcm

transparent_install wget

echo "Installing custom patch of rcm."
dir=$(mktemp -d)
echo "$dir"

if ! wget -P "$dir" "https://www.salkield.uk/rcm-1.3.3-6.fc31.noarch.rpm"; then
	echo "Failed to get latest version of rcm.  Quitting."
	exit 1
fi

sudo dnf -y install "$dir/rcm-1.3.3-6.fc31.noarch.rpm"

echo "Bootstrapping rcm."
dest="${XDG_CONFIG_HOME:-$HOME/.config}/rcm/rcrc"
if [ ! -e "$dest" ]; then
	mkdir -p ${XDG_CONFIG_HOME:-$HOME/.config}/rcm
	ln -s $PWD/eddos-core/rcm/rcrc ${XDG_CONFIG_HOME:-$HOME/.config}/rcm/rcrc
fi

echo "Running installer."
rcup
