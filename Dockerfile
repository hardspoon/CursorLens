FROM ngrok/ngrok:latest

ENV PORT=3000

# Create startup script
RUN echo '#!/bin/sh' > /start.sh \
    && echo '' >> /start.sh \
    && echo '# Verify auth token' >> /start.sh \
    && echo 'if [ -z "${NGROK_AUTHTOKEN}" ]; then' >> /start.sh \
    && echo '    echo "=======================================\n"' >> /start.sh \
    && echo '    echo "Error: NGROK_AUTHTOKEN is not set"' >> /start.sh \
    && echo '    echo "Please set the NGROK_AUTHTOKEN environment variable in Railway:"' >> /start.sh \
    && echo '    echo "1. Go to Railway dashboard"' >> /start.sh \
    && echo '    echo "2. Select your project"' >> /start.sh \
    && echo '    echo "3. Go to Variables"' >> /start.sh \
    && echo '    echo "4. Add NGROK_AUTHTOKEN with your token from https://dashboard.ngrok.com/get-started/your-authtoken"' >> /start.sh \
    && echo '    echo "\n======================================="' >> /start.sh \
    && echo '    exit 1' >> /start.sh \
    && echo 'fi' >> /start.sh \
    && echo '' >> /start.sh \
    && echo '# Start ngrok' >> /start.sh \
    && echo 'ngrok tcp ${PORT} --log=stdout' >> /start.sh \
    && chmod +x /start.sh

EXPOSE 3000 4040

CMD ["/start.sh"]
