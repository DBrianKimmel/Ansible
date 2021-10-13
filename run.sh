#!/bin/bash
#
# Run the playbook on the ansible host computer.

if [ ${EUID} -eq 0 ] ; then
    echo "You must NOT be root! ${EUID}"
    exit
fi

echo running shell run-network-ansible.sh

VARL_DIR=/var/local
ULB_DIR=/usr/local/bin
WORK_DIR=${VARL_DIR}/Ansible
SRC_DIR=/NFS/Projects/Network/Ansible

update-network-ansible.sh
bash ${WORK_DIR}/playbooks/all-pis.sh

### END DBK