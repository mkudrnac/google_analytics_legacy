import 'dart:io';

class Helper {
  static String encodeValue(final String value) {
    if (Platform.isIOS) {
      return Uri.encodeComponent(value);
    }
    return value;
  }

  static String? convertBool(final bool? value) {
    if (value != null) {
      return value ? "1" : "0";
    }
    return null;
  }
}
