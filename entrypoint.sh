#!/bin/sh

if [ -z "$NGROK_AUTHTOKEN" ]; then
    echo "Error: NGROK_AUTHTOKEN is not set"
    exit 1
fi

if [ -z "$RAILWAY_DOMAIN" ]; then
    echo "Error: RAILWAY_DOMAIN is not set"
    exit 1
fi

# Create config with variables replaced
sed "s|\${NGROK_AUTHTOKEN}|$NGROK_AUTHTOKEN|g" /app/ngrok.yml > /app/ngrok.yml.tmp
sed "s|\${RAILWAY_DOMAIN}|$RAILWAY_DOMAIN|g" /app/ngrok.yml.tmp > /app/ngrok.yml.tmp2
sed "s|\${NGROK_URL}|$NGROK_URL|g" /app/ngrok.yml.tmp2 > /app/ngrok.yml.final
rm /app/ngrok.yml.tmp /app/ngrok.yml.tmp2

# Start ngrok with config file
exec ngrok start --config=/app/ngrok.yml.final --all
