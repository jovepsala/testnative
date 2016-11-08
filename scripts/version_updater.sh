#!/bin/bash

# Update version in files
# Spaceify Oy 2016

printf "\n : Updating version information to files"

versions=$(< versions)
mainVersion=$(echo $versions | awk -F : '{print $2}')

# ----------
# ----------
# ----------
# ----------
# ---------- debian/changelog ---------- #

#previousMainVersion=$( grep -Po "(?<=\()\b$mainVersion\b(?=\))" debian/changelog )
previousMainVersion=$( grep -m 1 "(\(.*\))" debian/changelog | sed 's/.*(//g' | sed 's/).*//g')

if [ "$mainVersion" = "$previousMainVersion" ]; then
	printf " > Version $previousMainVersion remains the same"
else
	printf " > Version $previousMainVersion updated to $mainVersion"

	versionInfo=$( LANG=EN_US date +"%a, %d %b %Y %H:%M:%S %z" )

	versionRow="testdeb ($mainVersion) unstable; urgency=low\n\n  * Release $mainVersion\n\n -- Spaceify Oy <admin@spaceify.net>  $versionInfo\n\n"

	changelog=$(< debian/changelog)
	changelog="${versionRow}${changelog}"

	printf "$changelog" > debian/changelog
fi
