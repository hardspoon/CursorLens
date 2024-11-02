FROM ngrok/ngrok:latest

ENV PORT=80
WORKDIR /app

COPY --chmod=755 entrypoint.sh .

EXPOSE 80 4040

ENTRYPOINT ["./entrypoint.sh"]
