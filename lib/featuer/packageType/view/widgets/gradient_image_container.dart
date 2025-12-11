import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class GradientImageContainer extends StatelessWidget {
  final String? imageUrl;
  final double? width;
  final double? height;
  final BorderRadiusGeometry? borderRadius;
  final Widget? child;

  const GradientImageContainer({
    super.key,
    required this.imageUrl,
    this.width,
    this.height,
    this.borderRadius,
    this.child,
  });

  @override
  Widget build(BuildContext context) {
    Widget imageStack = Stack(
      fit: StackFit.expand,
      children: [
        // 1. الصورة
        CachedNetworkImage(
          imageUrl: imageUrl ?? "https://via.placeholder.com/300",
          fit: BoxFit.cover,
          placeholder: (context, url) =>
              const Center(child: CircularProgressIndicator()),
          errorWidget: (context, url, error) =>
              const Icon(Icons.error, color: Colors.grey),
        ),
        // 2. التدرج اللوني (Gradient)
        Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [Colors.transparent, Colors.black.withOpacity(0.7)],
            ),
          ),
        ),
        // 3. المحتوى الإضافي
        if (child != null) child!,
      ],
    );

    if (borderRadius != null) {
      imageStack = ClipRRect(borderRadius: borderRadius!, child: imageStack);
    }

    return SizedBox(width: width, height: height, child: imageStack);
  }
}
