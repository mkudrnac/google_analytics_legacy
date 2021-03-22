import 'package:google_analytics_legacy/messages.dart';
import 'package:google_analytics_legacy/tracker.dart';

class GoogleAnalytics {
  static GoogleAnalytics _instance;
  static GoogleAnalyticsApi _apiInstance;

  static GoogleAnalyticsApi get _api {
    if (_apiInstance == null) {
      _apiInstance = GoogleAnalyticsApi();
    }
    return _apiInstance;
  }

  static Future<GoogleAnalytics> get instance async {
    if (_instance == null) {
      await _api.getInstance();
      _instance = GoogleAnalytics();
    }
    return _instance;
  }

  Future<Tracker> newTracker(final String s) async {
    final trackerId = await _api.newTracker(StringValue()..value = s);
    return Tracker(trackerId.value);
  }
}
