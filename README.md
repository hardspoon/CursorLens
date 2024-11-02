# Railway Ngrok Service

This repository contains a Dockerfile and Railway configuration for running an Ngrok service that exposes a TCP tunnel on port 3000.

## Ngrok Setup Process

The service automatically sets up ngrok using the following steps:

1. Downloads and installs ngrok v3
2. Creates ngrok configuration file at `/root/.ngrok2/ngrok.yml`
3. Configures authentication using the provided `NGROK_TOKEN`
4. Starts ngrok in TCP tunnel mode for port 3000
5. Verifies tunnel establishment via ngrok's API

## Setup Instructions

1. Get your ngrok authentication token:
   - Sign up at [ngrok.com](https://ngrok.com)
   - Go to [dashboard.ngrok.com/get-started/your-authtoken](https://dashboard.ngrok.com/get-started/your-authtoken)
   - Copy your authentication token

2. Deploy to Railway:
   - Fork this repository
   - Create a new project on [Railway](https://railway.app)
   - Connect your forked repository
   - Add your ngrok authentication token as `NGROK_TOKEN` in Railway's environment variables

## Environment Variables

- `NGROK_TOKEN`: Your ngrok authentication token (required)
- `PORT`: The port to expose (default: 3000)

## Usage

The service will automatically:
1. Configure ngrok with your authentication token
2. Start a TCP tunnel to port 3000
3. Display the tunnel URL in the logs
4. Start a netcat listener on port 3000

## Testing the Connection

Once the service displays the tunnel URL (format: `tcp://X.tcp.ngrok.io:XXXXX`), connect using:
```bash
nc X.tcp.ngrok.io XXXXX
```

## Troubleshooting

1. Verify ngrok setup:
   - Check Railway logs for "Ngrok tunnel established:"
   - If you see "Waiting for tunnel..." the service is still starting
   - Ensure your `NGROK_TOKEN` is correctly set

2. Common issues:
   - "Error: NGROK_TOKEN is not set" - Add the token to Railway environment variables
   - No tunnel URL - Wait 30 seconds for setup to complete
   - Connection refused - Make sure to use the correct host and port from the logs

3. Ngrok limitations:
   - Free accounts have restrictions on concurrent tunnels
   - Some features require a paid account
   - Check [ngrok pricing](https://ngrok.com/pricing) for details
