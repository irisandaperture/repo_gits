#!/bin/bash

# Read the list of AIR IDs from air_ids.txt
while IFS= read -r air_id; do
  # Split AIR ID into model_id and model_version
  IFS='@' read -ra parts <<< "$air_id"
  model_id="${parts[0]}"
  model_version="${parts[1]}"

  # Construct the URL for downloading based on the AIR ID
  download_url="https://www.civitai.com/download?model_id=$model_id"

  # Extract the model name from the URL
  model_name=$(echo "$download_url" | awk -F'/' '{print $(NF-1)}')

  # Download the model file using curl with a custom filename
  curl -OJL "$download_url" -o "${model_name}_${model_id}_v${model_version}.zip"
done < civitai_AIR.txt

