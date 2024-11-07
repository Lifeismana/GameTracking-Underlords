#!/bin/bash

set -eu

[ -n "$GIT_NAME" ] && git config --global user.name "$GIT_NAME"
[ -n "$GIT_EMAIL" ] && git config --global user.email "$GIT_EMAIL"
[ -n "$GPG_KEY" ] && gpg --batch --import <( echo "$GPG_KEY")
[ -n "$GPG_KEY_ID" ] && git config --global user.signingkey "$GPG_KEY_ID"

echo ".DepotDownloader" >> ~/.gitignore && \
git config --global core.excludesfile ~/.gitignore && \

[ ! -d ~/ValveProtobufs ] && ln -s /data/ValveProtobufs ~/ValveProtobufs

cd /data/GameTracking

git clone --branch $GITHUB_REF_NAME --single-branch https://$GITHUB_APP_ID:$GITHUB_TOKEN@github.com/$GITHUB_REPOSITORY.git underlords

cd underlords

/data/DepotDownloader/DepotDownloader -username "$STEAM_USERNAME" -password "$STEAM_PASSWORD" -app 1046930 -all-platforms -depot 1046935 -validate -dir . -filelist "/data/list/1046935.txt"
/data/DepotDownloader/DepotDownloader -username "$STEAM_USERNAME" -password "$STEAM_PASSWORD" -app 1046930 -all-platforms -depot 1046931 -validate -dir . -filelist "/data/list/1046931.txt"
/data/DepotDownloader/DepotDownloader -username "$STEAM_USERNAME" -password "$STEAM_PASSWORD" -app 1046930 -all-platforms -depot 1046934 -validate -dir . -filelist "/data/list/1046934.txt"

./update.sh