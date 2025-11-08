#!/bin/bash

curl https://packages.cloud.google.com/apt/doc/apt-key.gpg | sudo gpg --dearmor -o /usr/share/keyrings/cloud.google.gpg
echo "deb [signed-by=/usr/share/keyrings/cloud.google.gpg] https://packages.cloud.google.com/apt cloud-sdk main" | sudo tee -a /etc/apt/sources.list.d/google-cloud-sdk.list
sudo apt-get update && sudo apt-get -y install rsync google-cloud-cli google-cloud-cli-kubectl google-cloud-cli-kubectl-oidc google-cloud-cli-gke-gcloud-auth-plugin google-cloud-cli-cbt google-cloud-cli-nomos google-cloud-cli-anthos-auth google-cloud-cli-skaffold google-cloud-cli-config-connector || true

readonly DEVPOD_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

echo "Adding additional badal skills"
if [[ -d "$DEVPOD_DIR/additional-skills" ]] ; then
  rsync -av $DEVPOD_DIR/additional-skills/ ${HOME}/.claude/skills/
fi

npm -g install @musistudio/claude-code-router

mkdir -p $HOME/.claude-code-router

cat << EOF > ${HOME}/.claude-code-router/config.json
{
  "APIKEY": "any-key-will-do",
  "LOG": true,
  "Providers": [
    {
      "name": "fuelix-anthropic",
      "api_base_url": "https://api.fuelix.ai/v1/chat/completions",
      "api_key": "sk-0cCu3sbFELhqUGF3gLh7Yx",
      "models": [
        "claude-sonnet-4-5"
      ],
      "transformer": {
       "use": [
        "maxtoken",
        {
          "max_tokens": 200000
        }
       ]
      }
    },
    {
      "name": "fuelix-google",
      "api_base_url": "https://api.fuelix.ai/v1/chat/completions",
      "api_key": "${FUELIX_AUTH_TOKEN}",
      "models": [
        "gemini-2.5-flash",
        "gemini-2.5-pro"
      ],
      "transformer": {
        "use": [
           "gemini",
           "maxtoken",
             {
              "max_tokens": 200000
             }
            ]
      }
    }
  ],
  "Router": {
    "default": "fuelix-anthropic,claude-sonnet-4-5",
    "thinking": "fuelix-anthropic,claude-sonnet-4-5",
    "CodeWhisperer": "fuelix-anthropic,claude-sonnet-4-5",
    "longContext": "fuelix-anthropic,claude-sonnet-4-5",
    "background": "fuelix-anthropic,claude-sonnet-4-5"
  }
}
EOF

ccr start < /dev/null > /dev/null 2>&1 &

exit 0
