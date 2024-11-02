FROM ngrok/ngrok:latest

# Install envsubst
RUN apk add --no-cache gettext

ENV RAILWAY_DOMAIN=faithful-simplicity-production.up.railway.app

WORKDIR /app
COPY --chmod=755 entrypoint.sh .
COPY ngrok.yml .

EXPOSE 4040

ENTRYPOINT ["./entrypoint.sh"]
