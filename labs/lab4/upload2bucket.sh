#!/bin/bash

# Uploads a file (image, PDF, etc.) to a private bucket.
# Presigns a URL to that file with an expiration of 604800 (7 days).
# Write the script so that it takes three positional arguments: The name of the local file to upload, the name of the bucket in your account, and the length of expiration in seconds.
set -e

if [ $# -eq 3 ]; then
    echo "Uploading file $1 into bucket $2 and presigning an URL for $3 seconds"
else
    echo "Error: expected 3 arguments, but ended up with $#"
    echo "Hint: Run ./upload2bucket.sh [FILE] [BUCKET] [SECONDS]"
fi

/usr/local/bin/aws s3 cp $1 s3://$2/

/usr/local/bin/aws s3 presign --expires-in $3 s3://$2/$1


