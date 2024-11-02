# Railway Ngrok Service

This repository contains a configuration for running an Ngrok HTTP tunnel service that forwards to a Railway domain using a single ngrok session.

## ⚠️ Important: Environment Variables

Before deploying, you must set up these environment variables:

1. `NGROK_AUTHTOKEN`:
   - Get from [dashboard.ngrok.com/get-started/your-authtoken](https://dashboard.ngrok.com/get-started/your-authtoken)

2. `RAILWAY_DOMAIN`:
   - Your Railway domain (e.g., your-app.up.railway.app)

3. `NGROK_URL`:
   - Your custom ngrok domain (e.g., your-domain.ngrok-free.app)

## How It Works

This service:
1. Uses a single ngrok session to avoid the concurrent session limit
2. Creates a configuration file for the tunnel
3. Connects to your Railway domain on port 4040
4. Makes it available via your custom domain

## Setup Instructions

1. Fork this repository
2. Create a new project on [Railway](https://railway.app)
3. Connect your forked repository
4. Add environment variables:
   - `NGROK_AUTHTOKEN`: Your ngrok auth token
   - `RAILWAY_DOMAIN`: Your Railway domain
   - `NGROK_URL`: Your custom ngrok domain
5. Deploy the service

## Testing

Once deployed, your service will be available at your custom domain specified in NGROK_URL. The service will forward all traffic to your Railway domain on port 4040.

## Troubleshooting

1. Session Limit Issues:
   - This configuration uses a single session to avoid limits
   - Check active sessions at dashboard.ngrok.com/agents
   - Kill any unnecessary sessions if needed

2. Connection Issues:
   - Verify your Railway domain is correct
   - Ensure port 4040 is accessible
   - Check ngrok logs for connection errors

3. Domain Issues:
   - Verify your custom domain in ngrok dashboard
   - Ensure CNAME is properly configured
   - Check domain status in ngrok dashboard

## Notes

- Uses a single ngrok session to avoid concurrent limits
- Requires a custom domain (free with ngrok account)
- Uses the official ngrok Docker image
- Automatically handles environment variable substitution
- Manages configuration through ngrok.yml
