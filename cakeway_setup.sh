#!/bin/bash

set -e
cd "${BASH_SOURCE%/*}" || exit
source ./cakeway_env.sh

echo "Cakeway v$CW_VERSION"
echo ""

if [[ $EUID > 0 ]]; then
  echo "Cakeway setup needs to be run with sudo"
  exit 126
fi

if id "$CW_USER" &>/dev/null; then
    echo "User '$CW_USER' already exists. Skipping"
else
    echo "Creating user '$CW_USER'..."
    useradd -s $CW_WALKERSHELL -U -c 'Cakeway tunnel user' -d $CW_WALKERHOME $CW_USER
fi

if [[ -f "$CW_INITKEY" ]]; then
    echo "Init key already exists. Skipping"
else
    echo "Generating Init keypair..."
    ssh-keygen -f $CW_INITKEY -b 2048 -t rsa-sha2-512 -N ''
fi

mkdir -p $CW_WALKERSSH

if [[ -f "$CW_WALKERSSH/authorized_keys" ]]; then
    echo 'Key exists'
else
    echo 'no-X11-forwarding,no-agent-forwarding,command="cakeway new-tunnel"' "$(cat $CW_INITKEY.pub)" > "$CW_WALKERSSH/authorized_keys"
fi
