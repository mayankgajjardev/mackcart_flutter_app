import 'package:get/get.dart';
import 'package:mack_cart_app/app/constants/app_constants.dart';
import 'package:mack_cart_app/app/constants/app_enums.dart';
import 'package:mack_cart_app/app/presentations/home/model/get_products_model.dart';
import 'package:mack_cart_app/app/services/api_result.dart';
import 'package:mack_cart_app/app/services/api_service.dart';
import 'package:mack_cart_app/app/services/hive_service.dart';

class ProductDetailController extends GetxController {
  var productId = 0.obs;
  var product = Rx<ApiResult<Product>>(const ApiLoading());


  /// Add product to cart
  addProductToCart(Product p) async {
    await HiveService.addProduct(product: p);
    product.refresh();
  }

  /// Get Product Detail
  Future<void> getProductDetails() async {
    try {
      product.value = const ApiLoading();
      final res = await ApiService.request(
        path: "${AppConstants.productDetail}${productId.value}",
        method: HttpMethod.get,
        parseJson: (json) => Product.fromJson(json),
      );
      product.value = res;
    } catch (e) {
      Get.snackbar("Error", "Failed to load products: $e");
    }
  }

  @override
  void onInit() {
    super.onInit();
    productId.value = Get.arguments['productId'] ?? '';
  }

  @override
  void onReady() {
    super.onReady();
    getProductDetails();
  }
}
