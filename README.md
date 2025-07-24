# Rent Payment App

A Flutter-based mobile application for streamlined rent payment processing with a professional, user-friendly interface.

### 🔧 Technical Features
- **Custom Components** - Reusable UI components for consistency
- **Form Validation** - Comprehensive input validation and error handling

## Project Structure

```
lib/
├── components/           # Reusable UI components
│   ├── custom_app_bar.dart
│   ├── custom_button.dart
│   └── custom_text_field.dart
├── models/              # Data models
│   ├── user_account.dart
│   ├── landlord_info.dart
│   └── rent_payment_data.dart
├── screens/             # Application screens
│   ├── create_account_screen.dart
│   ├── pay_rent_screen.dart
│   └── pay_rent_details_screen.dart
├── services/            # Business logic and data services
│   └── app_data_service.dart
├── utils/               # Utilities and constants
│   ├── app_colors.dart
│   └── app_text_styles.dart
└── main.dart           # Application entry point
```

## Getting Started

### Prerequisites
- Flutter SDK (3.0+)
- Dart SDK (3.0+)
- Android Studio (for Android development)
- VS Code (for development)

### Installation

1. **Clone the repository**
   ```bash
   git clone https://github.com/deepu9990/rent-payment-app.git
   cd rent-payment-app
   ```

2. **Install dependencies**
   ```bash
   flutter pub get
   ```

3. **Run the app**
   ```bash
   # For web development
   flutter run -d chrome
   
   # For Android
   flutter run
   ```

## Deployment

### Web Deployment
```bash
flutter build web
```

### Android APK
```bash
flutter build apk --release
```

### iOS (requires Xcode)
```bash
flutter build ios --release
```

## Contributing

1. Fork the repository
2. Create a feature branch (`git checkout -b feature/new-feature`)
3. Commit your changes (`git commit -am 'Add new feature'`)
4. Push to the branch (`git push origin feature/new-feature`)
5. Create a Pull Request

