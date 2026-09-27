#!/bin/bash


#CONSTANTS
RED='\033[0;31m'
GREEN='\033[0;32m'
NC='\033[0m' # No Color / Reset

codeBearUrl=$1
githubUrl=$2

if [[ -z "$codeBearUrl" || -z "$githubUrl" ]]; then 
    echo -e "${RED}Some url is empty, validate your input ${NC}"
fi    

#GET CURRENT PATH
currentPath="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

#INIT GIT
echo -e "${GREEN} Initializing Git ${NC}"
git init

echo -e "${GREEN} Configuring Git ${NC}"

cat << EOF > ${currentPath}/.git/config
[core]
    repositoryformatversion = 0
    filemode = true
    bare = false
    logallrefupdates = true
    ignorecase = true
    precomposeunicode = true
[remote "origin"]
    url = ${codeBearUrl}
    fetch = +refs/heads/*:refs/remotes/origin/*
    url = ${githubUrl}
[branch "main"]
    remote = origin
    merge = refs/heads/main
EOF

git pull
echo -e "${GREEN} Done ${NC}"
