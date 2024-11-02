FROM ngrok/ngrok:latest

ENV PORT=80

# Create startup script
RUN echo '#!/bin/sh' > /entrypoint.sh \
    && echo 'if [ -z "$NGROK_AUTHTOKEN" ]; then' >> /entrypoint.sh \
    && echo '    echo "Error: NGROK_AUTHTOKEN is not set"' >> /entrypoint.sh \
    && echo '    exit 1' >> /entrypoint.sh \
    && echo 'fi' >> /entrypoint.sh \
    && echo '' >> /entrypoint.sh \
    && echo 'if [ -n "$NGROK_URL" ]; then' >> /entrypoint.sh \
    && echo '    exec ngrok http --authtoken="$NGROK_AUTHTOKEN" --url="$NGROK_URL" "$PORT"' >> /entrypoint.sh \
    && echo 'else' >> /entrypoint.sh \
    && echo '    exec ngrok http --authtoken="$NGROK_AUTHTOKEN" "$PORT"' >> /entrypoint.sh \
    && echo 'fi' >> /entrypoint.sh \
    && chmod +x /entrypoint.sh

EXPOSE 80 4040

ENTRYPOINT ["/entrypoint.sh"]
