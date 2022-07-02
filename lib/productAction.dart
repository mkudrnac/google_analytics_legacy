import 'dart:collection';

import 'package:google_analytics_legacy/src/helper.dart';

class ProductAction {
  static final actionDetail = "detail";
  static final actionClick = "click";
  static final actionAdd = "add";
  static final actionRemove = "remove";
  static final actionCheckout = "checkout";
  static final actionCheckoutOption = "checkout_option";
  static final actionCheckoutOptions = "checkout_options";
  static final actionPurchase = "purchase";
  static final actionRefund = "refund";

  final _params = HashMap<String, String?>();
  String Function(String)? _valueEncoder = Helper.encodeValue;

  ProductAction(final String action) {
    _put("&pa", action);
  }

  set transactionId(final String? value) => _put("&ti", value);
  set transactionAffiliation(final String? value) => _put("&ta", value);
  set transactionRevenue(final double? value) => _put("&tr", value.toString());
  set transactionTax(final double? value) => _put("&tt", value.toString());
  set transactionShipping(final double? value) => _put("&ts", value.toString());
  set transactionCouponCode(final String? value) => _put("&tcc", value);
  set checkoutStep(final int? value) => _put("&cos", value.toString());
  set checkoutOptions(final String? value) => _put("&col", value);
  set productActionList(final String? value) => _put("&pal", value);
  set productListSource(final String? value) => _put("&pls", value);

  void setValueEncoder(final String Function(String)? valueEncoder) {
    _valueEncoder = valueEncoder;
  }

  HashMap<String, String> build() {
    final buildMap = HashMap<String, String>();
    for (final param in _params.entries) {
      final value = param.value;
      if (value != null) {
        buildMap[param.key] = _valueEncoder?.call(value) ?? value;
      }
    }
    return buildMap;
  }

  void _put(final String name, final String? value) {
    _params[name] = value;
  }
}
