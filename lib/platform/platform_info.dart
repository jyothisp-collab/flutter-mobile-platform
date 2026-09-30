import 'package:flutter/services.dart';

/// Retrieves native platform information via a [MethodChannel].
///
/// The channel name is `com.example.showcase/info`. The corresponding
/// platform-side handler must implement the `getDeviceInfo` method.
///
/// **Expected return formats:**
///
/// **Android** (`MainActivity.kt`):
/// ```
/// "Android 14 (API 34) - Pixel 8 Pro"
/// ```
///
/// **iOS** (`AppDelegate.swift`):
/// ```
/// "iOS 18.0 - iPhone"
/// ```
class PlatformInfo {
  static const MethodChannel _channel = MethodChannel(
    'com.example.showcase/info',
  );

  /// Invokes the native `getDeviceInfo` method and returns the result string.
  ///
  /// Returns a descriptive error string on failure.
  static Future<String> getDeviceInfo() async {
    try {
      final String result = await _channel.invokeMethod('getDeviceInfo');
      return result;
    } on PlatformException catch (e) {
      return "Failed to get device info: '${e.message}'.";
    } on MissingPluginException {
      return "Method not implemented on this platform.";
    }
  }
}
