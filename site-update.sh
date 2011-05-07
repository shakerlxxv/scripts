#!/bin/sh
SSH_AUTH_INFO=${HOME}/Documents/scripts/ssh-authorization

# update these source code repositories
REPOS="/home/bshaver/sites/Handyworks
/home/bshaver/sites/handyworks-r3
/var/www/redmine/git_repositories/Handyworks.git
/var/www/redmine/git_repositories/pack_leader.git
/var/www/redmine/git_repositories/handyworks-r3.git
"

. ${SSH_AUTH_INFO}
{ check_auth && . ${SSH_AGENT_FILE}; } || { echo "Auth not working"; exit 1; }

for R in ${REPOS}; do
  cd $R
  git fetch
done
