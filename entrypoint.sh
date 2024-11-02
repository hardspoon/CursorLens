#!/bin/sh

if [ -z "$NGROK_AUTHTOKEN" ]; then
    echo "Error: NGROK_AUTHTOKEN is not set"
    exit 1
fi

if [ -n "$NGROK_URL" ]; then
    exec ngrok http --authtoken="$NGROK_AUTHTOKEN" --url="$NGROK_URL" "$PORT"
else
    exec ngrok http --authtoken="$NGROK_AUTHTOKEN" "$PORT"
fi
