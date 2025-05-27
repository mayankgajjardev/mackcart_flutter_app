import 'package:get/get.dart';
import 'package:mack_cart_app/app/presentations/cart/controller/cart_controller.dart';
import 'package:mack_cart_app/app/presentations/home/controller/home_controller.dart';
import 'package:mack_cart_app/app/presentations/product_detail/controller/product_detail_controller.dart';

class InitialBinding implements Bindings {
  @override
  void dependencies() {
    // Get.lazyPut<SplashController>(() => SplashController());
  }
}


class HomeBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<HomeController>(() => HomeController());
  }
}


class ProductDetailBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ProductDetailController>(() => ProductDetailController());
  }
}

class CartBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<CartController>(() => CartController());
  }
}