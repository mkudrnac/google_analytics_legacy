import 'dart:collection';

import 'package:google_analytics_legacy/product.dart';
import 'package:google_analytics_legacy/productAction.dart';
import 'package:google_analytics_legacy/promotion.dart';
import 'package:google_analytics_legacy/zzcz.dart';
import 'package:google_analytics_legacy/zzd.dart';

class ScreenViewBuilder extends HitBuilder {
  ScreenViewBuilder() {
    set("&t", "screenview");
  }
}

class ExceptionBuilder extends HitBuilder {
  ExceptionBuilder() {
    set("&t", "exception");
  }

  set description(final String var1) => set("&exd", var1);
  set fatal(final bool var1) => set("&exf", ZZCZ.zzc(var1));
}

class TimingBuilder extends HitBuilder {
  TimingBuilder() {
    set("&t", "timing");
  }

  set variable(final String var1) => set("&utv", var1);
  set value(final int var1) => set("&utt", var1.toString());
  set category(final String var1) => set("&utc", var1);
  set label(final String var1) => set("&utl", var1);
}

class SocialBuilder extends HitBuilder {
  SocialBuilder() {
    set("&t", "social");
  }

  set network(final String var1) => set("&sn", var1);
  set action(final String var1) => set("&sa", var1);
  set target(final String var1) => set("&st", var1);
}

class EventBuilder extends HitBuilder {
  EventBuilder() {
    set("&t", "event");
  }

  set category(final String var1) => set("&ec", var1);
  set action(final String var1) => set("&ea", var1);
  set label(final String var1) => set("&el", var1);
  set value(final int var1) => set("&ev", var1.toString());
}

class HitBuilder {
  final _map = HashMap<String, String>();
  ProductAction? _productAction;
  final _productImpressions = HashMap<String, List<Product>>();
  final _promotions = <Promotion>[];
  final _products = <Product>[];

  void setNewSession() {
    set("&sc", "start");
  }

  void setNonInteraction(final bool var1) {
    set("&ni", ZZCZ.zzc(var1));
  }

  void setCampaignParamsFromUrl(final String var1) {}

  void setCustomDimension(final int var1, final String var2) {
    set(ZZD.zzd(var1), var2);
  }

  void setCustomMetric(final int var1, final double var2) {
    set(ZZD.zzf(var1), var2.toString());
  }

  void setProductAction(final ProductAction productAction) {
    _productAction = productAction;
  }

  void addImpression(final Product product, final String impression) {
    final item = _productImpressions[impression];
    if (item != null) {
      item.add(product);
    } else {
      _productImpressions[impression] = [product];
    }
  }

  void addPromotion(final Promotion promotion) {
    _promotions.add(promotion);
  }

  void setPromotionAction(final String var1) {
    set("&promoa", var1);
  }

  void addProduct(final Product product) {
    _products.add(product);
  }

  void setHitType(final String var1) {
    set("&t", var1);
  }

  void set(final String paramName, final String value) {
    _map[paramName] = value;
  }

  HashMap<String, String> build() {
    // All key/values
    final buildMap = _map;
    final var2 = 1;

    // Product action
    final productAction = _productAction;
    if (productAction != null) {
      buildMap.addAll(productAction.build());
    }

    // Promotions
    for (final promotion in _promotions) {
      buildMap.addAll(promotion.build(ZZD.zzj(var2)));
    }

    // Products
    for (final product in _products) {
      buildMap.addAll(product.build(ZZD.zzh(var2)));
    }

    // Product impressions
    for (final productImpession in _productImpressions.entries) {
      final var6 = ZZD.zzm(var2);
      final var7 = 1;
      for (final product in productImpession.value) {
        final var10002 = var6 + ZZD.zzl(var7);
        buildMap.addAll(product.build(var10002));
      }
      final var10001 = var6 + "nm";
      buildMap[var10001] = productImpession.key;
    }

    return buildMap;
  }
}
