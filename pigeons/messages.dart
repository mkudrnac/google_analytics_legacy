import 'package:pigeon/pigeon_lib.dart';

class TrackerGetValue {
  String value;
}

class TrackerStringValue {
  int trackerId;
  String value;
}

class TrackerBoolValue {
  int trackerId;
  bool value;
}

class TrackerDoubleValue {
  int trackerId;
  double value;
}

class TrackerIntValue {
  int trackerId;
  int value;
}

class TrackerSetValue {
  int trackerId;
  String key;
  String value;
}

class TrackerSetScreenResolutionValue {
  int trackerId;
  int value1;
  int value2;
}

class HitBuilderMessage {
  int trackerId;
  String data;
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
  void setClientId(TrackerStringValue value);
  void setAppName(TrackerStringValue value);
  void setAppId(TrackerStringValue value);
  void setAppInstallerId(TrackerStringValue value);
  void setAppVersion(TrackerStringValue value);
  void setAnonymizeIp(TrackerBoolValue value);
  void enableAdvertisingIdCollection(TrackerBoolValue value);
}

class GABool {
  bool value;
}

class GAInt {
  int value;
}

class TrackingId {
  String trackingId;
}

class TrackerId {
  int trackerId;
}

@HostApi()
abstract class GoogleAnalyticsApi {
  void getInstance();
  void setDryRun(GABool value);
  GABool isDryRunEnabled();
  void setAppOptOut(GABool value);
  GABool getAppOptOut();
  void setLocalDispatchPeriod(GAInt value);
  TrackerId newTracker(TrackingId gaId);
}

void configurePigeon(PigeonOptions opts) {
  opts.dartOut = 'lib/messages.dart';
  opts.dartTestOut = 'lib/test.dart';
  opts.objcHeaderOut = 'ios/Classes/messages.h';
  opts.objcSourceOut = 'ios/Classes/messages.m';
  opts.objcOptions.prefix = 'GAL';
  opts.javaOut = 'android/src/main/java/cz/vps4u/google_analytics_legacy/Messages.java';
  opts.javaOptions.package = 'cz.vps4u.google_analytics_legacy';
}
