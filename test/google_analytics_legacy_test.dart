import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:google_analytics_legacy/google_analytics_legacy.dart';

void main() {
  const MethodChannel channel = MethodChannel('google_analytics_legacy');

  TestWidgetsFlutterBinding.ensureInitialized();

  setUp(() {
    channel.setMockMethodCallHandler((MethodCall methodCall) async {
      return '42';
    });
  });

  tearDown(() {
    channel.setMockMethodCallHandler(null);
  });

  test('getPlatformVersion', () async {
    expect(await GoogleAnalyticsLegacy.platformVersion, '42');
  });
}
