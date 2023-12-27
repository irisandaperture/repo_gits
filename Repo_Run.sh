#!/bin/bash

# Read the list of URLs from civitai_urls.txt
while IFS= read -r url; do
  # Visit the URL and extract the AIR ID using curl and grep
  air_id=$(curl -s "$url" | grep -o 'AIR ID: [^ ]*' | awk '{print $3}')

  if [ -n "$air_id" ]; then
    # Construct the URL for downloading based on the extracted AIR ID
    download_url="https://www.civitai.com/download?model_id=$air_id"

    # Download the model file using curl
    curl -OJL "$download_url"
  else
    echo "AIR ID not found on $url"
  fi
done < civitai_urls.txt
