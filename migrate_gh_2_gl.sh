#!/bin/bash

list_of_repo_file_name=$1
GITLAB_TOKEN=$2
GITHUB_TOKEN=$3
GITLAB_HOSTNAME=$4
GITHUB_HOSTNAME=$5
TARGET_NAMESPACE=$6



while IFS= read -r line
do

  repo_name=$(echo "$line" | awk '{ print $1}')
  repo_id=$(echo "$line" | awk '{ print $2}')
  echo "Importing $repo_name / $repo_id into $TARGET_NAMESPACE/$repo_name"

  data=$(printf '{
    "personal_access_token": "%s",
    "repo_id": "%s",
    "target_namespace": "%s",
    "new_name": "%s",
    "github_hostname": "https://%s/api/v3",
    "optional_stages": {
      "single_endpoint_notes_import": true,
      "attachments_import": true,
      "collaborators_import": true
    }
}' "$GITHUB_TOKEN" "$repo_id" "$TARGET_NAMESPACE" "$repo_name" "$GITHUB_HOSTNAME")

  echo $data

  curl -k --request POST \
  --url "https://$GITLAB_HOSTNAME/api/v4/import/github" \
  --header "content-type: application/json" \
  --header "Authorization: Bearer $GITLAB_TOKEN" \
  --data "$data" | jq

  echo "-----------------"
done < "$list_of_repo_file_name"

mv $list_of_repo_file_name migrated_$list_of_repo_file_name



