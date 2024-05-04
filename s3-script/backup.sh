#!/bin/bash

# Define variables
SOURCE_BUCKET="source-bucket-name"
DEST_BUCKET="destination-bucket-name"
TIMESTAMP=$(date +"%Y%m%d%H%M%S")

# Create a backup of the S3 bucket
aws s3 sync s3://$SOURCE_BUCKET s3://$DEST_BUCKET/backup-$TIMESTAMP

# Optional: You can add additional commands to manage backups, like cleanup of old backups

echo "Backup of $SOURCE_BUCKET completed and saved to $DEST_BUCKET/backup-$TIMESTAMP"

