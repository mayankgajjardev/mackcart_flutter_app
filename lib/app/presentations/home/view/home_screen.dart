import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mack_cart_app/app/constants/app_assets.dart';
import 'package:mack_cart_app/app/constants/app_colors.dart';
import 'package:mack_cart_app/app/constants/app_extension.dart';
import 'package:mack_cart_app/app/presentations/home/controller/home_controller.dart';
import 'package:mack_cart_app/app/presentations/home/model/get_products_model.dart';
import 'package:mack_cart_app/app/presentations/home/widget/product_item_widget.dart';
import 'package:mack_cart_app/app/routes/app_routes.dart';
import 'package:mack_cart_app/app/services/api_result.dart';
import 'package:mack_cart_app/app/services/hive_service.dart';
import 'package:mack_cart_app/app/widgets/api_state_builder.dart';
import 'package:mack_cart_app/app/widgets/base_scaffold.dart';
import 'package:mack_cart_app/app/widgets/custom_image_view.dart';
import 'package:responsive_screen_utils/responsive_screen_size_extension.dart';

class HomeScreen extends GetWidget<HomeController> {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BaseScaffold(
      child: Column(
        children: [
          12.hBox,
          Row(
            children: [
              const Spacer(flex: 5),
              CustomImageView(
                src: AppAssets.logo,
                height: 40.0.h,
              ),
              const Spacer(flex: 4),
              GestureDetector(
                onTap: () {
                  Get.toNamed(AppRoutes.cart)?.then(
                    (value) {
                      controller.products.refresh();
                    },
                  );
                },
                child: Obx(
                  () => Badge(
                    label: Text(
                      HiveService.cartItemCount.value.toString(),
                      style: TextStyle(
                        color: AppColors.white,
                        fontSize: 12.0.sp,
                      ),
                    ),
                    backgroundColor: AppColors.black,
                    child: Icon(
                      Icons.shopping_cart_rounded,
                      size: 30.0.w,
                      color: AppColors.primary,
                    ),
                  ),
                ),
              ),
              16.wBox,
            ],
          ),
          20.hBox,
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: TextFormField(
              controller: controller.searchCtrl,
              decoration: InputDecoration(
                hintText: "Search products...",
                hintStyle: TextStyle(
                  color: AppColors.black.withOpacity(0.6),
                  fontSize: 14.0.sp,
                ),
                fillColor: AppColors.white,
                filled: true,
                contentPadding: const EdgeInsets.symmetric(
                  vertical: 10,
                  horizontal: 16,
                ),
                border: OutlineInputBorder(
                  borderRadius: 50.radius,
                ),
              ),
              onChanged: (value) {
                controller.searchProducts(value.trim());
              },
            ),
          ),
          5.hBox,
          // Gridview
          Expanded(
            child: Obx(
              () => ApiStateBuilder(
                result: controller.products.value,
                onRetry: () {
                  controller.getAllProducts();
                },
                onSuccess: (data) {
                  return controller.searchCtrl.text.trim().isNotEmpty &&
                          ((controller.products.value
                                          as ApiSuccess<ProductsModel>)
                                      .data
                                      .products ??
                                  [])
                              .isEmpty
                      ? const Center(
                          child: Text("No Product found!"),
                        )
                      : RefreshIndicator(
                          color: AppColors.primary,
                          onRefresh: () async {
                            await controller.getAllProducts();
                          },
                          child: Column(
                            children: [
                              Expanded(
                                child: GridView.builder(
                                  controller: controller.scrollCtrl,
                                  keyboardDismissBehavior:
                                      ScrollViewKeyboardDismissBehavior.onDrag,
                                  padding: const EdgeInsets.only(
                                      top: 10, bottom: 16, left: 14, right: 14),
                                  gridDelegate:
                                      const SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 2,
                                    crossAxisSpacing: 8.0,
                                    mainAxisSpacing: 8.0,
                                    childAspectRatio: 0.7,
                                  ),
                                  itemCount: data.products?.length ?? 0,
                                  itemBuilder: (context, index) {
                                    return controller.searchCtrl.text
                                                .trim()
                                                .isEmpty ||
                                            (data.products?[index].title ?? '')
                                                .toLowerCase()
                                                .contains(controller
                                                    .searchCtrl.text
                                                    .trim()
                                                    .toLowerCase())
                                        ? ProductItemWidget(
                                            onRefresh: () {
                                              controller.products.refresh();
                                            },
                                            product: data.products?[index],
                                            onAddToCart: () {
                                              if (HiveService
                                                  .isProductAddedToCart(data
                                                          .products?[index]
                                                          .id ??
                                                      0)) {
                                                HiveService.deleteProduct(
                                                    productId: data
                                                            .products?[index]
                                                            .id ??
                                                        0);
                                              } else {
                                                controller.addProductToCart(
                                                    data.products![index]);
                                              }
                                              controller.products.refresh();
                                            },
                                          )
                                        : const SizedBox();
                                  },
                                ),
                              ),
                              Obx(
                                () => controller.isLoadingMore.value
                                    ? const Padding(
                                        padding:
                                            EdgeInsets.symmetric(vertical: 12),
                                        child: CircularProgressIndicator(),
                                      )
                                    : const SizedBox(),
                              ),
                            ],
                          ),
                        );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
