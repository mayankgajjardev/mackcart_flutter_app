import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mack_cart_app/app/constants/app_assets.dart';
import 'package:mack_cart_app/app/constants/app_colors.dart';
import 'package:mack_cart_app/app/constants/app_extension.dart';
import 'package:mack_cart_app/app/presentations/cart/cart_item_widget.dart';
import 'package:mack_cart_app/app/presentations/cart/controller/cart_controller.dart';
import 'package:mack_cart_app/app/services/hive_service.dart';
import 'package:mack_cart_app/app/widgets/base_scaffold.dart';
import 'package:mack_cart_app/app/widgets/common_appbar_widget.dart';
import 'package:mack_cart_app/app/widgets/custom_image_view.dart';
import 'package:responsive_screen_utils/responsive_screen_size_extension.dart';

class CartScreen extends GetWidget<CartController> {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BaseScaffold(
      child: Column(
        children: [
          12.hBox,
          const CommonAppbarWidget(title: "Cart"),
          10.hBox,
          Expanded(
            child: Obx(
              () => controller.cartItems.isEmpty
                  ? Padding(
                      padding: EdgeInsets.only(bottom: 0.1.sh),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          CustomImageView(
                            src: AppAssets.imgEmptyCart,
                            height: 150.0.h,
                          ),
                          10.hBox,
                          Text(
                            'No items in cart',
                            style: TextStyle(
                              fontSize: 18.0.sp,
                              color: AppColors.black,
                            ),
                          ),
                        ],
                      ),
                    )
                  : Column(
                      children: [
                        Expanded(
                          child: Obx(
                            () => ListView.separated(
                              itemCount: controller.cartItems.length,
                              padding: const EdgeInsets.only(
                                  left: 10, right: 10, bottom: 16, top: 2),
                              separatorBuilder: (context, index) => 10.hBox,
                              itemBuilder: (context, index) {
                                final item = controller.cartItems[index];
                                return CartItemWidget(
                                  product: item,
                                  onRemove: () {
                                    controller
                                        .removeProductFromCart((item.id ?? 1));
                                  },
                                  onIncrease: () {
                                    controller.increaseProductQty(item);
                                  },
                                  onDecrease: () {
                                    controller.decreaseProductQty(item);
                                  },
                                );
                              },
                            ),
                          ),
                        ),
                        Container(
                          decoration: BoxDecoration(
                            color: AppColors.white,
                          ),
                          padding: const EdgeInsets.only(
                              left: 16, right: 16, bottom: 16),
                          child: Column(
                            children: [
                              8.hBox,
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    'Total',
                                    style: TextStyle(
                                      fontSize: 18.0.sp,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  Obx(
                                    () => Text(
                                      '\$${controller.totalRsCount.value.toStringAsFixed(2)}',
                                      style: TextStyle(
                                        fontSize: 18.0.sp,
                                        fontWeight: FontWeight.bold,
                                        color: AppColors.primary,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              10.hBox,
                              ElevatedButton(
                                onPressed: () {
                                  HiveService.clearAllProducts();
                                  controller.cartItems.clear();
                                  controller.totalRsCount.value = 0.0;
                                },
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: AppColors.primary,
                                  minimumSize: Size(double.infinity, 40.0.h),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: 50.radius,
                                  ),
                                ),
                                child: Text(
                                  'Checkout',
                                  style: TextStyle(
                                    fontSize: 18.0.sp,
                                    color: AppColors.black,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
            ),
          )
        ],
      ),
    );
  }
}
