import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class PackageHeaderImage extends StatelessWidget {
  final String? imageUrl;

  const PackageHeaderImage({super.key, this.imageUrl});

  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      imageUrl: imageUrl ?? "https://via.placeholder.com/400",
      fit: BoxFit.cover,
      placeholder: (context, url) => Container(color: Colors.grey[200]),
      errorWidget: (context, url, error) => Container(color: Colors.grey[200]),
    );
  }
}
