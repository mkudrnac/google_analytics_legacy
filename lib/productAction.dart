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

  ProductAction(final String var1) {
    _put("&pa", var1);
  }

  set transactionId(final String var1) => _put("&ti", var1);
  set transactionAffiliation(final String var1) => _put("&ta", var1);
  set transactionRevenue(final double var1) => _put("&tr", var1.toString());
  set transactionTax(final double var1) => _put("&tt", var1.toString());
  set transactionShipping(final double var1) => _put("&ts", var1.toString());
  set transactionCouponCode(final String var1) => _put("&tcc", var1);
  set checkoutStep(final int var1) => _put("&cos", var1.toString());
  set checkoutOptions(final String var1) => _put("&col", var1);
  set productActionList(final String var1) => _put("&pal", var1);
  set productListSource(final String var1) => _put("&pls", var1);

  HashMap<String, String> build() {
    return _params;
  }

  void _put(final String name, final String value) {
    assert(name != null, "Name should be non-null");
    _params[name] = value;
  }
}
