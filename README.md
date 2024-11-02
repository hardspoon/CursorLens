# Railway Ngrok Service

This repository contains a configuration for running an Ngrok TCP tunnel service using the official ngrok Docker image.

## ⚠️ Important: Setting up NGROK_AUTHTOKEN

Before deploying, you **must** set up your NGROK_AUTHTOKEN:

1. Get your token:
   - Sign up at [ngrok.com](https://ngrok.com)
   - Go to [dashboard.ngrok.com/get-started/your-authtoken](https://dashboard.ngrok.com/get-started/your-authtoken)
   - Copy your authentication token

2. Set the token in Railway:
   - Go to your project in [Railway dashboard](https://railway.app)
   - Click on "Variables"
   - Add new variable:
     - Key: `NGROK_AUTHTOKEN`
     - Value: Your ngrok authentication token
   - Click "Add"

If you see "Error: NGROK_AUTHTOKEN is not set", it means you haven't properly set up the token in Railway's environment variables.

## Deployment Steps

1. Fork this repository
2. Create a new project on [Railway](https://railway.app)
3. Connect your forked repository
4. **Important**: Add your NGROK_AUTHTOKEN as described above
5. Deploy the service

## Verifying Deployment

Watch the deployment logs in Railway. You should see:
1. "Starting tunnel..."
2. A tunnel URL in the format `tcp://X.tcp.ngrok.io:XXXXX`

If you see "Error: NGROK_AUTHTOKEN is not set", check your token configuration.

## Testing the Connection

Once you see the tunnel URL (format: `tcp://X.tcp.ngrok.io:XXXXX`), you can connect to it using:
```bash
nc X.tcp.ngrok.io XXXXX
```

## Troubleshooting

1. "Error: NGROK_AUTHTOKEN is not set"
   - Solution: Add NGROK_AUTHTOKEN to Railway variables
   - Make sure there are no spaces or quotes in the token

2. "Invalid authtoken"
   - Verify your token at [dashboard.ngrok.com/get-started/your-authtoken](https://dashboard.ngrok.com/get-started/your-authtoken)
   - Copy and paste the token again to avoid typos

3. Connection issues
   - Wait for the tunnel URL to appear in the logs
   - Use the exact host and port from the tunnel URL
   - Check your firewall settings

## Notes

- This service uses the official ngrok Docker image
- Free accounts are limited to 1 simultaneous tunnel
- For more features, check [ngrok pricing](https://ngrok.com/pricing)
