import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:mack_cart_app/app/constants/app_constants.dart';
import 'package:mack_cart_app/app/constants/app_enums.dart';
import 'package:mack_cart_app/app/presentations/home/model/get_products_model.dart';
import 'package:mack_cart_app/app/services/api_result.dart';
import 'package:mack_cart_app/app/services/api_service.dart';
import 'package:mack_cart_app/app/services/hive_service.dart';

class HomeController extends GetxController {
  var products = Rx<ApiResult<ProductsModel>>(const ApiLoading());
  TextEditingController searchCtrl = TextEditingController();
  var filterProducts = <Product>[].obs;
  late ScrollController scrollCtrl;
  var skip = 0.obs;
  var limit = 30.obs;
  var isLoadingMore = false.obs;
  var totalProducts = 0.obs;


  /// Set Listeners
  void setupScrollListener() {
    scrollCtrl = ScrollController();
    scrollCtrl.addListener(() async {
      if (scrollCtrl.position.pixels >=
          scrollCtrl.position.maxScrollExtent - 200) {
        await loadMoreProducts();
      }
    });
  }

  /// Load More Products
  Future<void> loadMoreProducts() async {
    if (isLoadingMore.value || skip >= totalProducts.value || searchCtrl.text.isNotEmpty) return;
    isLoadingMore(true);
    final res = await ApiService.request(
        path: AppConstants.products,
        method: HttpMethod.get,
        parseJson: (json) => productsModelFromJson(json),
        queryParameters: {
          'skip': skip.value,
          'limit': limit.value,
        });
    if (res is ApiSuccess<ProductsModel>) {
      final existing =
          (products.value as ApiSuccess<ProductsModel>).data.products ?? [];
      final newProducts = res.data.products ?? <Product>[];
      filterProducts.value = [...filterProducts, ...newProducts];
      products.value = ApiSuccess(res.data.copyWith(
          products: [...existing, ...newProducts],
          skip: skip.value,
          limit: limit.value,
          total: res.data.total ?? 0));
      skip.value += newProducts.length;
    }
    isLoadingMore.value = false;
  }

  /// Search Products
  void searchProducts(String query) {
    if (query.isEmpty) {
      products.value = ApiSuccess(ProductsModel(products: filterProducts));
      return;
    }
    products.value = ApiSuccess(ProductsModel(
        products: (filterProducts.where((p) => (p.title ?? '')
                    .toLowerCase()
                    .contains(query.trim().toLowerCase())) ??
                [])
            .toList()));
    products.refresh();
  }

  /// Get All Products
  Future<void> getAllProducts() async {
    try {
      skip.value = 0;
      isLoadingMore(true);
      products.value = const ApiLoading();
      final res = await ApiService.request(
        path: AppConstants.products,
        method: HttpMethod.get,
        parseJson: (json) => productsModelFromJson(json),
      );
      if (res is ApiSuccess<ProductsModel>) {
        products.value = res;
        filterProducts.value = res.data.products ?? [];
        skip += res.data.limit ?? 0;
        totalProducts.value = res.data.total ?? 0;
      }
      isLoadingMore.value = false;
    } catch (e) {
      Get.snackbar("Error", "Failed to load products: $e");
    }
  }

  /// Add product to cart
  Future addProductToCart(Product p) async {
    await HiveService.addProduct(product: p);
    products.refresh();
  }

  /// Product listeners
  productBoxListeners() {
    HiveService.getCartCount();
    HiveService.listenToTask().addListener(() {
      HiveService.cartItemCount.value = HiveService.box.values.length;
    });
  }

  @override
  void onInit() {
    super.onInit();
    setupScrollListener();
    productBoxListeners();
  }

  @override
  void onReady() {
    super.onReady();
    getAllProducts();
  }

  @override
  void onClose() {
    super.onClose();
    searchCtrl.dispose();
    scrollCtrl.dispose();
  }
}
