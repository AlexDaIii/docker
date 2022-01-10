#!/bin/bash

# From: https://github.com/krlmlr/debian-ssh

set -e

/config.sh

exec /usr/sbin/sshd -D