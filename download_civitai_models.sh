#!/bin/bash

# Read the list of AIR IDs from civitai_AIR.txt
while IFS= read -r air_id; do
  # Construct the URL for downloading based on the AIR ID
  download_url="https://www.civitai.com/download?model_id=$air_id"

  # Download the model file using curl
  curl -OJL "$download_url"
done < civitai_AIR.txt

