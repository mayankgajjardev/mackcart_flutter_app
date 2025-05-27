import 'package:get/get.dart';
import 'package:mack_cart_app/app/constants/app_extension.dart';
import 'package:mack_cart_app/app/presentations/home/model/get_products_model.dart';
import 'package:mack_cart_app/app/services/hive_service.dart';

class CartController extends GetxController {
  var cartItems = <Product>[].obs;
  var totalRsCount = 0.0.obs;

  /// Get Cart Products
  Future getProductsFromCart() async {
    final products = await HiveService.getAllProducts();
    if (products.isNotEmpty) {
      products.forEach((e) {
        cartItems.add(e.toProduct());
      });
      countTotalPrice();
    }
  }

  /// Remove product from cart
  Future removeProductFromCart(int productId) async {
    await HiveService.deleteProduct(productId: productId);
    cartItems.removeWhere((item) => (item.id ?? 0) == productId);
    countTotalPrice();
    cartItems.refresh();
  }

  /// Product listeners
  productBoxListeners() {
    HiveService.listenToTask().addListener(() {
      countTotalPrice();
    });
  }

  /// Count Price
  countTotalPrice() {
    totalRsCount.value =
        cartItems.fold(0.0, (sum, item) => sum + ((item.price ?? 0.0) * item.qty));
    totalRsCount.refresh();
  }

  /// Increase product qty
  Future increaseProductQty(Product product) async {
    var hiveProduct = product.toHiveProduct();
    hiveProduct.qty = (hiveProduct.qty ?? 0) + 1;
    await HiveService.updateProduct(product: hiveProduct);
    final index = cartItems.indexWhere((e) => e.id == product.id);
    if (index != -1) {
      cartItems[index].qty = (cartItems[index].qty ?? 0) + 1;
      cartItems.refresh();
      countTotalPrice();
    }
  }

  /// Decrease product qty
  Future decreaseProductQty(Product product) async {
    final hiveProduct = product.toHiveProduct();
    if (hiveProduct.qty > 1) {
      hiveProduct.qty = hiveProduct.qty - 1;
      await HiveService.updateProduct(product: hiveProduct);
      final index = cartItems.indexWhere((e) => e.id == product.id);
      if (index != -1) {
        cartItems[index].qty = (cartItems[index].qty ?? 0) - 1;
        cartItems.refresh();
        countTotalPrice();
      }
    } else {
      await removeProductFromCart(product.id ?? 0);
    }
  }

  @override
  void onInit() {
    super.onInit();
    productBoxListeners();
  }

  @override
  void onReady() {
    super.onReady();
    getProductsFromCart();
  }
}
