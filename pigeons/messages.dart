import 'package:pigeon/pigeon_lib.dart';

class StringValue {
  String value;
}

class BoolValue {
  bool value;
}

class DoubleValue {
  double value;
}

class IntValue {
  int value;
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
  StringValue get(TrackerStringValue key);
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
  void setScreenResolution(IntValue value1, IntValue value2);
  void setViewportSize(TrackerStringValue value);
  void setClientId(TrackerStringValue value);
  void setAppName(TrackerStringValue value);
  void setAppId(TrackerStringValue value);
  void setAppInstallerId(TrackerStringValue value);
  void setAppVersion(TrackerStringValue value);
  void setAnonymizeIp(TrackerBoolValue value);
  void enableAdvertisingIdCollection(TrackerBoolValue value);
}

@HostApi()
abstract class GoogleAnalyticsApi {
  void getInstance();
  IntValue newTracker(StringValue gaId);
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
