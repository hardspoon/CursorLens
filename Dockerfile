FROM ngrok/ngrok:latest

ENV PORT=80

COPY entrypoint.sh /app/entrypoint.sh
RUN chmod +x /app/entrypoint.sh

EXPOSE 80 4040

ENTRYPOINT ["/app/entrypoint.sh"]
