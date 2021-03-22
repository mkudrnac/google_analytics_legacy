import 'dart:collection';

class Promotion {
  static final actionClick = "click";
  static final actionView = "view";
  final _params = HashMap<String, String>();

  set id(final String var1) => _put("id", var1);
  set name(final String var1) => _put("nm", var1);
  set creative(final String var1) => _put("cr", var1);
  set position(final String var1) => _put("ps", var1);

  HashMap<String, String> build(final String var1) {
    final buildMap = HashMap<String, String>();
    for (final param in _params.entries) {
      buildMap[var1 + param.key] = param.value;
    }
    return buildMap;
  }

  void _put(final String name, final String value) {
    assert(name != null, "Name should be non-null");
    _params[name] = value;
  }
}
