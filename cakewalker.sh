#!/bin/bash

set -e
cd "${BASH_SOURCE%/*}" || exit
source ./cakeway_env.sh

echo "Version: Cakewalker v$CW_VERSION"
if [[ "$1" -ne "-c" ]]; then
    echo "Error: No command supplied"
    exit 1
fi

COMMAND=$2

if [[ "$COMMAND" == cakeway* ]] || [[ "$COMMAND" == cakewalker* ]]; then
    CPARTS=($COMMAND)
    COMMAND=${CPARTS[@]:1}
fi

update_auth_keys() {
    AUTH_KEYS="$CW_WALKERSSH/authorized_keys"

    TUNNELS=($(ls -c ~/keys/))
    TUNCOUNT=${#TUNNELS[@]}

    # Write init key
    INITOPTS='no-X11-forwarding,no-agent-forwarding,command="new-tunnel"'
    echo $INITOPTS $(cat $CW_INITKEY.pub) > $AUTH_KEYS

    # Write tunnel keys
    for i in "${!TUNNELS[@]}"; do 
        # echo "$i => ${TUNNELS[$i]}"; 
        TUNINDEX=$((TUNCOUNT - i))
        TUNNEL=${TUNNELS[$i]}
        PORT=$((TUNINDEX + CW_PORT_MIN))
        PUBKEY=$(ssh-keygen -i -f ~/keys/$TUNNEL)
        
        TUNENV='environment="CW_PORT='$PORT'",environment="CW_TUNNEL='$TUNNEL'"'
        TUNOPTS='no-X11-forwarding,no-agent-forwarding,permitlisten="localhost:'$PORT'",command="tunnel",'$TUNENV

        echo $TUNOPTS $PUBKEY >> $AUTH_KEYS
    done

}

case "$COMMAND" in
    new-tunnel)
        echo -n 'Key? '
        read PUBKEY
        echo 'OK'
        
        mkdir -p ~/tmp
        TEMPKEYFILE=$(mktemp ~/tmp/newkey_XXXXXX)
        echo $PUBKEY > $TEMPKEYFILE
        mkdir -p ~/keys
        KEYFILE=~/keys/$(ssh-keygen -l -f "$TEMPKEYFILE" | awk '{ print $3 }' | sed "s/'//g") # | awk -F@ '{ print $1}')
        
        if [[ -f "$KEYFILE" ]]; then
            echo 'Error: Keyfile already exists'
            exit 1
        fi
        
        ssh-keygen -e -f "$TEMPKEYFILE" > $KEYFILE
        rm $TEMPKEYFILE

        update_auth_keys
        
        echo 'OK'
        exit 0
        ;;
    tunnel)
        echo 'Port:' $CW_PORT
        echo 'Tunnel:' $CW_TUNNEL
        exit 0
        ;;
    update-auth-keys)
        update_auth_keys
        exit 0
        ;;
    *)
        echo "Error: Unknown command '$2'"
        exit 1
        ;;
esac

