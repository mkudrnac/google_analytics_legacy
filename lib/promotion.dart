import 'dart:collection';

class Promotion {
  static final actionClick = "click";
  static final actionView = "view";
  final _params = HashMap<String, String>();

  set id(final String? value) => _put("id", value);
  set name(final String? value) => _put("nm", value);
  set creative(final String? value) => _put("cr", value);
  set position(final String? value) => _put("ps", value);

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
