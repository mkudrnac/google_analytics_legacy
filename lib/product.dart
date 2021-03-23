import 'dart:collection';

import 'package:google_analytics_legacy/zzd.dart';

class Product {
  final _params = HashMap<String, String>();

  set id(final String value) => _put("id", value);
  set name(final String value) => _put("nm", value);
  set brand(final String value) => _put("br", value);
  set category(final String value) => _put("ca", value);
  set variant(final String value) => _put("va", value);
  set position(final int value) => _put("ps", value.toString());
  set price(final double value) => _put("pr", value.toString());
  set quantity(final int value) => _put("qt", value.toString());
  set couponCode(final String value) => _put("cc", value);

  void setCustomDimension(final int var1, final String var2) {
    _put(ZZD.zzo(var1), var2);
  }

  void setCustomMetric(final int var1, final int var2) {
    _put(ZZD.zzp(var1), var2.toString());
  }

  HashMap<String, String> build(final String var1) {
    final buildMap = HashMap<String, String>();
    for (final param in _params.entries) {
      buildMap[var1 + param.key] = param.value;
    }
    return buildMap;
  }

  void _put(final String name, final String value) {
    _params[name] = value;
  }
}
