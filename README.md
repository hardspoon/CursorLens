# Railway Ngrok Service

This repository contains a configuration for running an Ngrok HTTP tunnel service using the official ngrok Docker image.

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

## Optional: Custom Domain

If you want to use a custom domain:

1. Get your domain:
   - Go to [dashboard.ngrok.com/cloud-edge/domains](https://dashboard.ngrok.com/cloud-edge/domains)
   - Create or select your domain
   - Copy the domain URL

2. Set in Railway:
   - Add new variable:
     - Key: `NGROK_URL`
     - Value: Your domain (e.g., your-domain.ngrok-free.app)

## Deployment Steps

1. Fork this repository
2. Create a new project on [Railway](https://railway.app)
3. Connect your forked repository
4. Add required environment variables:
   - `NGROK_AUTHTOKEN`: Your ngrok authentication token
   - `NGROK_URL`: (Optional) Your custom domain
5. Deploy the service

## Verifying Deployment

Watch the deployment logs in Railway. You should see:
1. The ngrok service starting up
2. A URL where your service is available:
   - If NGROK_URL is set: Your custom domain
   - If not set: A randomly generated ngrok.io URL

## Testing

Your service will be available at:
- Custom domain (if set): `https://your-domain.ngrok-free.app`
- Random URL: `https://xxxx-xxxx-xxxx.ngrok.io`

## Troubleshooting

1. "Error: NGROK_AUTHTOKEN is not set"
   - Add NGROK_AUTHTOKEN to Railway variables
   - Make sure there are no spaces or quotes in the token

2. "Invalid authtoken"
   - Verify your token at [dashboard.ngrok.com/get-started/your-authtoken](https://dashboard.ngrok.com/get-started/your-authtoken)
   - Copy and paste the token again to avoid typos

3. Custom domain issues
   - Verify NGROK_URL format (should be like 'your-domain.ngrok-free.app')
   - Check domain status in ngrok dashboard
   - Note: Custom domains require a paid ngrok account

## Notes

- This service uses the official ngrok Docker image
- The service exposes HTTP traffic on port 80
- Free accounts have limitations on features and concurrent tunnels
- For more features, check [ngrok pricing](https://ngrok.com/pricing)
