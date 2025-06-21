#!/bin/bash

set -euo pipefail

# Expects environment variables:
# - TS_API_CLIENT_ID
# - TS_API_CLIENT_SECRET

# Configuration for each host
# Format: "hostname|tags|ephemeral|reusable"
# where:
#   hostname = name of the host
#   tags = comma-separated list of tags (use "none" for no tags)
#   ephemeral = true/false
#   reusable = true/false

HOSTS=(
  #name|tags|ephemeral?
  "marlon|tag:server|false"
  "roland|tag:server|true"
  "tuffy-use-ora-01|tag:server|false"
  "vic|tag:server|false"
  "spencer|tag:server|false"
)

for host_config in "${HOSTS[@]}"; do
  # Parse host configuration
  IFS='|' read -r hostname tags ephemeral <<< "$host_config"
  
  echo "Retrieving new tailscale auth key for host $hostname"
  
  cmd_options=""
  
  # Tags are mandatory
  cmd_options="$cmd_options -tags $tags"
  
  # Add ephemeral flag if specified
  if [ "$ephemeral" = "true" ]; then
    cmd_options="$cmd_options -ephemeral"
  fi
  
  # Always add reusable and preauth flags
  cmd_options="$cmd_options -reusable -preauth"
  
  # Save to the host's tailscale config directory
  output_file="hosts/$hostname/tailscale/authkey.+$hostname.enc"
  
  command="get-authkey $cmd_options | sops encrypt --filename-override '$output_file' --input-type binary >'$output_file'"
  
  eval "$command"
done

