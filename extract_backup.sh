#!/bin/bash

# accept parameters
backup_file=$1
compression=$2

# suspend output and redirect errors
exec 1>/dev/null
exec 2>error.log

# compress and write error if wrong algorithm
case $compression in
    none)
        openssl enc -d -aes-256-cbc -pbkdf2 -iter 100000 -in $backup_file | tar -xf - 
        ;;
    gzip)
        openssl enc -d -aes-256-cbc -pbkdf2 -iter 100000 -in $backup_file | tar -xzf -
        ;;
    bzip)
        openssl enc -d -aes-256-cbc -pbkdf2 -iter 100000 -in $backup_file | tar -xjf -
        ;;
    *)
        echo "Invalid compression algorithm specified. Please use none, gzip, or bzip." >&2 
        exit 1
        ;;
esac
