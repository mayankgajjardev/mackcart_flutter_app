import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class CustomImageView extends StatelessWidget {
  final String src;
  final BoxFit fit;
  final double? width;
  final double? height;
  final Widget? placeholder;
  final Widget? errorWidget;

  const CustomImageView({
    super.key,
    required this.src,
    this.fit = BoxFit.cover,
    this.width,
    this.height,
    this.placeholder,
    this.errorWidget,
  });

  bool get _isNetworkUrl =>
      src.startsWith('http://') || src.startsWith('https://');

  @override
  Widget build(BuildContext context) {
    if (_isNetworkUrl) {
      return RepaintBoundary(
        key: ValueKey(src),
        child: CachedNetworkImage(
          imageUrl: src,
          fit: fit,
          width: width,
          height: height,
          placeholder: (context, url) =>
              placeholder ?? const Center(child: CircularProgressIndicator()),
          errorWidget: (context, url, error) =>
              errorWidget ??
              Icon(Icons.error, size: width != null ? width! / 2 : 24),
        ),
      );
    } else {
      return Image.asset(
        src,
        fit: fit,
        width: width,
        height: height,
      );
    }
  }
}
