#!/bin/bash
#
# Install the local files on the ansible host computer.

if [ ${EUID} -ne 0 ] ; then
    echo "You must be root! ${EUID}"
    exit
fi

VARL_DIR=/var/local
ULB_DIR=/usr/local/bin
WORK_DIR=${VARL_DIR}/Ansible
SRC_DIR=/NFS/Projects/Network/Ansible

cp -a ${SRC_DIR}/install.sh ${ULB_DIR}/install-network-ansible.sh
cp -a ${SRC_DIR}/uninstall.sh ${ULB_DIR}/uninstall-network-ansible.sh
cp -a ${SRC_DIR}/run.sh ${ULB_DIR}/run-network-ansible.sh
cp -a ${SRC_DIR}/update.sh ${ULB_DIR}/update-network-ansible.sh
chmod a+x ${ULB_DIR}/*.sh

if [ ! -d ${WORK_DIR} ] ; then
    mkdir ${WORK_DIR}
    chown briank ${WORK_DIR}
fi

cp -ar ${SRC_DIR}/Code/* ${WORK_DIR}/
chown -R briank ${WORK_DIR}

### END DBK