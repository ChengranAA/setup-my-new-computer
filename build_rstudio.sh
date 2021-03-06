#!/bin/bash
# This script installs R and builds RStudio Server for ARM-based Android phones running Debian jessie

# Install R; Debian jessie has version 3.1.1-1
apt-get update
apt-get install -y r-base r-base-dev

# Set RStudio version
VERS=v0.99.473

# Download RStudio source
mkdir ~/Downloads/
cd ~/Downloads/
wget -O $VERS https://github.com/rstudio/rstudio/tarball/$VERS
mkdir ~/Downloads/rstudio-$VERS
tar xvf ~/Downloads/$VERS -C ~/Downloads/rstudio-$VERS --strip-components 1
rm ~/Downloads/$VERS

# Run environment preparation scripts
apt-get install -y openjdk-7-jdk
cd ~/Downloads/rstudio-$VERS/dependencies/linux/
./install-dependencies-debian --exclude-qt-sdk
# Don't need openjdk-6-jdk

# Run common environment preparation scripts
apt-get install -y git pandoc libcurl4-openssl-dev
# No arm build for pandoc, so install outside of common script

cd ~/Downloads/rstudio-$VERS/dependencies/common/
#./install-common
./install-gwt
./install-dictionaries
./install-mathjax
./install-boost
#./install-pandoc
./install-libclang
./install-packages

# Add pandoc folder to override build check
mkdir ~/Downloads/rstudio-$VERS/dependencies/common/pandoc

# Get Closure Compiler and replace compiler.jar
cd ~/Downloads
wget http://dl.google.com/closure-compiler/compiler-latest.zip
unzip compiler-latest.zip
rm COPYING README.md compiler-latest.zip
mv closure-compiler*.jar ~/Downloads/rstudio-$VERS/src/gwt/tools/compiler/compiler.jar

# Configure cmake and build RStudio
cd ~/Downloads/rstudio-$VERS/
mkdir build
cmake -DRSTUDIO_TARGET=Server -DCMAKE_BUILD_TYPE=Release
make install

# Additional install steps
useradd -r rstudio-server
cp /usr/local/lib/rstudio-server/extras/init.d/debian/rstudio-server /etc/init.d/rstudio-server
chmod +x /etc/init.d/rstudio-server
ln -f -s /usr/local/lib/rstudio-server/bin/rstudio-server /usr/sbin/rstudio-server
chmod 777 -R /usr/local/lib/R/site-library/

# Setup locale
apt-get install -y locales
DEBIAN_FRONTEND=noninteractive dpkg-reconfigure locales
export LANG=en_US.UTF-8
export LANGUAGE=en_US.UTF-8

# Clean the system of packages used for building
apt-get autoremove -y cabal-install ghc openjdk-7-jdk pandoc libboost-all-dev
rm -r -f ~/Downloads/rstudio-$VERS
apt-get autoremove -y

# Start the server
rstudio-server start

# Go to localhost:8787
