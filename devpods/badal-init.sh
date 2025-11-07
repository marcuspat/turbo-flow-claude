#!/bin/bash -x

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

ccr start &

if [[ ! -n "$(ccr status | grep 'Not Running')" ]] ; then
  echo ANTHROPIC_BASE_URL="http://127.0.0.1:3456" >> ${HOME}/.bash_profile
fi

exit 0
