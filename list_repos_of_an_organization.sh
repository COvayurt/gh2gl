#!/bin/bash

list_of_repo_file_name=$1
GITHUB_TOKEN=$2
GITHUB_HOSTNAME=$3
ORG=$4
API_URL="https://$GITHUB_HOSTNAME/api/v3/orgs/$ORG/repos"
PER_PAGE=500

next_url="$API_URL?per_page=$PER_PAGE"

while [ -n "$next_url" ]; do
  # Fetch the current page of results
  response=$(curl -s -H "Authorization: token $TOKEN" \
                    -H "Accept: application/vnd.github.v3+json" \
                    "$next_url")

  # Print repository names
  echo "$response" | jq '.[] | "\(.name) \(.id)"' >> $list_of_repo_file_name


  # Extract the URL for the next page from the 'Link' header
  next_url=$(curl -s -I -H "Authorization: token $TOKEN" \
                      -H "Accept: application/vnd.github.v3+json" \
                      "$next_url" | grep -o '<[^>]*>; rel="next"' | sed -e 's/^<//' -e 's/>; rel="next"//')
done
