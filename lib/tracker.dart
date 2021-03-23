import 'dart:convert';

import 'package:google_analytics_legacy/hitBuilders.dart';
import 'package:google_analytics_legacy/src/messages.dart';

class Tracker {
  Tracker(this._trackedId);
  final TrackerApi _api = TrackerApi();
  final int _trackedId;

  Future<void> enableExceptionReporting(final bool value) async {
    return _api.enableExceptionReporting(
      TrackerBoolValue()
        ..trackerId = _trackedId
        ..value = value,
    );
  }

  Future<void> setSessionTimeout(final int value) async {
    return _api.setSessionTimeout(
      TrackerIntValue()
        ..trackerId = _trackedId
        ..value = value,
    );
  }

  Future<void> enableAutoActivityTracking(final bool value) async {
    return _api.enableAutoActivityTracking(
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

  Future<String?> get(final String key) async {
    final result = await _api.get(
      TrackerStringValue()
        ..trackerId = _trackedId
        ..value = key,
    );
    return result.value;
  }

  Future<void> set(final String key, final String value) async {
    return _api.set(
      TrackerSetValue()
        ..trackerId = _trackedId
        ..key = key
        ..value = value,
    );
  }

  Future<void> setSampleRate(final double value) async {
    return _api.setSampleRate(
      TrackerDoubleValue()
        ..trackerId = _trackedId
        ..value = value,
    );
  }

  Future<void> setUseSecure(final bool value) async {
    return _api.setUseSecure(
      TrackerBoolValue()
        ..trackerId = _trackedId
        ..value = value,
    );
  }

  Future<void> setScreenName(final String name) async {
    return _api.setScreenName(
      TrackerStringValue()
        ..trackerId = _trackedId
        ..value = name,
    );
  }

  Future<void> setLocation(final String value) async {
    return _api.setLocation(
      TrackerStringValue()
        ..trackerId = _trackedId
        ..value = value,
    );
  }

  Future<void> setReferrer(final String value) async {
    return _api.setReferrer(
      TrackerStringValue()
        ..trackerId = _trackedId
        ..value = value,
    );
  }

  Future<void> setPage(final String value) async {
    return _api.setPage(
      TrackerStringValue()
        ..trackerId = _trackedId
        ..value = value,
    );
  }

  Future<void> setHostname(final String value) async {
    return _api.setHostname(
      TrackerStringValue()
        ..trackerId = _trackedId
        ..value = value,
    );
  }

  Future<void> setTitle(final String value) async {
    return _api.setTitle(
      TrackerStringValue()
        ..trackerId = _trackedId
        ..value = value,
    );
  }

  Future<void> setLanguage(final String value) async {
    return _api.setLanguage(
      TrackerStringValue()
        ..trackerId = _trackedId
        ..value = value,
    );
  }

  Future<void> setEncoding(final String value) async {
    return _api.setEncoding(
      TrackerStringValue()
        ..trackerId = _trackedId
        ..value = value,
    );
  }

  Future<void> setScreenColors(final String value) async {
    return _api.setScreenColors(
      TrackerStringValue()
        ..trackerId = _trackedId
        ..value = value,
    );
  }

  Future<void> setScreenResolution(final int value1, final int value2) async {
    return _api.setScreenResolution(
      TrackerSetScreenResolutionValue()
        ..trackerId = _trackedId
        ..value1 = value1
        ..value2 = value2,
    );
  }

  Future<void> setViewportSize(final String value) async {
    return _api.setViewportSize(
      TrackerStringValue()
        ..trackerId = _trackedId
        ..value = value,
    );
  }

  Future<String> getClientId() async {
    final result = await _api.getClientId(
      TrackerIdValue()..trackerId = _trackedId,
    );
    return result.value!;
  }

  Future<void> setClientId(final String value) async {
    return _api.setClientId(
      TrackerStringValue()
        ..trackerId = _trackedId
        ..value = value,
    );
  }

  Future<void> setAppName(final String value) async {
    return _api.setAppName(
      TrackerStringValue()
        ..trackerId = _trackedId
        ..value = value,
    );
  }

  Future<void> setAppId(final String value) async {
    return _api.setAppId(
      TrackerStringValue()
        ..trackerId = _trackedId
        ..value = value,
    );
  }

  Future<void> setAppInstallerId(final String value) async {
    return _api.setAppInstallerId(
      TrackerStringValue()
        ..trackerId = _trackedId
        ..value = value,
    );
  }

  Future<void> setAppVersion(final String value) async {
    return _api.setAppVersion(
      TrackerStringValue()
        ..trackerId = _trackedId
        ..value = value,
    );
  }

  Future<void> setAnonymizeIp(final bool value) async {
    return _api.setAnonymizeIp(
      TrackerBoolValue()
        ..trackerId = _trackedId
        ..value = value,
    );
  }

  Future<void> enableAdvertisingIdCollection(final bool value) async {
    return _api.enableAdvertisingIdCollection(
      TrackerBoolValue()
        ..trackerId = _trackedId
        ..value = value,
    );
  }
}
