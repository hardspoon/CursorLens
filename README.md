# Railway Ngrok Service

This repository contains a Dockerfile and Railway configuration for running an Ngrok service that exposes a TCP tunnel on port 3000.

## Features

- Automated Ngrok tunnel setup for TCP connections
- Persistent netcat listener that automatically restarts
- Proper authentication token handling
- Robust error handling and tunnel verification

## Setup Instructions

1. Fork this repository
2. Create a new project on [Railway](https://railway.app)
3. Connect your forked repository to Railway
4. Set the required environment variable:
   - `NGROK_TOKEN`: Your Ngrok authentication token (get it from https://dashboard.ngrok.com)

## Environment Variables

- `NGROK_TOKEN`: Your Ngrok authentication token (required)
- `PORT`: The port to expose (default: 3000)

## Usage

Once deployed, the service will:
1. Configure ngrok with your authentication token
2. Start a TCP tunnel to port 3000
3. Wait for the tunnel to be established
4. Display the connection URL in the logs
5. Start a persistent netcat listener

## Testing the Connection

Once the service displays the connection URL, you can connect using:
```bash
nc <ngrok-host> <ngrok-port>
```

Example:
```bash
nc 0.tcp.ngrok.io 12345
```

## Troubleshooting

If you encounter issues:

1. Check the Railway logs for these common messages:
   - "Error: NGROK_TOKEN is not set" - Verify your environment variable is set
   - "Waiting for ngrok tunnel..." - Service is still starting up
   - "Connection URL: tcp://..." - Service is ready to use

2. Common solutions:
   - Wait at least 30 seconds after deployment for the tunnel to establish
   - Verify your NGROK_TOKEN is correctly set in Railway
   - Check the logs for any error messages
   - If the connection fails, try redeploying the service

Note: Free tier ngrok accounts have limitations on concurrent tunnels and connections. If you need more resources, consider upgrading your ngrok account.
