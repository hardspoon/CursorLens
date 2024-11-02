# Railway Ngrok Service

This repository contains a Dockerfile and Railway configuration for running an Ngrok service that exposes a TCP tunnel on port 3000.

## ⚠️ Important: Setting up NGROK_TOKEN

Before deploying, you **must** set up your NGROK_TOKEN:

1. Get your token:
   - Sign up at [ngrok.com](https://ngrok.com)
   - Go to [dashboard.ngrok.com/get-started/your-authtoken](https://dashboard.ngrok.com/get-started/your-authtoken)
   - Copy your authentication token

2. Set the token in Railway:
   - Go to your project in [Railway dashboard](https://railway.app)
   - Click on "Variables"
   - Add new variable:
     - Key: `NGROK_TOKEN`
     - Value: Your ngrok authentication token
   - Click "Add"

If you see "Error: NGROK_TOKEN is not set", it means you haven't properly set up the token in Railway's environment variables.

## Deployment Steps

1. Fork this repository
2. Create a new project on [Railway](https://railway.app)
3. Connect your forked repository
4. **Important**: Add your NGROK_TOKEN as described above
5. Deploy the service

## Verifying Deployment

Watch the deployment logs in Railway. You should see:

1. "Starting ngrok tunnel..."
2. "✅ Ngrok tunnel established:" followed by your tunnel URL
3. "🚀 Starting netcat listener on port 3000..."

If you see "Error: NGROK_TOKEN is not set" or "❌ Failed to establish ngrok tunnel", check your token configuration.

## Testing the Connection

Once you see the tunnel URL (format: `tcp://X.tcp.ngrok.io:XXXXX`), connect using:
```bash
nc X.tcp.ngrok.io XXXXX
```

## Troubleshooting

1. "Error: NGROK_TOKEN is not set"
   - Solution: Add NGROK_TOKEN to Railway variables
   - Make sure there are no spaces or quotes in the token

2. "Invalid NGROK_TOKEN"
   - Verify your token at [dashboard.ngrok.com/get-started/your-authtoken](https://dashboard.ngrok.com/get-started/your-authtoken)
   - Copy and paste the token again to avoid typos

3. "Failed to establish ngrok tunnel"
   - Check if your ngrok account has any active tunnels
   - Free accounts are limited to 1 simultaneous tunnel
   - Try redeploying the service

4. Connection issues
   - Wait for "✅ Ngrok tunnel established:" message
   - Use the exact host and port from the tunnel URL
   - Check your firewall settings
