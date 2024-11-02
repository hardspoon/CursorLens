# Railway Ngrok Service

This repository contains a configuration for running an Ngrok HTTP tunnel service that forwards to a Railway domain.

## ⚠️ Important: Environment Variables

Before deploying, you must set up these environment variables:

1. `NGROK_AUTHTOKEN`:
   - Get from [dashboard.ngrok.com/get-started/your-authtoken](https://dashboard.ngrok.com/get-started/your-authtoken)

2. `RAILWAY_DOMAIN`:
   - Your Railway domain (e.g., your-app.up.railway.app)

3. `NGROK_URL` (Optional):
   - Your custom ngrok domain if you have one

## How It Works

This service:
1. Connects to your Railway domain on port 4040
2. Creates an ngrok tunnel to that connection
3. Makes it available via ngrok's URL or your custom domain

## Setup Instructions

1. Fork this repository
2. Create a new project on [Railway](https://railway.app)
3. Connect your forked repository
4. Add environment variables:
   - `NGROK_AUTHTOKEN`: Your ngrok auth token
   - `RAILWAY_DOMAIN`: Your Railway domain
   - `NGROK_URL`: (Optional) Your custom ngrok domain
5. Deploy the service

## Testing

Once deployed, your service will be available at either:
- Your custom domain (if NGROK_URL is set)
- A randomly generated ngrok.io URL

The service will forward all traffic to your Railway domain on port 4040.

## Troubleshooting

1. Connection Issues:
   - Verify your Railway domain is correct
   - Ensure port 4040 is accessible
   - Check ngrok logs for connection errors

2. Authentication Issues:
   - Verify NGROK_AUTHTOKEN is correct
   - Check ngrok dashboard for token status

3. Domain Issues:
   - If using custom domain, verify it in ngrok dashboard
   - Ensure domain is properly configured

## Notes

- The service specifically forwards to port 4040
- Uses the official ngrok Docker image
- Supports custom domains with paid ngrok accounts
- Automatically handles connection management
