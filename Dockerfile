FROM ubuntu

ARG NGROK_TOKEN
ENV NGROK_TOKEN=${NGROK_TOKEN}
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
    && echo 'if [ -z "$NGROK_TOKEN" ]; then' >> /start.sh \
    && echo '    echo "Error: NGROK_TOKEN is not set"' >> /start.sh \
    && echo '    exit 1' >> /start.sh \
    && echo 'fi' >> /start.sh \
    && echo '' >> /start.sh \
    && echo '# Setup ngrok configuration' >> /start.sh \
    && echo 'mkdir -p /root/.ngrok2' >> /start.sh \
    && echo 'echo "authtoken: $NGROK_TOKEN" > /root/.ngrok2/ngrok.yml' >> /start.sh \
    && echo 'echo "version: 2" >> /root/.ngrok2/ngrok.yml' >> /start.sh \
    && echo 'echo "region: us" >> /root/.ngrok2/ngrok.yml' >> /start.sh \
    && echo '' >> /start.sh \
    && echo '# Start ngrok' >> /start.sh \
    && echo '/ngrok tcp 3000 --log=stdout > /var/log/ngrok.log 2>&1 &' >> /start.sh \
    && echo '' >> /start.sh \
    && echo '# Wait for tunnel' >> /start.sh \
    && echo 'echo "Waiting for ngrok to start..."' >> /start.sh \
    && echo 'sleep 5' >> /start.sh \
    && echo '' >> /start.sh \
    && echo '# Monitor tunnel status' >> /start.sh \
    && echo 'while true; do' >> /start.sh \
    && echo '    if curl -s localhost:4040/api/tunnels | python3 -c "import sys, json; tunnels=json.load(sys.stdin); print(tunnels[\"tunnels\"][0][\"public_url\"] if tunnels[\"tunnels\"] else \"\")" 2>/dev/null | grep -q "tcp://"; then' >> /start.sh \
    && echo '        echo "Ngrok tunnel established:"' >> /start.sh \
    && echo '        curl -s localhost:4040/api/tunnels | python3 -c "import sys, json; print(json.load(sys.stdin)[\"tunnels\"][0][\"public_url\"])"' >> /start.sh \
    && echo '        break' >> /start.sh \
    && echo '    fi' >> /start.sh \
    && echo '    echo "Waiting for tunnel..."' >> /start.sh \
    && echo '    sleep 2' >> /start.sh \
    && echo 'done' >> /start.sh \
    && echo '' >> /start.sh \
    && echo '# Start netcat listener' >> /start.sh \
    && echo 'while true; do' >> /start.sh \
    && echo '    echo "Starting netcat listener on port 3000..."' >> /start.sh \
    && echo '    nc -l -p 3000' >> /start.sh \
    && echo '    sleep 1' >> /start.sh \
    && echo 'done' >> /start.sh \
    && chmod +x /start.sh

EXPOSE 3000 4040

CMD ["/start.sh"]
