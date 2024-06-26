#!/bin/bash

echo "Running all-pis.sh now."

MY_NAME="all-pis"
CUR_DIR=`pwd`

INVENTORY="-i /srv/inventories/hosts.yaml "
PLAYBOOK="./playbooks/${MY_NAME}.yaml"
DEBUG=" "
#DEBUG=" -vvv "

BASE_DIR="/var/local/Ansible/"
cd ${BASE_DIR}

# Debugging, verfy the above work.
echo "  Cur Dir: ${BASE_DIR}"
echo " Home Dir: ${CUR_DIR}"

PASSWD="--vault-password-file  ${HOME}/.vault-pass.txt "
CMD="ansible-playbook ${INVENTORY} ${PASSWD} ${DEBUG} ${PLAYBOOK}"

echo "Executing:  $CMD"
echo

# export ANSIBLE_DEBUG=1
$CMD

cd ${CUR_DIR}

### END DBK
