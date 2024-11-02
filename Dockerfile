FROM ubuntu

ARG NGROK_TOKEN
ARG REGION=jp
ENV DEBIAN_FRONTEND=noninteractive

RUN apt update && apt install -y \
    ssh wget unzip vim curl python3

RUN wget -q https://bin.equinox.io/c/bNyj1mQVY4c/ngrok-v3-stable-linux-amd64.zip -O /ngrok-v3-stable-linux-amd64.zip \
    && cd / && unzip ngrok-v3-stable-linux-amd64.zip \
    && chmod +x ngrok

RUN mkdir /run/sshd \
    && echo "/ngrok tcp --authtoken ${NGROK_TOKEN} --region ${REGION} 3000 &" >>/openssh.sh \
    && echo "sleep 5" >> /openssh.sh \
    && echo "curl -s http://localhost:4040/api/tunnels | python3 -c \"import sys, json; print(\\\"连接命令:\\\n\\\",\\\"connect to \\\"+json.load(sys.stdin)['tunnels'][0]['public_url'])\" || echo \"\nError：请检查NGROK_TOKEN变量是否存在，或Ngrok节点已被占用\n\"" >> /openssh.sh \
    && echo 'nc -l 3000' >>/openssh.sh \
    && chmod 755 /openssh.sh

EXPOSE 3000 4040

CMD /openssh.sh
