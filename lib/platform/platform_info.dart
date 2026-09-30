import 'package:flutter/services.dart';

/// Retrieves native platform information via a [MethodChannel].
///
/// The channel name is `com.example.showcase/info`. The corresponding
/// platform-side handler must implement the `getDeviceInfo` method:
///
/// **Android** (`MainActivity.kt`):
/// ```kotlin
/// MethodChannel(flutterEngine?.dartExecutor?.binaryMessenger, "com.example.showcase/info")
///   .setMethodCallHandler { call, result ->
///     if (call.method == "getDeviceInfo") {
///       result.success("${android.os.Build.MANUFACTURER} ${android.os.Build.MODEL}")
///     }
///   }
/// ```
///
/// **iOS** (`AppDelegate.swift`):
/// ```swift
/// let controller = window?.rootViewController as! FlutterViewController
/// let channel = FlutterMethodChannel(name: "com.example.showcase/info", binaryMessenger: controller.binaryMessenger)
/// channel.setMethodCallHandler { call, result in
///   if call.method == "getDeviceInfo" {
///     result.success(UIDevice.current.model)
///   }
/// }
/// ```
class PlatformInfo {
  static const MethodChannel _channel = MethodChannel(
    'com.example.showcase/info',
  );

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
