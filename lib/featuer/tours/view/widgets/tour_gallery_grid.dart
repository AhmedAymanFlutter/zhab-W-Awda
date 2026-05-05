import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class TourGalleryGrid extends StatelessWidget {
  final List<String> images;

  const TourGalleryGrid({super.key, required this.images});

  @override
  Widget build(BuildContext context) {
    if (images.isEmpty) return const SizedBox.shrink();

    return SizedBox(
      height: 200.h,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Left Column: Small images
          Expanded(
            flex: 2,
            child: Column(
              children: [
                Expanded(
                  child: _buildImage(images.length > 1 ? images[1] : images[0], borderRadius: BorderRadius.only(topRight: Radius.circular(8.r))),
                ),
                SizedBox(height: 8.h),
                Row(
                  children: [
                    Expanded(
                      child: SizedBox(
                        height: 96.h,
                        child: _buildImage(
                          images.length > 2 ? images[2] : images[0],
                          overlay: images.length > 4 ? "+${images.length - 4}" : null,
                          borderRadius: BorderRadius.only(bottomRight: Radius.circular(8.r)),
                        ),
                      ),
                    ),
                    SizedBox(width: 8.w),
                    Expanded(
                      child: SizedBox(
                        height: 96.h,
                        child: _buildImage(images.length > 3 ? images[3] : images[0]),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          SizedBox(width: 8.w),
          // Right Column: Big image
          Expanded(
            flex: 3,
            child: _buildImage(images[0], borderRadius: BorderRadius.horizontal(left: Radius.circular(8.r))),
          ),
        ],
      ),
    );
  }

  Widget _buildImage(String url, {String? overlay, BorderRadius? borderRadius}) {
    return ClipRRect(
      borderRadius: borderRadius ?? BorderRadius.circular(8.r),
      child: Stack(
        fit: StackFit.expand,
        children: [
          CachedNetworkImage(
            imageUrl: url,
            fit: BoxFit.cover,
            placeholder: (context, url) => Container(color: Colors.grey[200]),
            errorWidget: (context, url, error) => const Icon(Icons.error),
          ),
          if (overlay != null)
            Container(
              color: Colors.black.withOpacity(0.4),
              child: Center(
                child: Text(
                  overlay,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18.sp,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}
