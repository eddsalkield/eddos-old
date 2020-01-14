#!/bin/sh
echo "Updating Fedora.  You may be prompted for a password."
sudo dnf -y update

echo "Pulling latest version."
git pull

echo "Running update."
rcup
