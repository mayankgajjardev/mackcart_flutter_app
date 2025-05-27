import 'package:flutter/material.dart';
import 'package:mack_cart_app/app/constants/app_colors.dart';

class Loader extends StatelessWidget {
  const Loader({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: CircularProgressIndicator(
        valueColor: AlwaysStoppedAnimation<Color>(AppColors.primary),
        strokeWidth: 4.0,
        backgroundColor: Colors.transparent,
      ),
    );
  }
}
