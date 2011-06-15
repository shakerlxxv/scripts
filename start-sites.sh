#!/bin/sh
# Run ReverseProxy targets for multiple Ruby versions

cd /home/bshaver/sites/Handyworks
ruby script/server -d -p 45001

cd /home/bshaver/sites/handyworks-r3
passenger start -e staging -a 127.0.0.1 -p 45000 -d
