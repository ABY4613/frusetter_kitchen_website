# Frusette Kitchen Web Dashboard

A Flutter web application for managing the Frusette Kitchen operations.

## 🚀 Live Demo

The application is deployed on Vercel with automatic CI/CD.

> **Production URL**: _Will be available after first Vercel deployment_

## 📋 Features

- Kitchen operations dashboard
- Subscription management
- Meal planning and tracking
- Real-time updates

## 🛠️ Development

### Prerequisites

- Flutter SDK (^3.10.0)
- Dart SDK
- Git

### Local Setup

```bash
# Clone the repository
git clone <repository-url>
cd frusetter_kitchen_website

# Install dependencies
flutter pub get

# Run in development mode
flutter run -d chrome
```

### Build for Production

```bash
# Build web app
flutter build web --release --web-renderer canvaskit

# The output will be in build/web/
```

## 🌐 Deployment

This project uses **Vercel** for hosting with automatic deployments on every push to the main branch.

For detailed deployment instructions, see [DEPLOYMENT.md](./DEPLOYMENT.md).

### Quick Deploy to Vercel

1. Push your code to GitHub/GitLab/Bitbucket
2. Connect your repository at [vercel.com/new](https://vercel.com/new)
3. Vercel auto-detects the configuration and deploys

## 📚 Resources

- [Flutter Documentation](https://docs.flutter.dev/)
- [Flutter Web Guide](https://flutter.dev/web)
- [Vercel Documentation](https://vercel.com/docs)

## 📝 License

This project is part of the Frusette application suite.
