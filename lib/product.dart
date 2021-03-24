import 'dart:collection';

import 'package:google_analytics_legacy/src/zzd.dart';

class Product {
  final _params = HashMap<String, String>();

  set id(final String? value) => _put("id", value);
  set name(final String? value) => _put("nm", value);
  set brand(final String? value) => _put("br", value);
  set category(final String? value) => _put("ca", value);
  set variant(final String? value) => _put("va", value);
  set position(final int? value) => _put("ps", value?.toString());
  set price(final double? value) => _put("pr", value?.toString());
  set quantity(final int? value) => _put("qt", value?.toString());
  set couponCode(final String? value) => _put("cc", value);

  void setCustomDimension(final int index, final String? value) {
    _put(ZZD.zzo(index), value);
  }

  void setCustomMetric(final int index, final int? value) {
    _put(ZZD.zzp(index), value.toString());
  }

  HashMap<String, String> build(final String prefix) {
    final buildMap = HashMap<String, String>();
    for (final param in _params.entries) {
      buildMap[prefix + param.key] = param.value;
    }
    return buildMap;
  }

  void _put(final String name, final String? value) {
    _params[name] = value != null ? Uri.encodeComponent(value) : "null";
  }
}
