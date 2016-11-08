#!/bin/bash

# Build Test Native Application
# Spaceify Oy 2016

printf "\n\e[4mBuilding Native Application Test package\e[0m\n"

# ----------
# ----------
# ----------
# ----------
# ---------- VERSIONS ---------- #

versions=$(< versions)
mainVersion=$(echo $versions | awk -F : '{print $2}')

. scripts/version_updater.sh

# ----------
# ----------
# ----------
# ----------
# ---------- DIRECTORIES ---------- #

printf "\n : Creating directories"

dstBase="/tmp/build"
packageName="testnative"
dst="$dstBase/${packageName}-$mainVersion"

rm -r /tmp/build/ > /dev/null 2>&1 || true

mkdir -p $dst

# ----------
# ----------
# ----------
# ----------
# ---------- COPYING FILES ---------- #

printf "\n : Copying files"

cp -r code/ $dst
cp -r debian/ $dst
cp scripts/start.sh $dst
cp application/spaceify.manifest $dst

cp versions $dst

# ----------
# ----------
# ----------
# ----------
# ----------COMPILING ---------- #

printf "\n : Compiling Native Application Test package version $mainVersion\n\n"

chmod -R 0644 debian/

oldDir=$(pwd)
cd $dst

chown -R root:root debian/
dpkg-buildpackage -i.svn -us -uc
dpkgBuildpackageError=$?

if [ $dpkgBuildpackageError == 0 ]; then
	printf "\n : Making Spaceify package\n\n"

	cd $oldDir

	cp "${dstBase}/${packageName}_${mainVersion}_all.deb" application/

	rm "${packageName}.zip" > /dev/null 2>&1 || true
	zip -r "${packageName}.zip" application/

        printf "\n\e[42mPackage build and packed to ${packageName}.zip.\e[0m\n\n"
else
	printf "\n\e[101mBuilding package failed: $dpkgBuildpackageError\e[0m\n\n"
fi

#rm -r $dstBase > /dev/null 2>&1 || true
