import 'package:flutter/material.dart';
import 'package:flutter_mobile_platform_showcase/firebase/firebase_setup.dart';
import 'package:flutter_mobile_platform_showcase/notifications/notification_setup.dart';
import 'package:flutter_mobile_platform_showcase/features/home_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await FirebaseSetup.initialize();

  await NotificationSetup.initialize();

  runApp(const ShowcaseApp());
}

class ShowcaseApp extends StatelessWidget {
  const ShowcaseApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Platform Showcase',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const HomePage(),
    );
  }
}
