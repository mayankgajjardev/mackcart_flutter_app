import 'package:flutter/material.dart';
import 'package:mack_cart_app/app/constants/app_colors.dart';

class BaseScaffold extends StatelessWidget {
  final Widget child;
  const BaseScaffold({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.offWhite,
      body: SafeArea(child: child),
    );
  }
}
