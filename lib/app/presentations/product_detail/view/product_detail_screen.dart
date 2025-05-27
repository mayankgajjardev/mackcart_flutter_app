import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mack_cart_app/app/constants/app_colors.dart';
import 'package:mack_cart_app/app/constants/app_extension.dart';
import 'package:mack_cart_app/app/presentations/product_detail/controller/product_detail_controller.dart';
import 'package:mack_cart_app/app/services/hive_service.dart';
import 'package:mack_cart_app/app/widgets/api_state_builder.dart';
import 'package:mack_cart_app/app/widgets/base_scaffold.dart';
import 'package:mack_cart_app/app/widgets/common_appbar_widget.dart';
import 'package:mack_cart_app/app/widgets/custom_image_view.dart';
import 'package:responsive_screen_utils/responsive_screen_size_extension.dart';

class ProductDetailScreen extends GetWidget<ProductDetailController> {
  const ProductDetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BaseScaffold(
      child: Column(
        children: [
          12.hBox,
          const CommonAppbarWidget(title: 'Product Detail'),
          5.hBox,
          Expanded(
            child: Obx(
              () => ApiStateBuilder(
                result: controller.product.value,
                onRetry: () {
                  controller.getProductDetails();
                },
                onSuccess: (data) {
                  return SingleChildScrollView(
                    child: Column(
                      children: [
                        5.hBox,
                        SizedBox(
                          width: Get.width,
                          height: 200.0.h,
                          child: PageView.builder(
                            itemCount: (data.images ?? []).length,
                            itemBuilder: (context, index) {
                              return Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 16),
                                child: ClipRRect(
                                  borderRadius: 10.radius,
                                  child: CustomImageView(
                                    src: data.images?[index] ?? '',
                                    fit: BoxFit.contain,
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                        Container(
                          decoration: BoxDecoration(
                              color: AppColors.white,
                              borderRadius: BorderRadius.only(
                                topRight: 10.cRadius,
                                topLeft: 10.cRadius,
                              )),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding:
                                    const EdgeInsets.only(top: 10, left: 16),
                                child: Text(
                                  data.title ?? '',
                                  style: TextStyle(
                                    fontSize: 20.0.sp,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),

                              Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 16.0),
                                child: Wrap(
                                  spacing: 6.0,
                                  runSpacing: 2.0,
                                  children: List.generate(
                                    (data.tags ?? []).length,
                                    (index) {
                                      return Chip(
                                        label: Text(data.tags?[index] ?? ''),
                                        backgroundColor:
                                            AppColors.white.withOpacity(0.8),
                                        shape: const StadiumBorder(),
                                      );
                                    },
                                  ),
                                ),
                              ),
                              8.hBox,

                              Row(
                                children: [
                                  Container(
                                    margin: const EdgeInsets.only(left: 16),
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 10, vertical: 4),
                                    decoration: BoxDecoration(
                                      borderRadius: 50.radius,
                                      border: Border.all(
                                        color: AppColors.black.withOpacity(0.2),
                                      ),
                                    ),
                                    child: Row(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        Icon(Icons.star,
                                            color: AppColors.primary),
                                        5.wBox,
                                        Text(
                                          "${data.rating ?? 0}",
                                          style: TextStyle(
                                            fontSize: 16.0.sp,
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                  10.wBox,
                                  Text(
                                    data.availabilityStatus ?? '',
                                    style: TextStyle(
                                      fontSize: 14.0.sp,
                                      color: AppColors.primary.withOpacity(0.8),
                                    ),
                                  ),
                                  10.wBox,
                                  Text(
                                    "Stock : ${(data.stock ?? 0).toInt().toString()}",
                                    style: TextStyle(
                                      fontSize: 14.0.sp,
                                      color: AppColors.black,
                                    ),
                                  ),
                                  14.wBox,
                                  Text(
                                    "Qty : ${data.qty}",
                                    style: TextStyle(
                                      fontSize: 14.0.sp,
                                      color: AppColors.black,
                                    ),
                                  ),
                                ],
                              ),

                              /// Price
                              Padding(
                                padding: const EdgeInsets.only(
                                    left: 16.0, right: 16, top: 10),
                                child: Text(
                                  '\$${(data.price ?? 0).toStringAsFixed(3)}',
                                  style: TextStyle(
                                    fontSize: 20.0.sp,
                                    color: AppColors.primary,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(left: 16),
                                child: Text(
                                  data.category ?? '',
                                  style: TextStyle(
                                    fontSize: 16.0.sp,
                                    fontWeight: FontWeight.w500,
                                    color: AppColors.black,
                                  ),
                                ),
                              ),

                              /// Description
                              Padding(
                                padding: const EdgeInsets.only(
                                    top: 6, bottom: 20, left: 16, right: 16),
                                child: Text(
                                  data.description ?? '',
                                  style: TextStyle(
                                    fontSize: 14.0.sp,
                                    color: AppColors.black.withOpacity(0.7),
                                  ),
                                ),
                              ),
                              (0.13.sh).toInt().hBox,

                              /// Add to cart button
                              Center(
                                child: ElevatedButton(
                                  onPressed: () {
                                    if (HiveService.isProductAddedToCart(
                                        data.id ?? 0)) {
                                      HiveService.deleteProduct(
                                          productId: data.id ?? 0);
                                    } else {
                                      controller.addProductToCart(data);
                                    }
                                    controller.product.refresh();
                                  },
                                  style: ElevatedButton.styleFrom(
                                    minimumSize: Size(Get.width * 0.8, 50.0.h),
                                    backgroundColor: AppColors.primary,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: 50.radius,
                                    ),
                                  ),
                                  child: Text(
                                    HiveService.isProductAddedToCart(
                                            data.id ?? 0)
                                        ? 'Remove from Cart'
                                        : 'Add to Cart',
                                    style: TextStyle(
                                      fontSize: 18.0.sp,
                                      color: AppColors.white,
                                    ),
                                  ),
                                ),
                              ),

                              20.hBox,
                            ],
                          ),
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
