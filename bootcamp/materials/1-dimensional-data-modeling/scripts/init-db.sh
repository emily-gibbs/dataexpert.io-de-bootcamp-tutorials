#!/bin/bash
set -e

# Restore the dump file using pg_restore
pg_restore \
    -v \
    --no-owner \
    --no-privileges \
    -U $POSTGRES_USER \
    -d $POSTGRES_DB \
    bootcamp/materials/1-dimensional-data-modeling/data.dump

# Check if the path is a directory using the -d flag and
#  there are SQL files in the directory using the -f command
#   (the [] brackets are used for conditional expressions)
if [ -d bootcamp/materials/1-dimensional-data-modeling/homework ]; then
  echo "[SUCCESS]: Located homework directory"
  # Run any additional initialization scripts
    for f in bootcamp/materials/1-dimensional-data-modeling/homework/*.sql; do
      if [ -f "$f" ]; then
        echo "[SUCCESS] Running SQL file: $f"
        psql -U $POSTGRES_USER -d $POSTGRES_DB -f $f
      else
        echo "[INFO] No SQL file found inside the homework directory"
      fi
    done
else
    echo "[ERROR] Directory not found: bootcamp/materials/1-dimensional-data-modeling/homework/"
fi
