import 'dart:convert';

import 'package:google_analytics_legacy/hitBuilders.dart';
import 'package:google_analytics_legacy/messages.dart';

class Tracker {
  Tracker(this._trackedId);
  final TrackerApi _api = TrackerApi();
  final int _trackedId;

  Future<void> setScreenName(final String name) async {
    return _api.setScreenName(
      TrackerStringValue()
        ..trackerId = _trackedId
        ..value = name,
    );
  }

  Future<void> enableAdvertisingIdCollection(final bool value) async {
    return _api.enableAdvertisingIdCollection(
      TrackerBoolValue()
        ..trackerId = _trackedId
        ..value = value,
    );
  }

  Future<void> enableExceptionReporting(final bool value) async {
    return _api.enableExceptionReporting(
      TrackerBoolValue()
        ..trackerId = _trackedId
        ..value = value,
    );
  }

  Future<void> send(final HitBuilder hitBuilder) async {
    return _api.send(
      HitBuilderMessage()
        ..trackerId = _trackedId
        ..data = jsonEncode(hitBuilder.build()),
    );
  }
}
