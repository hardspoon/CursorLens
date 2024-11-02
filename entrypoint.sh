#!/bin/sh

if [ -z "$NGROK_AUTHTOKEN" ]; then
    echo "Error: NGROK_AUTHTOKEN is not set"
    exit 1
fi

# Use Railway domain as upstream
if [ -n "$RAILWAY_DOMAIN" ]; then
    exec ngrok http --authtoken="$NGROK_AUTHTOKEN" --hostname="$NGROK_URL" "http://${RAILWAY_DOMAIN}:4040"
else
    echo "Error: RAILWAY_DOMAIN is not set"
    exit 1
fi
