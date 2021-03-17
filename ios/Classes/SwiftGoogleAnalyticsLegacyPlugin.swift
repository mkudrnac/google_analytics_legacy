import Flutter
import UIKit

public class SwiftGoogleAnalyticsLegacyPlugin: NSObject, FlutterPlugin {
  public static func register(with registrar: FlutterPluginRegistrar) {
    let channel = FlutterMethodChannel(name: "google_analytics_legacy", binaryMessenger: registrar.messenger())
    let instance = SwiftGoogleAnalyticsLegacyPlugin()
    registrar.addMethodCallDelegate(instance, channel: channel)
  }

  public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
    result("iOS " + UIDevice.current.systemVersion)
  }
}
