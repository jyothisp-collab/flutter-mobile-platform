# Flutter Mobile Platform Showcase

A lightweight Flutter reference implementation demonstrating native platform integration patterns for client review. Focused on Firebase Cloud Messaging, local notifications, and MethodChannel communication with Android and iOS.

## What It Demonstrates

- **Firebase Cloud Messaging (FCM)** — Foreground and background push notification handling with `firebase_messaging`.
- **Local notifications** — `flutter_local_notifications` configured for Android notification channels and iOS permission handling.
- **Platform channels (MethodChannel)** — Two-way Dart-to-native communication with Kotlin (Android) and Swift (iOS) implementations.
- **Native device info** — Retrieving OS version and device model via `MethodChannel` from native host code.
- **Permission handling** — Runtime notification permission requests on Android 13+ and iOS.
- **Firebase initialization** — Structured async initialization with placeholder credentials for demonstration.

## Architecture Overview

```
lib/
├── main.dart                              — Entry point, Firebase + notification init
├── features/
│   └── home_page.dart                     — Main UI with MethodChannel demo
├── firebase/
│   └── firebase_setup.dart                — Firebase.initializeApp + permissions
├── notifications/
│   └── notification_setup.dart            — FCM handlers + local notification config
└── platform/
    └── platform_info.dart                 — MethodChannel wrapper for device info

android/
  └── MainActivity.kt                      — MethodChannel handler (Kotlin)

ios/
  └── AppDelegate.swift                    — MethodChannel handler (Swift)
```

## Data Flow

```
FCM Message Received
  ↓
FirebaseMessaging.onMessage (foreground)
  ↓
NotificationHelper.show()
  ↓
flutter_local_notifications (Android channel / iOS alert)

MethodChannel Call (Dart → Native)
  ↓
MainActivity.kt / AppDelegate.swift
  ↓
Return OS string to Dart
```

## Firebase Configuration

This repository uses placeholder `FirebaseOptions` to compile and run without throwing initialization errors. The Firebase setup catches initialization failures gracefully and logs them.

**To connect to a real Firebase environment:**

1. Create a project in the [Firebase Console](https://console.firebase.google.com/).
2. Run `flutterfire configure` at the project root.
3. Replace the placeholder `FirebaseOptions` in `FirebaseSetup` with the generated `DefaultFirebaseOptions.currentPlatform`.
4. Do not commit `firebase_options.dart` or real API keys to version control.

## Notifications

`NotificationHelper` creates an Android notification channel (`high_importance_channel`) and requests notification permissions on both platforms. Foreground FCM messages are displayed as local notifications so users see them immediately. Background messages are handled by a top-level background handler.

## Platform Channels

The `PlatformInfo` class wraps a `MethodChannel` (`com.example.showcase/info`) and exposes a single `getDeviceInfo()` method. The native implementations return formatted strings:

- **Android**: `"Android {VERSION.RELEASE} (API {SDK_INT}) - {Build.MODEL}"`
- **iOS**: `"{systemName} {systemVersion} - {model}"`
- **Unsupported**: `"Method not implemented on this platform."`

## Testing

Includes a widget test that mocks the MethodChannel and verifies the platform info display updates after tapping the button.

Run:

```bash
flutter pub get
flutter test
```

## Out Of Scope

- Complex state management (BLoC, Riverpod, Provider).
- Deep navigation or routing.
- Firebase Auth, Firestore, or Crashlytics.
- Biometric authentication.
- Background execution beyond FCM.
- Production CI/CD or code signing.
