#!/bin/bash


FILE=$1
GIT_ORG_URL=$2

if [[ ! -f "$FILE" ]]; then
    echo "File not found!"
    exit 1
fi


while IFS= read -r repo
do
    # Process each line
    echo "Analyzing $repo repo"
    checkout_url=$GIT_ORG_URL/$repo.git
    git clone $checkout_url
    cd $repo

    echo '\n'

    git rev-list --objects --all \
    | git cat-file --batch-check='%(objecttype) %(objectname) %(objectsize) %(rest)' \
    | sed -n 's/^blob //p' \
    | sort --numeric-sort --key=2 \
    | tail -n 10 \
    | cut -c 1-12,41- \
    | $(command -v gnumfmt || echo numfmt) --field=2 --to=iec-i --suffix=B --padding=7 --round=nearest

    cd ..
    rm -rf $repo
    echo '\n\n-----------------------\n\n'

done < "$FILE"



