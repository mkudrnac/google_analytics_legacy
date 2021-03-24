import 'dart:collection';

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

  final _params = HashMap<String, String>();

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

  HashMap<String, String> build() {
    return _params;
  }

  void _put(final String name, final String? value) {
    _params[name] = value != null ? Uri.encodeComponent(value) : "null";
  }
}
