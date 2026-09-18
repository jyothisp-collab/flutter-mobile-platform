import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';

class FirebaseSetup {
  static Future<void> initialize() async {
   

    try {
      await Firebase.initializeApp(
        options: const FirebaseOptions(
          apiKey: 'AIzaSyDoc-PLACEHOLDER-KEY',
          appId: '1:1234567890:ios:321321321',
          messagingSenderId: '1234567890',
          projectId: 'placeholder-project-id',
        ),
      );

      if (!kIsWeb) {
        await FirebaseMessaging.instance.requestPermission(
          alert: true,
          badge: true,
          sound: true,
        );
      }
    } catch (e) {
      debugPrint(
        'Firebase initialization failed (expected with placeholders): $e',
      );
    }
  }
}
