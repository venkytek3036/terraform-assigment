# Overview

Shell script executed via cron or another scheduling mechanism. Here's a simple shell script to perform regular backups of an S3 bucket

```
#!/bin/bash

# Define variables
SOURCE_BUCKET="source-bucket-name"
DEST_BUCKET="destination-bucket-name"
TIMESTAMP=$(date +"%Y%m%d%H%M%S")

# Create a backup of the S3 bucket
aws s3 sync s3://$SOURCE_BUCKET s3://$DEST_BUCKET/backup-$TIMESTAMP

# Optional: You can add additional commands to manage backups, like cleanup of old backups

echo "Backup of $SOURCE_BUCKET completed and saved to $DEST_BUCKET/backup-$TIMESTAMP"

```

Save this script to a file ```(e.g., s3_backup.sh)```, make it executable with ```chmod +x s3_backup.sh```, and then you can run it to create a backup of your S3 bucket. You can schedule this script to run periodically using cron.


To set up a cron job to run the script daily, for example, you can edit your crontab using the command ```crontab -e``` and add a line like this:

```
0 0 * * * /path/to/s3_backup.sh
```

This will run the script ```/path/to/s3_backup.sh``` every day at midnight. Adjust the timing according to your backup frequency requirements.

