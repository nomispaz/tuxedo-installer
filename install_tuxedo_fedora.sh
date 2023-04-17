#!/bin/bash

# build tuxedo-keyboard

# install prerequisites
sudo dnf install make gcc kernel-headers dkms
# clone current git
git clone https://github.com/tuxedocomputers/tuxedo-keyboard.git ~/git_clones/tuxedo-keyboard
cd ~/git_clones/tuxedo-keyboard/

# create rpm package with build-in package command
git checkout release

patch ~/git_clones/tuxedo-keyboard/src_pkg/rpm_pkg.spec ~/rpm_pkg.patch

sudo make package-rpm

# copy to home of current user
cp tuxedo-keyboard*.rpm ~/

# goto home of current user
cd

# remove build-dir
sudo rm -R ~/git_clones/tuxedo-keyboard/

##########################################################################

# build tuxedo-control-center

# install prerequisites
sudo dnf install git gcc g++ make nodejs npm systemd-devel
# clone current git
git clone https://github.com/tuxedocomputers/tuxedo-control-center ~/git_clones/tuxedo-contol-center
cd ~/git_clones/tuxedo-contol-center

# build program files
npm install

# set environment to eliminate ERR_OSSL_EVP_UNSUPPORTED error (see https://stackoverflow.com/questions/69394632/webpack-build-failing-with-err-ossl-evp-unsupported)
export NODE_OPTIONS=--openssl-legacy-provider

# create rpm package
npm run pack-prod rpm

# copy to home of current user
cp ~/git_clones/tuxedo-contol-center/dist/packages/tuxedo-control-center*.rpm ~/

# goto home of current user
cd

# remove build-dir
sudo rm -R ~/git_clones/tuxedo-contol-center

############################################################################

# install packages
# fedora
sudo dnf install ./tuxedo-control-center_2.0.2.rpm ./tuxedo-keyboard-3.2.1-1.noarch.rpm
