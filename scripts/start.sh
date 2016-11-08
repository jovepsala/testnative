#!/bin/bash
# Called from upstart script /etc/init/spaceify.conf to start Spaceify's core.
# Spaceify Oy 21.4.2015

cd /var/lib/testnative/
node testnative
