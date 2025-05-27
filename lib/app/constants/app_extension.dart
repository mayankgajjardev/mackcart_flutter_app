import 'package:mack_cart_app/app/presentations/cart/model/hive_product.dart';
import 'package:mack_cart_app/app/presentations/home/model/get_products_model.dart';
import 'package:flutter/material.dart';
import 'package:responsive_screen_utils/responsive_screen_size_extension.dart';

extension IntExtensions on int {
  /// SizedBox with width
  SizedBox get wBox => SizedBox(width: (toDouble().w));

  /// SizedBox with height
  SizedBox get hBox => SizedBox(height: (toDouble().h));

  /// BorderRadius with all corners same
  BorderRadius get radius => BorderRadius.circular((toDouble().r));
  Radius get cRadius => Radius.circular((toDouble().r));
}
extension ProductToHive on Product {
  HiveProduct toHiveProduct() {
    return HiveProduct(
      id: id,
      title: title,
      description: description,
      category: category,
      price: price,
      discountPercentage: discountPercentage,
      rating: rating,
      stock: stock,
      tags: tags,
      brand: brand,
      sku: sku,
      weight: weight,
      warrantyInformation: warrantyInformation,
      shippingInformation: shippingInformation,
      availabilityStatus: availabilityStatus,
      returnPolicy: returnPolicy,
      minimumOrderQuantity: minimumOrderQuantity,
      images: images,
      thumbnail: thumbnail,
      qty: qty,
    );
  }
}


extension HiveToProduct on HiveProduct {
  Product toProduct() {
    return Product(
      id: id,
      title: title,
      description: description,
      category: category,
      price: price,
      discountPercentage: discountPercentage,
      rating: rating,
      stock: stock,
      tags: tags,
      brand: brand,
      sku: sku,
      weight: weight,
      warrantyInformation: warrantyInformation,
      shippingInformation: shippingInformation,
      availabilityStatus: availabilityStatus,
      returnPolicy: returnPolicy,
      minimumOrderQuantity: minimumOrderQuantity,
      images: images,
      thumbnail: thumbnail,
      qty: qty,
    );
  }
}
