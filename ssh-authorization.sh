#!/bin/sh
#=========================================================
#  Setup Authorization Agent for SSH Keys to be accessed
#  by cronjobs. The shell environment variables for 
#  authorization will be stored in /tmp/ssh-agent.env
#=========================================================
SSH_AUTH_INFO=${HOME}/Documents/scripts/ssh-authorization
ADMIN=shakerlxxv@gmail.com

. ${SSH_AUTH_INFO} > /dev/null 2>&1

# Main 
if [ "$1" = "-set" ]; then
  set_auth_sock
  echo "Authorization Set"
else
  check_auth || { echo "SSH Auth Agent FAILED" | mailx -s "SSH Auth Agent FAILED" ${ADMIN}; }
fi
