import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class TourBackgroundImage extends StatelessWidget {
  final String? imageUrl;

  const TourBackgroundImage({super.key, required this.imageUrl});

  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      imageUrl: imageUrl ?? "https://via.placeholder.com/240x291",
      fit: BoxFit.cover,
      placeholder: (context, url) => Container(
        color: Colors.grey[200],
        child: const Center(
          child: Icon(FontAwesomeIcons.image, color: Colors.grey),
        ),
      ),
      errorWidget: (context, url, error) => Container(
        color: Colors.grey[200],
        child: const Center(
          child: Icon(FontAwesomeIcons.circleExclamation, color: Colors.grey),
        ),
      ),
    );
  }
}
