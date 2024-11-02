# Railway Ngrok Service

This repository contains a Dockerfile and Railway configuration for running an Ngrok service that exposes a TCP tunnel on port 3000.

## Features

- Automated Ngrok tunnel setup for TCP connections
- Configurable region for optimal performance
- Simple netcat listener on port 3000
- Railway-ready deployment configuration

## Setup Instructions

1. Fork this repository
2. Create a new project on [Railway](https://railway.app)
3. Connect your forked repository to Railway
4. Set the required environment variables:
   - `NGROK_TOKEN`: Your Ngrok authentication token (get it from https://dashboard.ngrok.com)
   - `REGION`: Desired Ngrok region (default: jp)

## Environment Variables

- `PORT`: The port to expose (default: 3000)
- `NGROK_TOKEN`: Your Ngrok authentication token (required)
- `REGION`: Ngrok region for the tunnel (optional, default: jp)

## Usage

Once deployed, the service will:
1. Start a netcat listener on port 3000
2. Create an Ngrok tunnel to port 3000
3. Display the connection details in the logs

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

If you see ERR_NGROK_8012, make sure:
1. Your NGROK_TOKEN is correctly set in Railway
2. The service has fully started up (wait a few seconds after deployment)
3. The region you've selected is available for your ngrok account
