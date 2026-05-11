import 'package:flutter/material.dart';
import 'package:flutter_application_1/featuer/tours/data/model/get_tour_id_model.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class TourHeaderBanner extends StatelessWidget {
  final TourIdData tour;

  const TourHeaderBanner({super.key, required this.tour});

  @override
  Widget build(BuildContext context) {
    final mainImage = (tour.images != null && tour.images!.isNotEmpty)
        ? tour.images!.first
        : "https://images.unsplash.com/photo-1542314831-068cd1dbfeeb?w=800";

    return Stack(
      children: [
        // 1. Full-width Banner Image
        Image.network(
          mainImage,
          height: 350.h,
          width: double.infinity,
          fit: BoxFit.cover,
          errorBuilder: (context, error, stackTrace) => Container(
            height: 350.h,
            color: Colors.grey[200],
            child: Icon(
              Icons.image_not_supported_outlined,
              color: Colors.grey,
              size: 50.sp,
            ),
          ),
        ),

        // 2. Navigation Buttons Over Image
        Positioned(
          top: 40.h,
          left: 20.w,
          right: 20.w,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // Left buttons: Share & Bookmark
              Row(
                children: [
                  _buildCircularButton(Icons.share_outlined, () {}),
                  SizedBox(width: 12.w),
                  _buildCircularButton(Icons.bookmark_border, () {}),
                ],
              ),
              // Right button: Back
              _buildCircularButton(
                Icons.arrow_forward,
                () => Navigator.pop(context),
              ),
            ],
          ),
        ),

        // 3. Image Counter
        Positioned(
          bottom: 50.h, // Adjusted to be relative to the banner height
          right: 20.w,
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 4.h),
            decoration: BoxDecoration(
              color: Colors.black.withOpacity(0.4),
              borderRadius: BorderRadius.circular(20.r),
            ),
            child: Text(
              "1/${tour.images?.length ?? 1}",
              style: TextStyle(color: Colors.white, fontSize: 12.sp),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildCircularButton(IconData icon, VoidCallback onTap) {
    return InkWell(
      onTap: onTap,
      child: Container(
        width: 40.h,
        height: 40.h,
        decoration: BoxDecoration(
          color: Colors.black.withOpacity(0.3),
          shape: BoxShape.circle,
        ),
        child: Icon(icon, color: Colors.white, size: 20.sp),
      ),
    );
  }
}
