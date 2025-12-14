# OneStep 🚀

> **Identity-first habit coach that helps you become who you want to be**

OneStep is a Flutter application that takes a unique approach to habit building by focusing on identity transformation rather than just habit tracking. Instead of asking "What habits should I build?", OneStep asks "Who do I want to become?" and helps you build habits that align with that identity.

## ✨ Features

- **🎯 Identity-Based Habit Building** - Define who you want to become, and we'll help you build habits that reinforce that identity
- **📊 Identity Scorecard** - Track your progress toward your ideal self with evidence-based scoring
- **🔗 Habit Stacking** - Link habits together to create powerful routines
- **📈 Progress Tracking** - Visualize your journey with intuitive analytics
- **🤖 AI-Powered Insights** - Get personalized recommendations powered by Gemini AI
- **🔔 Smart Notifications** - Contextual reminders that adapt to your schedule

## 🛠️ Tech Stack

| Category | Technology |
|----------|------------|
| Framework | Flutter 3.13+ |
| State Management | flutter_bloc |
| Backend | Appwrite |
| AI | Google Gemini |
| Local Storage | Hive, SQLite |
| Authentication | OAuth2, Appwrite Auth |

## 📦 Prerequisites

- Flutter SDK >= 3.13.0
- Dart SDK >= 3.1.0
- An Appwrite account and project
- (Optional) Google Gemini API key for AI features

## 🚀 Getting Started

### 1. Clone the repository

```bash
git clone https://github.com/AffanShaikhsurab/onestep.git
cd onestep
```

### 2. Set up environment variables

```bash
# Copy the example environment file
cp .env.example .env

# Edit .env with your configuration
# Add your Appwrite credentials and API keys
```

### 3. Install dependencies

```bash
flutter pub get
```

### 4. Run the app

```bash
# Development
flutter run

# Web
flutter run -d chrome

# Build for production
flutter build apk --release  # Android
flutter build ios --release  # iOS
flutter build web --release  # Web
```

## 📁 Project Structure

```
lib/
├── main.dart                 # Application entry point
├── core/                     # Core functionality
│   ├── config/              # App configuration
│   ├── constants/           # App constants
│   ├── env/                 # Environment configuration
│   ├── interfaces/          # Abstract interfaces
│   ├── navigation/          # Navigation handling
│   ├── services/            # Core services
│   ├── theme/               # App theming
│   ├── utils/               # Utility functions
│   └── widgets/             # Shared widgets
├── features/                 # Feature modules
│   ├── authentication/      # User auth
│   ├── dashboard/           # Main dashboard
│   ├── habit_creation/      # Create habits
│   ├── habit_tracking/      # Track habits
│   ├── habit_stacking/      # Habit stacking
│   ├── identity_scorecard/  # Identity scoring
│   ├── identity_onboarding/ # Onboarding flow
│   └── profile/             # User profile
└── test/                     # Tests
```

## 🧪 Running Tests

```bash
# Run all tests
flutter test

# Run with coverage
flutter test --coverage

# Run specific test file
flutter test test/feature_name_test.dart
```

## 🤝 Contributing

We welcome contributions! Please see our [Contributing Guide](CONTRIBUTING.md) for details on:

- Code style guidelines
- Branching strategy
- Commit message conventions
- Pull request process

## 📄 License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## 🙏 Acknowledgments

- [Flutter](https://flutter.dev/) - The amazing cross-platform framework
- [Appwrite](https://appwrite.io/) - Backend as a Service
- [Google Gemini](https://deepmind.google/technologies/gemini/) - AI capabilities

---

<p align="center">
  Built with ❤️ by <a href="https://github.com/AffanShaikhsurab">Affan Shaikhsurab</a>
</p>
