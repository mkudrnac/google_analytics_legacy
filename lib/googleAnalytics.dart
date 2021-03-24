import 'package:google_analytics_legacy/src/messages.dart';
import 'package:google_analytics_legacy/tracker.dart';

export 'package:google_analytics_legacy/hitBuilders.dart';
export 'package:google_analytics_legacy/product.dart';
export 'package:google_analytics_legacy/productAction.dart';
export 'package:google_analytics_legacy/promotion.dart';
export 'package:google_analytics_legacy/tracker.dart';

class GoogleAnalytics {
  static GoogleAnalytics? _instance;
  static GoogleAnalyticsApi? _apiInstance;

  static GoogleAnalyticsApi get _api {
    if (_apiInstance == null) {
      _apiInstance = GoogleAnalyticsApi();
    }
    return _apiInstance!;
  }

  static Future<GoogleAnalytics> get instance async {
    if (_instance == null) {
      await _api.getInstance();
      _instance = GoogleAnalytics();
    }
    return _instance!;
  }

  Future<void> setLogLevelVerbose() async {
    return _api.setLogLevelVerbose();
  }

  Future<void> setDryRun(final bool value) async {
    return _api.setDryRun(
      GABool()..value = value,
    );
  }

  Future<bool> isDryRunEnabled() async {
    final result = await _api.isDryRunEnabled();
    return result.value!;
  }

  Future<void> setAppOptOut(final bool value) async {
    return _api.setAppOptOut(
      GABool()..value = value,
    );
  }

  Future<bool> getAppOptOut() async {
    final result = await _api.getAppOptOut();
    return result.value!;
  }

  Future<void> setLocalDispatchPeriod(final int value) async {
    return _api.setLocalDispatchPeriod(
      GAInt()..value = value,
    );
  }

  Future<Tracker> newTracker(final String trackingId) async {
    final tracker = await _api.newTracker(
      TrackingId()..trackingId = trackingId,
    );
    return Tracker(tracker.trackerId!);
  }
}
