#!/bin/bash
#
# Update the local files on the ansible host computer.

if [ ${EUID} -eq 0 ] ; then
    echo "You must NOT be root! ${EUID}"
    exit
fi

echo running shell update-network-ansible.sh

VARL_DIR=/var/local
WORK_DIR=${VARL_DIR}/Ansible
SRC_DIR=/NFS/Projects/Network/Ansible

cp -ar ${SRC_DIR}/Code/* ${WORK_DIR}/
chown -R briank ${WORK_DIR}

### END DBK