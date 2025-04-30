#!/bin/bash

set -eou pipefail
exec > >(tee -ia cluster_hardening.log) 2>&1

LOCAL_TEMPLATES_DIR="/tmp/gcs-policy-files/templates"
LOCAL_CONSTRAINTS_DIR="/tmp/gcs-policy-files/constraints"

echo "Starting hardening script..."
gcloud container clusters get-credentials "$1" --region="$2"

# Applying Templates
FILES=$(ls $LOCAL_TEMPLATES_DIR)
for FILE in $FILES; do
  FILENAME=$(basename "$FILE")
  LOCAL_PATH="$LOCAL_TEMPLATES_DIR/$FILENAME"
  echo "$FILE"

  RESULT=$(kubectl apply -f "$LOCAL_PATH")
  echo "$RESULT"
done

# Applying Constraints
FILES=$(ls "$LOCAL_CONSTRAINTS_DIR")
for FILE in $FILES; do
  FILENAME=$(basename "$FILE")
  LOCAL_PATH="$LOCAL_CONSTRAINTS_DIR/$FILENAME"
  echo "$FILE"

  RESULT=$(kubectl apply -f "$LOCAL_PATH")
  echo "$RESULT"
done

echo "Script completed."

gsutil cp cluster_hardening.log gs://"$3"/logs/cluster_hardening.log
