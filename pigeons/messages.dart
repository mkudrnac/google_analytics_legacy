// ignore: import_of_legacy_library_into_null_safe
import 'package:pigeon/pigeon_lib.dart';

class TrackerIdValue {
  late int trackerId;
}

class TrackerGetValue {
  late String value;
}

class TrackerGetClientIdValue {
  late String value;
}

class TrackerStringValue {
  late int trackerId;
  late String value;
}

class TrackerBoolValue {
  late int trackerId;
  late bool value;
}

class TrackerDoubleValue {
  late int trackerId;
  late double value;
}

class TrackerIntValue {
  late int trackerId;
  late int value;
}

class TrackerSetValue {
  late int trackerId;
  late String key;
  late String value;
}

class TrackerSetScreenResolutionValue {
  late int trackerId;
  late int value1;
  late int value2;
}

class HitBuilderMessage {
  late int trackerId;
  late String data;
}

@HostApi()
abstract class TrackerApi {
  void enableExceptionReporting(TrackerBoolValue value);
  void setSessionTimeout(TrackerIntValue value);
  void enableAutoActivityTracking(TrackerBoolValue value);
  void send(HitBuilderMessage hitBuilderMessage);
  TrackerGetValue get(TrackerStringValue key);
  void set(TrackerSetValue value);
  void setSampleRate(TrackerDoubleValue value);
  void setUseSecure(TrackerBoolValue value);
  void setScreenName(TrackerStringValue value);
  void setLocation(TrackerStringValue value);
  void setReferrer(TrackerStringValue value);
  void setPage(TrackerStringValue value);
  void setHostname(TrackerStringValue value);
  void setTitle(TrackerStringValue value);
  void setLanguage(TrackerStringValue value);
  void setEncoding(TrackerStringValue value);
  void setScreenColors(TrackerStringValue value);
  void setScreenResolution(TrackerSetScreenResolutionValue value);
  void setViewportSize(TrackerStringValue value);
  TrackerGetClientIdValue getClientId(TrackerIdValue value);
  void setClientId(TrackerStringValue value);
  void setAppName(TrackerStringValue value);
  void setAppId(TrackerStringValue value);
  void setAppInstallerId(TrackerStringValue value);
  void setAppVersion(TrackerStringValue value);
  void setAnonymizeIp(TrackerBoolValue value);
  void enableAdvertisingIdCollection(TrackerBoolValue value);
}

class GABool {
  late bool value;
}

class GAInt {
  late int value;
}

class TrackingId {
  late String trackingId;
}

class TrackerId {
  late int trackerId;
}

@HostApi()
abstract class GoogleAnalyticsApi {
  void getInstance();
  void setLogLevelVerbose();
  void setDryRun(GABool value);
  GABool isDryRunEnabled();
  void setAppOptOut(GABool value);
  GABool getAppOptOut();
  void setLocalDispatchPeriod(GAInt value);
  TrackerId newTracker(TrackingId gaId);
}

void configurePigeon(PigeonOptions opts) {
  opts.dartOut = 'lib/src/messages.dart';
  opts.dartTestOut = 'test/test.dart';
  opts.objcHeaderOut = 'ios/Classes/messages.h';
  opts.objcSourceOut = 'ios/Classes/messages.m';
  opts.objcOptions.prefix = 'GAL';
  opts.javaOut = 'android/src/main/java/cz/vps4u/google_analytics_legacy/Messages.java';
  opts.javaOptions.package = 'cz.vps4u.google_analytics_legacy';
}
