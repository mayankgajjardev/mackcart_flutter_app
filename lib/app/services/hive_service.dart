import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:mack_cart_app/app/constants/app_colors.dart';
import 'package:mack_cart_app/app/constants/app_extension.dart';
import 'package:mack_cart_app/app/presentations/cart/model/hive_product.dart';
import 'package:mack_cart_app/app/presentations/home/model/get_products_model.dart';

class HiveService {
  static const boxName = "productsBox";
  static final Box<HiveProduct> box = Hive.box<HiveProduct>(boxName);
  static var cartItemCount = 0.obs;

  /// Initialize Hive
  static initHive() async {
    try {
      await Hive.initFlutter();
      Hive.registerAdapter(HiveProductAdapter());
      if (!Hive.isBoxOpen(boxName)) {
        await Hive.openBox<HiveProduct>(boxName);
      }
    } catch (e) {
      debugPrint("Error :: initHive :: $e");
    }
  }

  /// Add product
  static Future<void> addProduct({required Product product}) async {
    try {
      final hiveProduct = product.toHiveProduct();
      if (box.containsKey(product.id)) {
        Get.snackbar(
          "Info",
          "Product Already in Cart",
          backgroundColor: AppColors.primary.withOpacity(0.5),
        );
        return;
      }
      await box.put(product.id, hiveProduct);
      Get.snackbar(
        "Success",
        "Product Added to Cart",
        backgroundColor: AppColors.primary.withOpacity(0.5),
      );
    } catch (e) {
      debugPrint("Error :: addProduct :: $e");
    }
  }

  /// Get all products
  static Future<List<HiveProduct>> getAllProducts() async {
    return box.values.toList();
  }

  /// Update particular product
  static Future<void> updateProduct({required HiveProduct product}) async {
    try {
      await box.put(product.id, product);
    } catch (e) {
      debugPrint("Error :: updateProduct :: $e");
    }
  }

  /// Delete particular Product
  static Future<void> deleteProduct({required int productId}) async {
    try {
      await box.delete(productId);
    } catch (e) {
      debugPrint("Error :: deleteProduct :: $e");
    }
  }

  /// clear all products
  static Future<void> clearAllProducts() async {
    try {
      await box.clear();
    } catch (e) {
      debugPrint("Error :: clearAllProducts :: $e");
    }
  }

  /// Listen to changes in the box
  static ValueListenable<Box<HiveProduct>> listenToTask() {
    return box.listenable();
  }

  /// Get cart count
  static Future getCartCount() async {
    cartItemCount.value = box.values.length;
    cartItemCount.refresh();
  }


  /// Check if product is added to cart
  static bool isProductAddedToCart(int productId) {
    var isAdded = HiveService.box.containsKey(productId);
    return isAdded;
  }
}
