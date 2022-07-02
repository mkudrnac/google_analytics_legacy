import 'dart:collection';

import 'package:google_analytics_legacy/src/helper.dart';

class Promotion {
  static final actionClick = "click";
  static final actionView = "view";
  final _params = HashMap<String, String?>();
  String Function(String)? _valueEncoder = Helper.encodeValue;

  set id(final String? value) => _put("id", value);
  set name(final String? value) => _put("nm", value);
  set creative(final String? value) => _put("cr", value);
  set position(final String? value) => _put("ps", value);

  void setValueEncoder(final String Function(String)? valueEncoder) {
    _valueEncoder = valueEncoder;
  }

  HashMap<String, String> build(final String prefix) {
    final buildMap = HashMap<String, String>();
    for (final param in _params.entries) {
      final value = param.value;
      if (value != null) {
        buildMap[prefix + param.key] = _valueEncoder?.call(value) ?? value;
      }
    }
    return buildMap;
  }

  void _put(final String name, final String? value) {
    _params[name] = value;
  }
}
