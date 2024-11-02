FROM ngrok/ngrok:latest

ENV RAILWAY_DOMAIN=faithful-simplicity-production.up.railway.app

WORKDIR /app
COPY --chmod=755 entrypoint.sh .

EXPOSE 4040

ENTRYPOINT ["./entrypoint.sh"]
