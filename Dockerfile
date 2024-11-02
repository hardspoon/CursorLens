FROM ngrok/ngrok:latest

ENV PORT=80
ENV NGROK_URL=thankfully-innocent-llama.ngrok-free.app

CMD ["http", "${PORT}", "--authtoken=${NGROK_AUTHTOKEN}", "--url=${NGROK_URL}"]
