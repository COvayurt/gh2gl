#!/bin/bash

GITHUB_TOKEN=$1
REPO_OWNER=$2
REPO_NAME=$3
$GITHUB_HOSTNAME=$4

# Function to get the total number of comments from a given URL
get_comments_count() {
    local url=$1
    local total_count=0
    local page=1
    local per_page=100

    while :; do
        response=$(curl -s -H "Authorization: token ${GITHUB_TOKEN}" -H "Accept: application/vnd.github+json" "${url}?page=${page}&per_page=${per_page}")
        count=$(echo "$response" | jq '. | length')
        total_count=$((total_count + count))
        echo Found $count in $page page
        # Break the loop if the current response is empty
        if [ "$count" -eq "0" ]; then
            break
        fi

        page=$((page + 1))
    done

    echo $total_count
}


echo Counting comments in PRs
# Get pull request comments count
pr_comments_count=$(get_comments_count "https://$GITHUB_HOSTNAME/api/v3/repos/${REPO_OWNER}/${REPO_NAME}/pulls/comments")
# Get issue comments count
issue_comments_count=$(get_comments_count "https://$GITHUB_HOSTNAME/api/v3/repos/${REPO_OWNER}/${REPO_NAME}/issues/comments")

total_comments_count=$issue_comments_count+$pr_comments_count

echo "Total comments in the project: issue comments: $issue_comments_count + PR comments: $pr_comments_count = total comments $total_comments_count"
