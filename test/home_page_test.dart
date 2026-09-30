import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_mobile_platform_showcase/features/home_page.dart';

void main() {
  const MethodChannel channel = MethodChannel('com.example.showcase/info');

  setUp(() {
    TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
        .setMockMethodCallHandler(channel, (MethodCall methodCall) async {
          if (methodCall.method == 'getDeviceInfo') {
            return 'Mock Device OS 1.0 - Test Model';
          }
          return null;
        });
  });

  tearDown(() {
    TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
        .setMockMethodCallHandler(channel, null);
  });

  testWidgets('HomePage displays mocked native info on button tap', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(const MaterialApp(home: HomePage()));

    // Initially shows Unknown
    expect(find.text('Unknown'), findsOneWidget);

    // Tap the button to fetch native info
    await tester.tap(find.byType(ElevatedButton));
    await tester.pump();
    await tester.pumpAndSettle();

    // Should display the mocked native info
    expect(find.text('Mock Device OS 1.0 - Test Model'), findsOneWidget);
  });
}
