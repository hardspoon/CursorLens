# Railway Ngrok Service

This repository contains a Dockerfile and Railway configuration for running an Ngrok service that exposes SSH access through a secure tunnel.

## Features

- Automated Ngrok tunnel setup for SSH access
- Configurable region for optimal performance
- Secure root access with customizable password
- Railway-ready deployment configuration

## Setup Instructions

1. Fork this repository
2. Create a new project on [Railway](https://railway.app)
3. Connect your forked repository to Railway
4. Set the required environment variables:
   - `NGROK_TOKEN`: Your Ngrok authentication token
   - `REGION`: Desired Ngrok region (default: jp)

## Environment Variables

- `PORT`: The port to expose (default: 80)
- `NGROK_TOKEN`: Your Ngrok authentication token (required)
- `REGION`: Ngrok region for the tunnel (optional, default: jp)

## Usage

Once deployed, the service will:
1. Start an SSH server
2. Create an Ngrok tunnel to the SSH port
3. Display the SSH connection details in the logs

Default root password: `akashi520`

## Exposed Ports

The following ports are exposed:
80, 443, 3306, 4040, 5432, 5700, 5701, 5010, 6800, 6900, 8080, 8888, 9000

## Security Notice

Remember to change the default root password after first login for security purposes.
