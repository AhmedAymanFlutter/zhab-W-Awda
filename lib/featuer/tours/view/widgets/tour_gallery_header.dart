import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/theme/app_color.dart';

class TourGalleryHeader extends StatefulWidget {
  final List<String> images;
  final String? imageCover;

  const TourGalleryHeader({
    super.key,
    required this.images,
    this.imageCover,
  });

  @override
  State<TourGalleryHeader> createState() => _TourGalleryHeaderState();
}

class _TourGalleryHeaderState extends State<TourGalleryHeader> {
  int _currentIndex = 0;
  late List<String> _allImages;

  @override
  void initState() {
    super.initState();
    _allImages = widget.images.isNotEmpty 
        ? widget.images 
        : (widget.imageCover != null ? [widget.imageCover!] : []);
  }

  @override
  Widget build(BuildContext context) {
    if (_allImages.isEmpty) {
      return SliverToBoxAdapter(
        child: Container(
          height: 300.h,
          color: Colors.grey[200],
          child: const Icon(Icons.image_not_supported_outlined, size: 50),
        ),
      );
    }

    return SliverAppBar(
      expandedHeight: 350.h,
      pinned: true,
      stretch: true,
      backgroundColor: AppColor.primaryBlue,
      leading: Padding(
        padding: EdgeInsets.all(8.0.w),
        child: CircleAvatar(
          backgroundColor: Colors.white.withOpacity(0.9),
          child: IconButton(
            icon: const Icon(Icons.arrow_back, color: Colors.black87),
            onPressed: () => Navigator.pop(context),
          ),
        ),
      ),
      actions: [
        Padding(
          padding: EdgeInsets.all(8.0.w),
          child: CircleAvatar(
            backgroundColor: Colors.white.withOpacity(0.9),
            child: IconButton(
              icon: const Icon(Icons.share_outlined, color: Colors.black87),
              onPressed: () {},
            ),
          ),
        ),
        Padding(
          padding: EdgeInsets.all(8.0.w),
          child: CircleAvatar(
            backgroundColor: Colors.white.withOpacity(0.9),
            child: IconButton(
              icon: const Icon(Icons.favorite_border, color: Colors.black87),
              onPressed: () {},
            ),
          ),
        ),
      ],
      flexibleSpace: FlexibleSpaceBar(
        background: Stack(
          fit: StackFit.expand,
          children: [
            PageView.builder(
              itemCount: _allImages.length,
              onPageChanged: (index) {
                setState(() {
                  _currentIndex = index;
                });
              },
              itemBuilder: (context, index) {
                return CachedNetworkImage(
                  imageUrl: _allImages[index],
                  fit: BoxFit.cover,
                  placeholder: (context, url) => Container(
                    color: Colors.grey[200],
                    child: const Center(child: CircularProgressIndicator()),
                  ),
                  errorWidget: (context, url, error) => const Icon(Icons.error),
                );
              },
            ),
            // Gradient Overlay
            Positioned.fill(
              child: DecoratedBox(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Colors.black.withOpacity(0.3),
                      Colors.transparent,
                      Colors.black.withOpacity(0.4),
                    ],
                  ),
                ),
              ),
            ),
            // Indicators
            if (_allImages.length > 1)
              Positioned(
                bottom: 50.h,
                left: 0,
                right: 0,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: List.generate(
                    _allImages.length,
                    (index) => AnimatedContainer(
                      duration: const Duration(milliseconds: 300),
                      margin: EdgeInsets.symmetric(horizontal: 4.w),
                      width: _currentIndex == index ? 24.w : 8.w,
                      height: 8.w,
                      decoration: BoxDecoration(
                        color: _currentIndex == index
                            ? Colors.white
                            : Colors.white.withOpacity(0.5),
                        borderRadius: BorderRadius.circular(4.r),
                      ),
                    ),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
