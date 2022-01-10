#!/bin/bash

# From: https://github.com/krlmlr/debian-ssh

echo "Setting up public key for ${CONTAINER_USERNAME}"

if [ -z "${SSH_KEY}" ]; then
	echo "=> No public key has been set in the SSH_KEY enviornment variable"
	echo "=> Please pass your public key in the SSH_KEY environment variable"
else 
	for MYHOME in /home/${CONTAINER_USERNAME}; do
		echo "=> Adding SSH key to ${MYHOME}"
		mkdir -p ${MYHOME}/.ssh
		chmod go-rwx ${MYHOME}/.ssh
		echo "${SSH_KEY}" > ${MYHOME}/.ssh/authorized_keys
		chmod go-rw ${MYHOME}/.ssh/authorized_keys
		echo "=> Done!"
	done
	chown -R ${CONTAINER_USERNAME}:${CONTAINER_USERNAME} /home/${CONTAINER_USERNAME}/.ssh

	echo "========================================================================"
	echo "You can now connect to this container via SSH using:"
	echo ""
	echo "    ssh -p <port> ${CONTAINER_USERNAME}@<host>"
	echo ""
	echo "========================================================================"
fi

# regenerate the ssh keys 
DSA_KEY=/etc/ssh/ssh_host_dsa_key.pub
ED25519_KEY=/etc/ssh/ssh_host_ecdsa_key.pub
RSA_KEY=/etc/ssh/ssh_host_rsa_key.pub

if [[ -f "$DSA_KEY" && -f "$ED25519_KEY" && -f $RSA_KEY ]]
then
    echo "$DSA_KEY , $ED25519_KEY , $RSA_KEY exists inside the docker volume. Skipping regenerating the keys."
else
    echo "$DSA_KEY , $ED25519_KEY , $RSA_KEY do not exist."
    echo "Regenerating the ssh keys"
    ssh-keygen -A
fi