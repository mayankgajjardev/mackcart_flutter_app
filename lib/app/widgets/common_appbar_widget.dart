import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mack_cart_app/app/constants/app_extension.dart';

class CommonAppbarWidget extends StatelessWidget {
  final String title;
  const CommonAppbarWidget({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        16.wBox,
        InkWell(
          onTap: () {
            Get.back();
          },
          borderRadius: BorderRadius.circular(50),
          child: Container(
            padding: const EdgeInsets.all(4),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(color: Colors.black),
            ),
            child: const Icon(
              Icons.arrow_back_ios_rounded,
              size: 18.0,
            ),
          ),
        ),
        const Spacer(flex: 2),
         Text(
          title,
          style: const TextStyle(
            fontSize: 22.0,
            fontWeight: FontWeight.bold,
          ),
        ),
        const Spacer(flex: 3),
      ],
    );
  }
}
