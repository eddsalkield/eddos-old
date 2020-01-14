#!/bin/sh
# Installs crucial eddos dependencies

. ./eddos-core/hooks/eddos_share.sh

echo "Removing symlinks across your system."
rcdn

transparent_remove rcm
