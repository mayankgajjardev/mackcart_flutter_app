import 'package:flutter/material.dart';
import 'package:mack_cart_app/app/constants/app_assets.dart';
import 'package:mack_cart_app/app/constants/app_colors.dart';
import 'package:mack_cart_app/app/constants/app_extension.dart';
import 'package:mack_cart_app/app/presentations/home/model/get_products_model.dart';
import 'package:mack_cart_app/app/widgets/custom_image_view.dart';
import 'package:responsive_screen_utils/responsive_screen_size_extension.dart';

class CartItemWidget extends StatelessWidget {
  final Product? product;
  final VoidCallback onRemove;
  final VoidCallback onIncrease;
  final VoidCallback onDecrease;

  const CartItemWidget({super.key, this.product, required this.onRemove, required this.onIncrease, required this.onDecrease});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          margin: const EdgeInsets.only(top: 12, right: 8, left: 8),
          decoration: BoxDecoration(
            color: AppColors.white,
            borderRadius: 10.radius,
          ),
          child: ListTile(
            leading: CustomImageView(
              src: product?.thumbnail ?? '',
              height: 50.0.h,
              width: 50.0.w,
            ),
            title: Text(
              "${product?.title}",
              maxLines: 1,
              style: const TextStyle(
                height: 1.1,
              ),
            ),
            subtitle: Text(
              '\$${product?.price?.toStringAsFixed(2)}',
            ),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                IconButton(
                  highlightColor: AppColors.primary.withOpacity(0.2),
                  style: IconButton.styleFrom(
                    shape: RoundedRectangleBorder(
                        borderRadius: 50.radius,
                        side: BorderSide(
                          color: AppColors.primary,
                        )),
                    padding: const EdgeInsets.all(2),
                    minimumSize: Size(16.0.w, 16.0.h),
                  ),
                  icon: Icon(
                    Icons.remove,
                    color: AppColors.primary,
                  ),
                  onPressed: onDecrease,
                ),
                Text(
                  (product?.qty ?? 1).toString(),
                  style: TextStyle(
                    fontSize: 14.0.sp,
                    color: AppColors.black,
                  ),
                ), // ${item.quantity.toString()}
                IconButton(
                  icon: Icon(
                    Icons.add,
                    color: AppColors.white,
                  ),
                  style: IconButton.styleFrom(
                    shape: const CircleBorder(),
                    padding: const EdgeInsets.all(2),
                    minimumSize: Size(16.0.w, 16.0.h),
                    backgroundColor: AppColors.primary,
                  ),
                  onPressed:onIncrease,
                ),
              ],
            ),
          ),
        ),
        Positioned(
          top: 0,
          right: 0,
          child: InkWell(
            onTap: onRemove,
            child: Container(
              padding: const EdgeInsets.all(3),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: AppColors.primary,
              ),
              child: Icon(
                Icons.close_rounded,
                size: 16.0.h,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
