#!/bin/bash
#
#
# Uninstall the local files from the ansible host computer.

if [ ${EUID} -ne 0 ] ; then
    echo "You must be root! ${EUID}"
    exit
fi

VARL_DIR=/var/local
ULB_DIR=/usr/local/bin
WORK_DIR=${VARL_DIR}/Ansible
SRC_DIR=/NFS/Projects/Network/Ansible

rm ${ULB_DIR}/install-network-ansible.sh
rm ${ULB_DIR}/uninstall-network-ansible.sh
rm ${ULB_DIR}/run-network-ansible.sh
rm ${ULB_DIR}/update-network-ansible.sh

if [ -d ${WORK_DIR} ] ; then
    rm -rf ${WORK_DIR}
fi

#
### END DBK
