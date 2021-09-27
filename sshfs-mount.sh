#!/bin/bash

SSHFS_USER_DIR="$HOME/SSHFS"

mkdir -p "$SSHFS_USER_DIR"

if [ ! -z "$1" ]; then
    if [ ! -d "$SSHFS_USER_DIR/$1" ]; then
        mkdir -p "$SSHFS_USER_DIR/$1"

        MOUNT_POINT="/home"

        if [ ! -z "$2" ]; then 
            MOUNT_POINT="$2"
        fi

        sshfs -C \
            -o auto_cache \
            -o volname=$1 \
            -o defer_permissions \
            -o jail_symlinks \
            -o noappledouble \
            $1:$MOUNT_POINT $SSHFS_USER_DIR/$1 

        echo "Host \"$1\" successfully mount with point \"$MOUNT_POINT\"."
        exit 0
    else
        echo "Host \"$1\" is already mounted."
        exit 1
    fi
fi