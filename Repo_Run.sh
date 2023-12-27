#!/bin/bash

# Read the list of git clone commands from git_clones.txt
while IFS= read -r repo_url; do
  # Extract repository name from URL
  repo_name=$(basename "$repo_url" .git)

  echo "Cloning $repo_url..."
  git clone "$repo_url" "$repo_name"

  # Check if the repository directory exists
  if [ -d "$repo_name" ]; then
    # Move into the repository directory
    cd "$repo_name" || continue

    # Execute additional commands
    pip install -r requirements.txt
    git reset --hard && git pull

    # Move back to the original directory
    cd ..
  else
    echo "Error: Repository directory '$repo_name' not found."
  fi
done < git_clones.txt
