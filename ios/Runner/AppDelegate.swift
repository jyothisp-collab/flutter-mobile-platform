import UIKit
import Flutter

@main
@objc class AppDelegate: FlutterAppDelegate {
  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {

    if let controller = window?.rootViewController as? FlutterViewController {
      let infoChannel = FlutterMethodChannel(name: "com.example.showcase/info",
                                             binaryMessenger: controller.binaryMessenger)
      infoChannel.setMethodCallHandler({
        (call: FlutterMethodCall, result: @escaping FlutterResult) -> Void in
        if call.method == "getDeviceInfo" {
          let device = UIDevice.current
          result("\(device.systemName) \(device.systemVersion) - \(device.model)")
        } else {
          result(FlutterMethodNotImplemented)
        }
      })
    }

    GeneratedPluginRegistrant.register(with: self)
    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }
}
