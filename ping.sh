#!/bin/sh

TARGET="$1"
LOG_TIME=$(date '+%Y-%m-%d %H:%M:%S')

if ping -c 1 "$TARGET" > /dev/null 2>&1; then
  echo "$LOG_TIME - Ping to $TARGET: OK"
else
  echo "$LOG_TIME - Ping to $TARGET: FAILED"
fi
