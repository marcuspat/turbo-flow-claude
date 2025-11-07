#!/bin/bash

ENVFILE=${1:-.devpod-envfile}

cat <<EOF > $ENVFILE
ANTHROPIC_BASE_URL="http://127.0.0.1:3456"
ANTHROPIC_AUTH_TOKEN="any-key-will-do"
GITHUB_TOKEN=$(gh auth token)
JIRA_API_TOKEN=$JIRA_API_TOKEN
CLOUDSDK_AUTH_ACCESS_TOKEN=$(gcloud beta auth print-identity-token)
