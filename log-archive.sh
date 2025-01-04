#!/bin/bash

# Check if the log directory is provided
if [ -z "$1" ]; then
    echo "Usage: $0 <Log-directory>"
    exit 1
fi

LOG_DIR="$1"

# Check if the log directory exists
if [ ! -d "$LOG_DIR" ]; then
    echo "Error: Directory $LOG_DIR does not exist."
    exit 1
fi

# Directory to store archives
ARCHIVE_DIR="/var/log/archives"
mkdir -p "$ARCHIVE_DIR"

# Generate timestamp
TIMESTAMP=$(date +"%Y-%m-%d_%H-%M-%S")

# Create archive file name
ARCHIVE_FILE="logs_$TIMESTAMP.tar.gz"

# Compress the logs
tar -czf "$ARCHIVE_DIR/$ARCHIVE_FILE" -C "$(dirname $LOG_DIR)" "$(basename $LOG_DIR)"

# Log the archive action
echo "Archived $LOG_DIR to $ARCHIVE_DIR/$ARCHIVE_FILE at $TIMESTAMP" >> /var/log/archive.log

echo "Log archive completed successfully."
