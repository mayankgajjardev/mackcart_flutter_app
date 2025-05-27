import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mack_cart_app/app/constants/app_assets.dart';
import 'package:mack_cart_app/app/routes/app_routes.dart';
import 'package:mack_cart_app/app/widgets/base_scaffold.dart';
import 'package:mack_cart_app/app/widgets/custom_image_view.dart';
import 'package:responsive_screen_utils/responsive_screen_size_extension.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Future.delayed(1.seconds, () {
      Get.offAllNamed(AppRoutes.home);
    });
  }

  @override
  Widget build(BuildContext context) {
    return BaseScaffold(
      child: Center(
        child: CustomImageView(
          src: AppAssets.appLogo,
          fit: BoxFit.cover,
          height: 120.0.h,
        ),
      ),
    );
  }
}
