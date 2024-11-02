#!/bin/sh

if [ -z "$NGROK_AUTHTOKEN" ]; then
    echo "Error: NGROK_AUTHTOKEN is not set"
    exit 1
fi

if [ -z "$RAILWAY_DOMAIN" ]; then
    echo "Error: RAILWAY_DOMAIN is not set"
    exit 1
fi

# Replace environment variables in config
envsubst < /app/ngrok.yml > /app/ngrok.yml.tmp
mv /app/ngrok.yml.tmp /app/ngrok.yml

# Start ngrok with config file
exec ngrok start --config=/app/ngrok.yml --all
