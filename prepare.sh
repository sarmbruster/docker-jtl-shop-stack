#!/bin/bash

set -a
. ./.env
set +a
# download JTL distribution file 
curl -C - -o shop.zip ${DOWNLOAD_URL}

mkdir -p shop
pushd shop
unzip -o ../shop.zip
popd

# generate JTL config file 

envsubst "$(printf '${%s} ' $(env | cut -d'=' -f1))" < shop-override/includes/config.JTL-Shop.ini.php.template > shop/includes/config.JTL-Shop.ini.php

# copy media files
# NB: this requires a docroot backup of the existing shop being extracted to shop.backup folder
rsync -a shop.backup/media/ shop/media/ 
rsync -a shop.backup/bilder/ shop/bilder/ 