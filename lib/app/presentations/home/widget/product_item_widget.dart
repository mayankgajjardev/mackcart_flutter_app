
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mack_cart_app/app/constants/app_colors.dart';
import 'package:mack_cart_app/app/constants/app_extension.dart';
import 'package:mack_cart_app/app/presentations/home/model/get_products_model.dart';
import 'package:mack_cart_app/app/routes/app_routes.dart';
import 'package:mack_cart_app/app/services/hive_service.dart';
import 'package:mack_cart_app/app/widgets/custom_image_view.dart';
import 'package:responsive_screen_utils/responsive_screen_size_extension.dart';

class ProductItemWidget extends StatelessWidget {
  final Product? product;
  final VoidCallback onAddToCart;
  final VoidCallback onRefresh;

  const ProductItemWidget(
      {super.key, required this.product, required this.onAddToCart, required this.onRefresh});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Get.toNamed(AppRoutes.productDetail,
            arguments: {'productId': product?.id})?.then(
          (value) {
            onRefresh.call();
          },
        );
      },
      child: Card(
        color: AppColors.white,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CustomImageView(
              src: product?.thumbnail ?? '',
              height: 80.0.h,
              fit: BoxFit.cover,
            ),
            Align(
              alignment: Alignment.centerLeft,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  product?.title ?? '',
                  maxLines: 2,
                  style: TextStyle(
                    fontSize: 14.0.sp,
                    height: 1.1,
                  ),
                ),
              ),
            ),
            Align(
              alignment: Alignment.centerLeft,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: Text(
                  '\$${(product?.price ?? 00)}',
                  style: TextStyle(
                    fontSize: 14.0.sp,
                    color: AppColors.primary,
                  ),
                ),
              ),
            ),
            2.hBox,
            ElevatedButton(
              onPressed: onAddToCart,
              style: ElevatedButton.styleFrom(
                minimumSize: Size(10.0.w, 28.0.h),
                padding: EdgeInsets.symmetric(vertical: 0, horizontal: 14.0.w),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30.0),
                ),
                backgroundColor: AppColors.primary,
              ),
              child: Text(
                HiveService.isProductAddedToCart(product?.id ?? 0)
                    ? 'Remove'
                    : 'Add to Cart',
                style: TextStyle(
                  fontSize: 13.0.sp,
                  color: AppColors.black,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
