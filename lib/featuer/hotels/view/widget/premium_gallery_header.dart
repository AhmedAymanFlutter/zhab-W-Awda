import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:skeletonizer/skeletonizer.dart';

class PremiumGalleryHeader extends StatefulWidget {
  final String? image;
  final List<String>? images;

  const PremiumGalleryHeader({
    super.key,
    required this.image,
    required this.images,
  });

  @override
  State<PremiumGalleryHeader> createState() => _PremiumGalleryHeaderState();
}

class _PremiumGalleryHeaderState extends State<PremiumGalleryHeader> {
  late String selectedImage;
  late List<String> galleryImages;

  @override
  void initState() {
    super.initState();
    selectedImage = widget.image ?? "https://via.placeholder.com/600";
    galleryImages = widget.images != null && widget.images!.isNotEmpty
        ? widget.images!
        : [selectedImage];

    // Ensure the main image is the first in the gallery list if not already present
    // or just rely on the passed list.
    if (widget.images != null &&
        widget.images!.isNotEmpty &&
        !widget.images!.contains(selectedImage)) {
      galleryImages.insert(0, selectedImage);
    }
  }

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      expandedHeight: 420.h,
      pinned: true,
      leading: _buildBackButton(context),
      actions: [
        _buildActionButton(Icons.favorite_border),
        SizedBox(width: 8.w),
        _buildActionButton(Icons.share),
        SizedBox(width: 16.w),
      ],
      flexibleSpace: FlexibleSpaceBar(
        background: Stack(
          fit: StackFit.expand,
          children: [
            // --- Main Hero Image ---
            AnimatedSwitcher(
              duration: const Duration(milliseconds: 300),
              child: CachedNetworkImage(
                key: ValueKey(selectedImage),
                imageUrl: selectedImage,
                fit: BoxFit.cover,
                height: double.infinity,
                width: double.infinity,
                placeholder: (context, url) =>
                    Skeletonizer(child: Container(color: Colors.grey[200])),
                errorWidget: (context, url, error) => Container(
                  color: Colors.grey[200],
                  child: const Icon(Icons.error),
                ),
              ),
            ),

            // --- Gradient Overlay (Top) ---
            Align(
              alignment: Alignment.topCenter,
              child: Container(
                height: 120.h,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [Colors.black.withOpacity(0.5), Colors.transparent],
                  ),
                ),
              ),
            ),

            // --- Gradient Overlay (Bottom) ---
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                height: 150.h,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.bottomCenter,
                    end: Alignment.topCenter,
                    colors: [Colors.black.withOpacity(0.8), Colors.transparent],
                  ),
                ),
              ),
            ),

            // --- Thumbnail Gallery ---
            Positioned(
              bottom: 20.h,
              left: 0,
              right: 0,
              child: SizedBox(
                height: 70.h,
                child: ListView.separated(
                  padding: EdgeInsets.symmetric(horizontal: 20.w),
                  scrollDirection: Axis.horizontal,
                  itemCount: galleryImages.length,
                  separatorBuilder: (_, __) => SizedBox(width: 12.w),
                  itemBuilder: (context, index) {
                    final img = galleryImages[index];
                    final isSelected = img == selectedImage;

                    return GestureDetector(
                      onTap: () {
                        setState(() {
                          selectedImage = img;
                        });
                      },
                      child: Container(
                        width: 70.h,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12.r),
                          border: isSelected
                              ? Border.all(color: Colors.white, width: 2.w)
                              : null,
                          boxShadow: [
                            if (isSelected)
                              BoxShadow(
                                color: Colors.black.withOpacity(0.3),
                                blurRadius: 8,
                                offset: const Offset(0, 4),
                              ),
                          ],
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(10.r),
                          child: CachedNetworkImage(
                            imageUrl: img,
                            fit: BoxFit.cover,
                            placeholder: (_, __) =>
                                Container(color: Colors.grey[300]),
                            errorWidget: (_, __, ___) =>
                                const Icon(Icons.error, size: 16),
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBackButton(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(8.w),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.2), // Glassmorphism effect
        shape: BoxShape.circle,
        border: Border.all(color: Colors.white.withOpacity(0.3), width: 1),
      ),
      child: IconButton(
        icon: const Icon(
          Icons.arrow_back_ios_new,
          color: Colors.white,
          size: 20,
        ),
        onPressed: () => Navigator.pop(context),
      ),
    );
  }

  Widget _buildActionButton(IconData icon) {
    return Container(
      width: 40.w,
      height: 40.w,
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.2), // Glassmorphism
        shape: BoxShape.circle,
        border: Border.all(color: Colors.white.withOpacity(0.3), width: 1),
      ),
      child: Icon(icon, color: Colors.white, size: 22),
    );
  }
}
