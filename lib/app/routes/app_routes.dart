import 'package:get/get.dart';
import 'package:mack_cart_app/app/bindings/global_bindings.dart';
import 'package:mack_cart_app/app/presentations/cart/view/cart_screen.dart';
import 'package:mack_cart_app/app/presentations/home/view/home_screen.dart';
import 'package:mack_cart_app/app/presentations/product_detail/view/product_detail_screen.dart';
import 'package:mack_cart_app/app/presentations/splash/splash_screen.dart';

class AppRoutes {
  static const String splash = '/';
  static const String home = '/home';
  static const String productDetail = '/productDetail';
  static const String cart = '/cart';

  static final pages = [
    GetPage(
      name: AppRoutes.splash,
      page: () => const SplashScreen(),
    ),
    GetPage(
      name: AppRoutes.home,
      page: () => const HomeScreen(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: AppRoutes.productDetail,
      page: () => const ProductDetailScreen(),
      binding: ProductDetailBinding(),
    ),
    GetPage(
      name: AppRoutes.cart,
      page: () => const CartScreen(),
      binding: CartBinding(),
    ),
  ];
}
