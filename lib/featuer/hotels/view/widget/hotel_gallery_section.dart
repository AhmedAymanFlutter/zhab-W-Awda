import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'full_gallery_view.dart';

class HotelGallerySection extends StatelessWidget {
  final List<String>? images;

  const HotelGallerySection({super.key, this.images});

  @override
  Widget build(BuildContext context) {
    if (images == null || images!.isEmpty) return const SizedBox.shrink();

    final displayImages = images!.take(5).toList();

    return Column(
      children: [
        Row(
          children: [
            // Large Main Image
            Expanded(
              flex: 2,
              child: GestureDetector(
                onTap: () => _openGallery(context, 0),
                child: _buildImage(displayImages[0], height: 250.h),
              ),
            ),
            SizedBox(width: 8.w),
            // Two vertical smaller images
            Expanded(
              flex: 1,
              child: Column(
                children: [
                  if (displayImages.length > 1)
                    GestureDetector(
                      onTap: () => _openGallery(context, 1),
                      child: _buildImage(displayImages[1], height: 121.h),
                    ),
                  if (displayImages.length > 2) ...[
                    SizedBox(height: 8.h),
                    GestureDetector(
                      onTap: () => _openGallery(context, 2),
                      child: _buildImage(displayImages[2], height: 121.h),
                    ),
                  ],
                ],
              ),
            ),
          ],
        ),
        SizedBox(height: 8.h),
        Row(
          children: [
            if (displayImages.length > 3)
              Expanded(
                child: GestureDetector(
                  onTap: () => _openGallery(context, 3),
                  child: _buildImage(displayImages[3], height: 120.h),
                ),
              ),
            if (displayImages.length > 3) SizedBox(width: 8.w),
            if (displayImages.length > 4)
              Expanded(
                child: GestureDetector(
                  onTap: () => _openGallery(context, 4),
                  child: Stack(
                    children: [
                      _buildImage(displayImages[4], height: 120.h),
                      if (images!.length > 5)
                        Container(
                          height: 120.h,
                          decoration: BoxDecoration(
                            color: Colors.black.withOpacity(0.4),
                            borderRadius: BorderRadius.circular(12.r),
                          ),
                          child: Center(
                            child: Text(
                              "عرض الكل",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 16.sp,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                    ],
                  ),
                ),
              ),
          ],
        ),
      ],
    );
  }

  void _openGallery(BuildContext context, int initialIndex) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => FullGalleryView(
          images: images!,
          initialIndex: initialIndex,
        ),
      ),
    );
  }

  Widget _buildImage(String url, {required double height}) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(12.r),
      child: CachedNetworkImage(
        imageUrl: url,
        height: height,
        width: double.infinity,
        fit: BoxFit.cover,
        placeholder: (context, url) => Container(color: Colors.grey[200]),
        errorWidget: (context, url, error) => const Icon(Icons.error),
      ),
    );
  }
}
