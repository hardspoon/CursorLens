FROM node:18-alpine

WORKDIR /app

RUN apk add --no-cache libc6-compat wget tar
RUN apk update

# Install pnpm
RUN npm install -g pnpm

# Install ngrok
RUN wget https://bin.equinox.io/c/bNyj1mQVY4c/ngrok-v3-stable-linux-amd64.tgz \
    && tar xvzf ngrok-v3-stable-linux-amd64.tgz -C /usr/local/bin \
    && rm ngrok-v3-stable-linux-amd64.tgz

# Copy package.json and pnpm-lock.yaml
COPY package.json pnpm-lock.yaml ./

# Install dependencies
RUN pnpm install

# Copy the rest of the application
COPY . .

# Generate Prisma Client
RUN pnpm prisma generate

# Build the application
RUN pnpm run build

# Expose the application and ngrok ports
EXPOSE 3000 4040

# Create start script with proper line endings and path
RUN printf '#!/bin/sh\ncd /app\nngrok http 3000 --log stdout & sh ./start.sh\n' > /app/start-with-ngrok.sh \
    && chmod +x /app/start-with-ngrok.sh

# Start both ngrok and the application
ENTRYPOINT ["/bin/sh", "/app/start-with-ngrok.sh"]
