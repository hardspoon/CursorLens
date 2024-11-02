# Railway Ngrok Service

This repository contains a configuration for running an Ngrok HTTP tunnel service using the official ngrok Docker image.

## ⚠️ Important: Setting up Environment Variables

Before deploying, you **must** set up these environment variables in Railway:

1. `NGROK_AUTHTOKEN`:
   - Sign up at [ngrok.com](https://ngrok.com)
   - Go to [dashboard.ngrok.com/get-started/your-authtoken](https://dashboard.ngrok.com/get-started/your-authtoken)
   - Copy your authentication token

2. `NGROK_URL`:
   - Go to [dashboard.ngrok.com/cloud-edge/domains](https://dashboard.ngrok.com/cloud-edge/domains)
   - Create or select your domain
   - Copy the domain URL

## Deployment Steps

1. Fork this repository
2. Create a new project on [Railway](https://railway.app)
3. Connect your forked repository
4. Add environment variables:
   - `NGROK_AUTHTOKEN`: Your ngrok authentication token
   - `NGROK_URL`: Your ngrok domain (e.g., your-domain.ngrok-free.app)
5. Deploy the service

## Verifying Deployment

Watch the deployment logs in Railway. You should see:
1. The ngrok service starting up
2. A successful connection message
3. Your domain being active

## Notes

- This service uses the official ngrok Docker image
- The service exposes HTTP traffic on port 80
- Uses a custom domain for consistent access
- Free accounts have certain limitations
- For more features, check [ngrok pricing](https://ngrok.com/pricing)

## Troubleshooting

1. Authentication Issues:
   - Verify NGROK_AUTHTOKEN in Railway variables
   - Check token at dashboard.ngrok.com
   - Ensure no spaces/quotes in the token

2. Domain Issues:
   - Verify NGROK_URL is correctly set
   - Ensure domain is registered in ngrok dashboard
   - Check domain status in ngrok dashboard

3. Connection Issues:
   - Check Railway deployment logs
   - Verify port 80 is not blocked
   - Ensure service is running properly
