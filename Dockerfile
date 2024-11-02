FROM ubuntu

ARG NGROK_TOKEN
ENV NGROK_TOKEN=${NGROK_TOKEN}
ENV DEBIAN_FRONTEND=noninteractive

RUN apt update && apt install -y \
    ssh wget unzip vim curl python3 netcat-traditional

RUN wget -q https://bin.equinox.io/c/bNyj1mQVY4c/ngrok-v3-stable-linux-amd64.zip -O /ngrok-v3-stable-linux-amd64.zip \
    && cd / && unzip ngrok-v3-stable-linux-amd64.zip \
    && chmod +x ngrok

RUN echo '#!/bin/bash' > /start.sh \
    && echo 'if [ -z "$NGROK_TOKEN" ]; then' >> /start.sh \
    && echo '    echo "Error: NGROK_TOKEN is not set"' >> /start.sh \
    && echo '    exit 1' >> /start.sh \
    && echo 'fi' >> /start.sh \
    && echo '/ngrok config add-authtoken $NGROK_TOKEN' >> /start.sh \
    && echo '/ngrok tcp 3000 > /var/log/ngrok.log 2>&1 &' >> /start.sh \
    && echo 'sleep 10' >> /start.sh \
    && echo 'while true; do' >> /start.sh \
    && echo '    TUNNELS=$(curl -s http://localhost:4040/api/tunnels)' >> /start.sh \
    && echo '    if echo "$TUNNELS" | python3 -c "import sys, json; json.load(sys.stdin)" 2>/dev/null; then' >> /start.sh \
    && echo '        echo "$TUNNELS" | python3 -c "import sys, json; print(\"Connection URL:\", json.load(sys.stdin)[\"tunnels\"][0][\"public_url\"])"' >> /start.sh \
    && echo '        break' >> /start.sh \
    && echo '    else' >> /start.sh \
    && echo '        echo "Waiting for ngrok tunnel..."' >> /start.sh \
    && echo '        sleep 5' >> /start.sh \
    && echo '    fi' >> /start.sh \
    && echo 'done' >> /start.sh \
    && echo 'while true; do' >> /start.sh \
    && echo '    nc -l -p 3000' >> /start.sh \
    && echo '    sleep 1' >> /start.sh \
    && echo 'done' >> /start.sh \
    && chmod +x /start.sh

EXPOSE 3000 4040

CMD ["/start.sh"]
