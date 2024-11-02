FROM ubuntu

ENV DEBIAN_FRONTEND=noninteractive

RUN apt update && apt install -y \
    ssh wget unzip vim curl python3 netcat-traditional

# Download and install ngrok
RUN wget -q https://bin.equinox.io/c/bNyj1mQVY4c/ngrok-v3-stable-linux-amd64.zip -O /ngrok-v3-stable-linux-amd64.zip \
    && cd / && unzip ngrok-v3-stable-linux-amd64.zip \
    && chmod +x ngrok \
    && rm ngrok-v3-stable-linux-amd64.zip

# Create startup script
RUN echo '#!/bin/bash' > /start.sh \
    && echo '' >> /start.sh \
    && echo '# Verify NGROK_TOKEN' >> /start.sh \
    && echo 'if [ -z "${NGROK_TOKEN}" ]; then' >> /start.sh \
    && echo '    echo "=======================================\n"' >> /start.sh \
    && echo '    echo "Error: NGROK_TOKEN is not set"' >> /start.sh \
    && echo '    echo "Please set the NGROK_TOKEN environment variable in Railway:"' >> /start.sh \
    && echo '    echo "1. Go to Railway dashboard"' >> /start.sh \
    && echo '    echo "2. Select your project"' >> /start.sh \
    && echo '    echo "3. Go to Variables"' >> /start.sh \
    && echo '    echo "4. Add NGROK_TOKEN with your token from https://dashboard.ngrok.com/get-started/your-authtoken"' >> /start.sh \
    && echo '    echo "\n======================================="' >> /start.sh \
    && echo '    exit 1' >> /start.sh \
    && echo 'fi' >> /start.sh \
    && echo '' >> /start.sh \
    && echo '# Setup ngrok configuration' >> /start.sh \
    && echo 'mkdir -p /root/.ngrok2' >> /start.sh \
    && echo 'cat > /root/.ngrok2/ngrok.yml << EOL' >> /start.sh \
    && echo 'version: "2"' >> /start.sh \
    && echo 'authtoken: ${NGROK_TOKEN}' >> /start.sh \
    && echo 'console_ui: false' >> /start.sh \
    && echo 'log_level: info' >> /start.sh \
    && echo 'region: us' >> /start.sh \
    && echo 'EOL' >> /start.sh \
    && echo '' >> /start.sh \
    && echo '# Verify configuration' >> /start.sh \
    && echo 'if ! /ngrok verify; then' >> /start.sh \
    && echo '    echo "Error: Invalid NGROK_TOKEN"' >> /start.sh \
    && echo '    exit 1' >> /start.sh \
    && echo 'fi' >> /start.sh \
    && echo '' >> /start.sh \
    && echo '# Start ngrok' >> /start.sh \
    && echo 'echo "Starting ngrok tunnel..."' >> /start.sh \
    && echo '/ngrok tcp 3000 --log=stdout > /var/log/ngrok.log 2>&1 &' >> /start.sh \
    && echo 'sleep 5' >> /start.sh \
    && echo '' >> /start.sh \
    && echo '# Monitor tunnel status' >> /start.sh \
    && echo 'RETRY_COUNT=0' >> /start.sh \
    && echo 'MAX_RETRIES=10' >> /start.sh \
    && echo 'while [ $RETRY_COUNT -lt $MAX_RETRIES ]; do' >> /start.sh \
    && echo '    if curl -s localhost:4040/api/tunnels | python3 -c "import sys, json; tunnels=json.load(sys.stdin); print(tunnels[\"tunnels\"][0][\"public_url\"] if tunnels[\"tunnels\"] else \"\")" 2>/dev/null | grep -q "tcp://"; then' >> /start.sh \
    && echo '        echo "✅ Ngrok tunnel established:"' >> /start.sh \
    && echo '        curl -s localhost:4040/api/tunnels | python3 -c "import sys, json; print(json.load(sys.stdin)[\"tunnels\"][0][\"public_url\"])"' >> /start.sh \
    && echo '        break' >> /start.sh \
    && echo '    fi' >> /start.sh \
    && echo '    RETRY_COUNT=$((RETRY_COUNT+1))' >> /start.sh \
    && echo '    echo "Waiting for tunnel... (Attempt $RETRY_COUNT/$MAX_RETRIES)"' >> /start.sh \
    && echo '    sleep 2' >> /start.sh \
    && echo 'done' >> /start.sh \
    && echo '' >> /start.sh \
    && echo 'if [ $RETRY_COUNT -eq $MAX_RETRIES ]; then' >> /start.sh \
    && echo '    echo "❌ Failed to establish ngrok tunnel after $MAX_RETRIES attempts"' >> /start.sh \
    && echo '    exit 1' >> /start.sh \
    && echo 'fi' >> /start.sh \
    && echo '' >> /start.sh \
    && echo '# Start netcat listener' >> /start.sh \
    && echo 'echo "🚀 Starting netcat listener on port 3000..."' >> /start.sh \
    && echo 'while true; do' >> /start.sh \
    && echo '    nc -l -p 3000' >> /start.sh \
    && echo '    sleep 1' >> /start.sh \
    && echo 'done' >> /start.sh \
    && chmod +x /start.sh

EXPOSE 3000 4040

CMD ["/start.sh"]
