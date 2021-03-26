import 'package:google_analytics_legacy/googleAnalytics.dart';

void main(List<String> args) async {
  final ga = await GoogleAnalytics.instance;
  final tracker = await ga.newTracker("UA-xxxxxx");

  // Screen view
  // https://developers.google.com/analytics/devguides/collection/android/v4/screens
  {
    final screenView = ScreenViewBuilder();
    await tracker.setScreenName("Flutter");
    await tracker.send(screenView);
  }

  // Event
  // https://developers.google.com/analytics/devguides/collection/android/v4/events
  {
    final event = EventBuilder();
    event.category = "Action";
    event.action = "Share";
    await tracker.send(event);
  }

  // Enhanced Ecommerce Tracking
  // https://developers.google.com/analytics/devguides/collection/android/v4/enhanced-ecommerce

  // Measuring Impressions
  {
    final product = Product();
    product.id = "P12345";
    product.name = "Android Warhol T-Shirt";
    product.category = "Apparel/T-Shirts";
    product.brand = "Google";
    product.variant = "Black";
    product.position = 1;
    product.setCustomDimension(1, "Member");
    final builder = ScreenViewBuilder();
    builder.addImpression(product, "Search Results");
    await tracker.setScreenName("searchResults");
    await tracker.send(builder);
  }

  // Measuring Actions
  {
    final product = Product();
    product.id = "P12345";
    product.name = "Android Warhol T-Shirt";
    product.category = "Apparel/T-Shirts";
    product.brand = "Google";
    product.variant = "Black";
    product.position = 1;
    product.setCustomDimension(1, "Member");
    final productAction = ProductAction(ProductAction.actionClick);
    productAction.productActionList = "Search Results";
    final builder = ScreenViewBuilder();
    builder.addProduct(product);
    builder.setProductAction(productAction);
    builder.setCurrency("EUR");
    await tracker.setScreenName("searchResults");
    await tracker.send(builder);
  }

  //Combining Impressions and Actions
  {
    // The product from a related products section.
    final relatedProduct = Product();
    relatedProduct.id = "P12345";
    relatedProduct.name = "Android Warhol T-Shirt";
    relatedProduct.category = "Apparel/T-Shirts";
    relatedProduct.brand = "Google";
    relatedProduct.variant = "White";
    relatedProduct.position = 1;

    // The product being viewed.
    final viewedProduct = Product();
    viewedProduct.id = "P12345";
    viewedProduct.name = "Android Warhol T-Shirt";
    viewedProduct.category = "Apparel/T-Shirts";
    viewedProduct.brand = "Google";
    viewedProduct.variant = "Black";
    viewedProduct.position = 1;

    final productAction = ProductAction(ProductAction.actionDetail);
    final builder = ScreenViewBuilder();
    builder.addImpression(relatedProduct, "Related Products");
    builder.addProduct(viewedProduct);
    builder.setProductAction(productAction);
    builder.setCurrency("EUR");
    await tracker.setScreenName("product");
    await tracker.send(builder);
  }

  //Measuring Transactions
  {
    final product = Product();
    product.id = "P12345";
    product.name = "Android Warhol T-Shirt";
    product.category = "Apparel/T-Shirts";
    product.brand = "Google";
    product.variant = "Black";
    product.price = 29.20;
    product.couponCode = "APPARELSALE";
    product.quantity = 1;
    final productAction = ProductAction(ProductAction.actionPurchase);
    productAction.transactionId = "T12345";
    productAction.transactionAffiliation = "Google Store - Online";
    productAction.transactionRevenue = 37.39;
    productAction.transactionTax = 2.85;
    productAction.transactionShipping = 5.34;
    productAction.transactionCouponCode = "SUMMER2013";
    final builder = ScreenViewBuilder();
    builder.addProduct(product);
    builder.setProductAction(productAction);
    builder.setCurrency("EUR");
    await tracker.setScreenName("transaction");
    await tracker.send(builder);
  }
}
