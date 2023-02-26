#!/bin/bash

# suspend output and redirect errors
exec 1>/dev/null
exec 2>error.log

# accept parameters
backup_dir=$1
compression=$2
output_file=$3

# check the number of parameters
if [ $# -ne 3 ]; then
  echo "Usage: $0 <directory-to-backup> <compression-algorithm> <output-file>" >&2
  exit 1
fi

# compress and write error if wrong algorithm
case $compression in
    none)
        tar -cf - $backup_dir | openssl enc -aes-256-cbc -pbkdf2 -iter 100000 -out $output_file
        ;;
    gzip)
        tar -czf - $backup_dir | openssl enc -aes-256-cbc -pbkdf2 -iter 100000 -out $output_file
        ;;
    bzip)
        tar -cjf - $backup_dir | openssl enc -aes-256-cbc -pbkdf2 -iter 100000 -out $output_file
        ;;
    *)
        echo "Invalid compression algorithm specified. Please use none, gzip, or bzip." >&2 
        exit 1
        ;;
esac
