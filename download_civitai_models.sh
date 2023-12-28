#!/bin/bash

# Define the URL prefix for the civitai.com models
BASE_URL="https://civitai.com/models/"

# Specify the file containing the list of models
MODEL_LIST_FILE="civit_models.txt"

# Create a directory to store the downloaded models
mkdir -p civit_models

# Change to the directory where the models will be downloaded
cd civit_models

# Use wget to download each model listed in the text file
while IFS= read -r model_info || [ -n "$model_info" ]; do
    model_url="${BASE_URL}${model_info}"

    # Extract model and version information from the URL
    model_name=$(echo "$model_info" | cut -d'/' -f3)
    version=$(echo "$model_info" | grep -oP '(?<=modelVersionId=)\d+')

    # Construct the filename based on model and version
    filename="${model_name}_${version}.zip"

    # Download the model and save it with the constructed filename
    wget -O "$filename" "$model_url"
done < "../$MODEL_LIST_FILE"

# Return to the original directory
cd ..

