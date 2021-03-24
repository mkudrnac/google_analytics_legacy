import 'dart:collection';

import 'package:google_analytics_legacy/product.dart';
import 'package:google_analytics_legacy/productAction.dart';
import 'package:google_analytics_legacy/promotion.dart';
import 'package:google_analytics_legacy/src/zzcz.dart';
import 'package:google_analytics_legacy/src/zzd.dart';

class ScreenViewBuilder extends HitBuilder {
  ScreenViewBuilder() {
    set("&t", "screenview");
  }
}

class ExceptionBuilder extends HitBuilder {
  ExceptionBuilder() {
    set("&t", "exception");
  }

  set description(final String value) => set("&exd", value);
  set fatal(final bool value) => set("&exf", ZZCZ.zzc(value));
}

class TimingBuilder extends HitBuilder {
  TimingBuilder() {
    set("&t", "timing");
  }

  set variable(final String? value) => set("&utv", value);
  set value(final int? value) => set("&utt", value?.toString());
  set category(final String? value) => set("&utc", value);
  set label(final String? value) => set("&utl", value);
}

class SocialBuilder extends HitBuilder {
  SocialBuilder() {
    set("&t", "social");
  }

  set network(final String? value) => set("&sn", value);
  set action(final String? value) => set("&sa", value);
  set target(final String? value) => set("&st", value);
}

class EventBuilder extends HitBuilder {
  EventBuilder() {
    set("&t", "event");
  }

  set category(final String? value) => set("&ec", value);
  set action(final String? value) => set("&ea", value);
  set label(final String? value) => set("&el", value);
  set value(final int? value) => set("&ev", value?.toString());
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

  void setNonInteraction(final bool value) {
    set("&ni", ZZCZ.zzc(value));
  }

  void setCampaignParamsFromUrl(final String url) {}

  void setCustomDimension(final int index, final String? value) {
    set(ZZD.zzd(index), value);
  }

  void setCustomMetric(final int index, final double? value) {
    set(ZZD.zzf(index), value?.toString());
  }

  void setProductAction(final ProductAction? productAction) {
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

  void setPromotionAction(final String? action) {
    set("&promoa", action);
  }

  void addProduct(final Product product) {
    _products.add(product);
  }

  void setHitType(final String? type) {
    set("&t", type);
  }

  void setCurrency(final String? currency) {
    set("&cu", currency);
  }

  void set(final String paramName, final String? value) {
    _map[paramName] = value != null ? Uri.encodeComponent(value) : "null";
  }

  HashMap<String, String> build() {
    // All key/values
    final buildMap = HashMap<String, String>.from(_map);

    // Product action
    final productAction = _productAction;
    if (productAction != null) {
      buildMap.addAll(productAction.build());
    }

    // Promotion
    _promotions.asMap().forEach((index, value) {
      buildMap.addAll(value.build(ZZD.zzj(index + 1)));
    });

    // Products
    _products.asMap().forEach((index, value) {
      buildMap.addAll(value.build(ZZD.zzh(index + 1)));
    });

    // Product impressions
    var impressionIndex = 1;
    for (final productImpession in _productImpressions.entries) {
      final impressionPrefix = ZZD.zzm(impressionIndex);
      productImpession.value.asMap().forEach((index, product) {
        final productPrefix = impressionPrefix + ZZD.zzl(index);
        buildMap.addAll(product.build(productPrefix));
      });
      final impressionKey = impressionPrefix + "nm";
      buildMap[impressionKey] = productImpession.key;
      impressionIndex += 1;
    }

    return buildMap;
  }
}
