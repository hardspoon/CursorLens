# Railway Ngrok Service

This repository contains a Dockerfile and Railway configuration for running an Ngrok service that exposes a TCP tunnel on port 3000.

## Features

- Automated Ngrok tunnel setup for TCP connections
- Persistent netcat listener that automatically restarts
- Railway-ready deployment configuration
- Robust error handling and tunnel verification

## Setup Instructions

1. Fork this repository
2. Create a new project on [Railway](https://railway.app)
3. Connect your forked repository to Railway
4. Set the required environment variables:
   - `NGROK_TOKEN`: Your Ngrok authentication token (get it from https://dashboard.ngrok.com)

## Environment Variables

- `PORT`: The port to expose (default: 3000)
- `NGROK_TOKEN`: Your Ngrok authentication token (required)

## Usage

Once deployed, the service will:
1. Start ngrok with your auth token
2. Wait for the tunnel to be established
3. Display the connection details in the logs
4. Start a persistent netcat listener on port 3000

## Exposed Ports

The following ports are exposed:
- 3000: Main service port
- 4040: Ngrok web interface

## Testing the Connection

You can test the connection using netcat:
```bash
nc <ngrok-provided-host> <ngrok-provided-port>
```

## Troubleshooting

If you encounter issues:
1. Make sure your NGROK_TOKEN is correctly set in Railway
2. Wait at least 30 seconds after deployment for the tunnel to establish
3. Check the Railway logs for the connection details
4. If you see "Waiting for ngrok tunnel..." message, the service is still starting up

Note: The free tier of ngrok has some limitations. If you need additional features or connections, you may need to upgrade your ngrok account.
