FROM ngrok/ngrok:latest

# Install envsubst
RUN apt-get update && apt-get install -y gettext-base && rm -rf /var/lib/apt/lists/*

ENV RAILWAY_DOMAIN=faithful-simplicity-production.up.railway.app

WORKDIR /app
COPY --chmod=755 entrypoint.sh .
COPY ngrok.yml .

EXPOSE 4040

ENTRYPOINT ["./entrypoint.sh"]
