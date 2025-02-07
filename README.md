
# product-list-project - Setup Guide

## Table of Contents
- [Project Overview](#project-overview)
- [Requirements](#requirements)
- [Installation](#installation)
- [Running the App](#running-the-app)
- [Build & Release](#build--release)
- [Folder Structure](#folder-structure)
- [Additional Notes](#additional-notes)

## Project Overview
This is a Flutter application designed to run on both Android and iOS platforms. The source code is available in the **master** branch.

## Requirements
Ensure you have the following dependencies installed:

- Flutter SDK (Latest Stable Version) - [Download Here](https://flutter.dev/docs/get-started/install)
- Dart SDK (comes with Flutter)
- Android Studio / VS Code / IntelliJ IDEA (Preferred IDEs)
- Xcode (for iOS Development on macOS)
- Android Emulator or Physical Device
- Git

## Installation
Follow these steps to set up the project locally:

1. Clone the repository:
   ```sh
   git@github.com:sarathp007/product-list-project.git
   ```
2. Navigate to the project directory:
   ```sh
   cd flutter-app
   ```
3. Checkout the master branch:
   ```sh
   git checkout master
   ```
4. Install dependencies:
   ```sh
   flutter pub get
   ```

## Running the App
To run the application, use the following commands:

- For Android:
  ```sh
  flutter run
  ```
- For iOS (requires macOS):
  ```sh
  flutter run --no-sound-null-safety
  ```
- To specify a device:
  ```sh
  flutter run -d <device_id>
  ```
  Run `flutter devices` to list available devices.

## Build & Release

### Android
Generate APK:
```sh
flutter build apk --release
```
Generate AppBundle (for Play Store):
```sh
flutter build appbundle
```

### iOS
Build for iOS:
```sh
flutter build ios
```
To archive and distribute, open `ios/Runner.xcworkspace` in Xcode and follow the publishing guide.

## Folder Structure
```
flutter-app/
│── lib/                    # Main application code
│   ├── models/             # Data models
│   ├── views/              # UI Screens
│   ├── widgets/            # Reusable UI components
│   ├── services/           # API and database interactions
│── assets/                 # Images, fonts, and static resources
│── pubspec.yaml            # Dependencies and package configuration
│── android/                # Android-specific files
│── ios/                    # iOS-specific files
│── README.md               # Project documentation
```

## Additional Notes
- Make sure to create a `.env` file or configure API keys properly before running the app.
- If there are permission issues while running, check `android/app/src/main/AndroidManifest.xml` and `ios/Runner/Info.plist`.
- Ensure you are on the **master** branch before making changes:
  ```sh
  git checkout master
  ```
- Run `flutter doctor` to check for any missing dependencies.

For any issues, feel free to raise a ticket or contact the team. 🚀

