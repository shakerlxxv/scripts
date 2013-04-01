#!/bin/sh
SSH_AUTH_INFO=${HOME}/Documents/scripts/ssh-authorization

# update these source code repositories
REPOS="
/var/www/redmine/git_repositories/pack_leader.git
/var/www/redmine/git_repositories/handyworks-r3.git
/var/www/redmine/git_repositories/tcf_labels.git
"

. ${SSH_AUTH_INFO}
{ check_auth && . ${SSH_AGENT_FILE}; } || { echo "Auth not working"; exit 1; }

for R in ${REPOS}; do
  cd $R
  # git pull only works for the non-bare repositories, so if it fails,
  # try git fetch instead.
  git pull || git fetch
done
