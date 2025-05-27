import 'package:flutter/material.dart';
import 'package:mack_cart_app/app/constants/app_colors.dart';
import 'package:mack_cart_app/app/constants/app_extension.dart';
import 'package:mack_cart_app/app/services/api_result.dart';
import 'package:mack_cart_app/app/widgets/loader.dart';

class ApiStateBuilder<T> extends StatelessWidget {
  final ApiResult<T> result;
  final Widget Function(T data) onSuccess;
  final Widget? loading;
  final Widget Function(String message)? onError;
  final Function()? onRetry;

  const ApiStateBuilder({
    super.key,
    required this.result,
    required this.onSuccess,
    this.loading,
    this.onError,
    this.onRetry,
  });

  @override
  Widget build(BuildContext context) {
    if (result is ApiLoading) {
      return loading ?? const Loader();
    } else if (result is ApiError) {
      final message = (result as ApiError).message;
      return onError?.call(message) ??
          Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  InkWell(
                    onTap: () {
                      onRetry?.call();
                    },
                    borderRadius: 50.radius,
                    child: RotatedBox(
                      quarterTurns: 4,
                      child: Icon(
                        Icons.refresh_rounded,
                        size: 50.0,
                        color: AppColors.black,
                      ),
                    ),
                  ),
                  5.hBox,
                  Text(
                    'Error: $message',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: AppColors.black,
                      fontSize: 17.0,
                      fontWeight: FontWeight.normal,
                    ),
                  ),
                ],
              ),
            ),
          );
    } else if (result is ApiSuccess<T>) {
      return onSuccess((result as ApiSuccess<T>).data);
    } else {
      return const SizedBox();
    }
  }
}
