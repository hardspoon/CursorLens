FROM ubuntu

ARG NGROK_TOKEN
ARG REGION=jp
ENV DEBIAN_FRONTEND=noninteractive

RUN apt update && apt install -y \
    ssh wget unzip vim curl python3 netcat-traditional

RUN wget -q https://bin.equinox.io/c/bNyj1mQVY4c/ngrok-v3-stable-linux-amd64.zip -O /ngrok-v3-stable-linux-amd64.zip \
    && cd / && unzip ngrok-v3-stable-linux-amd64.zip \
    && chmod +x ngrok

RUN mkdir /run/sshd \
    && echo "#!/bin/bash" > /openssh.sh \
    && echo "/ngrok tcp --authtoken ${NGROK_TOKEN} 3000 &" >> /openssh.sh \
    && echo "sleep 10" >> /openssh.sh \
    && echo "while true; do" >> /openssh.sh \
    && echo "  TUNNELS=\$(curl -s http://localhost:4040/api/tunnels)" >> /openssh.sh \
    && echo "  if [ \$? -eq 0 ]; then" >> /openssh.sh \
    && echo "    echo \"\$TUNNELS\" | python3 -c \"import sys, json; print('连接命令:\\n', 'connect to '+json.load(sys.stdin)['tunnels'][0]['public_url'])\" && break" >> /openssh.sh \
    && echo "  else" >> /openssh.sh \
    && echo "    echo 'Waiting for ngrok tunnel...' && sleep 5" >> /openssh.sh \
    && echo "  fi" >> /openssh.sh \
    && echo "done" >> /openssh.sh \
    && echo "while true; do nc -l -p 3000; done" >> /openssh.sh \
    && chmod 755 /openssh.sh

EXPOSE 3000 4040

CMD ["/bin/bash", "/openssh.sh"]
