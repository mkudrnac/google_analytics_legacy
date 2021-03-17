
import 'dart:async';

import 'package:flutter/services.dart';

class GoogleAnalyticsLegacy {
  static const MethodChannel _channel =
      const MethodChannel('google_analytics_legacy');

  static Future<String> get platformVersion async {
    final String version = await _channel.invokeMethod('getPlatformVersion');
    return version;
  }
}
