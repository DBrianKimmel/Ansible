# Requirements

Initially we need to run install-network-ansible.sh.
This will copy needed files from the repository/development area to the proper place on the target machine.

The repository / development area is NFS mounted and is /NFS/Projects/Network/Ansible.

Next we need to run run-network-ansible.sh.
This will .

Since this will run on a computer that is running a coredns service, Kubernetes, it needs the hosts defined in /etc/hosts.

Once the internal DNS is working, we should no longer need the extra definitions in the file.
