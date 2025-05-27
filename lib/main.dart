import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mack_cart_app/app/bindings/global_bindings.dart';
import 'package:mack_cart_app/app/routes/app_routes.dart';
import 'package:mack_cart_app/app/services/hive_service.dart';
import 'package:responsive_screen_utils/responsive_screen_utils.dart';

import 'app/constants/app_colors.dart';
import 'app/constants/app_constants.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await HiveService.initHive();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ResponsiveScreenUtilInit(
      child: GetMaterialApp(
        title: AppConstants.appName,
        debugShowCheckedModeBanner: false,
        initialBinding: InitialBinding(),
        getPages: AppRoutes.pages,
        initialRoute: AppRoutes.splash,
        defaultTransition: Transition.cupertino,
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: AppColors.primary),
          useMaterial3: true,
        ),
      ),
    );
  }
}
