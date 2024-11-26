#!/bin/bash

# Function to check if a command exists
command_exists () {
  command -v "$1" >/dev/null 2>&1
}

# Check if jsonnet is installed
if ! command_exists jsonnet; then
  echo "Error: jsonnet is not installed."
  exit 1
fi

# Check if jq is installed
if ! command_exists jq; then
  echo "Error: jq is not installed."
  exit 1
fi

# Check if yq is installed
if ! command_exists yq; then
  echo "Error: yq is not installed."
  exit 1
fi

# Create the directory if it doesn't exist
mkdir -p generated_manifests

# Generate the JSON output from the Jsonnet file
jsonnet main.jsonnet -o generated_manifests/output.json

# Parse the JSON output and create individual YAML files
jq -c '.[]' generated_manifests/output.json | while read -r item; do
  # Extract the file name and content
  filename=$(echo "$item" | jq -r '.name')
  content=$(echo "$item" | jq -r '.content')

  # Convert content JSON to YAML and save to file
  echo "$content" | yq -P - > "generated_manifests/$filename"
done
