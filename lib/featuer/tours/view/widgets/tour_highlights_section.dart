import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/theme/app_text_style.dart';

class TourHighlightsSection extends StatelessWidget {
  final String title;
  final double? rating;
  final int? ratingCount;
  final String? city;
  final String? country;

  const TourHighlightsSection({
    super.key,
    required this.title,
    this.rating,
    this.ratingCount,
    this.city,
    this.country,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        // Title
        Text(
          title,
          textAlign: TextAlign.right,
          textDirection: TextDirection.rtl,
          style: AppTextStyle.setelMessiriBlack(
            fontSize: 22,
            fontWeight: FontWeight.bold,
          ).copyWith(height: 1.4),
        ),

        SizedBox(height: 8.h),

        // Location
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Flexible(
              child: Text(
                "${city ?? ''}${city != null && country != null ? '، ' : ''}${country ?? ''}",
                style: TextStyle(
                  color: Colors.grey[600],
                  fontSize: 14.sp,
                  fontFamily: 'ElMessiri',
                ),
                textAlign: TextAlign.right,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            SizedBox(width: 4.w),
            Icon(
              Icons.location_on_outlined,
              color: Colors.grey[400],
              size: 18.sp,
            ),
          ],
        ),

        SizedBox(height: 8.h),

        // Rating
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Text(
              "($ratingCount تقييم)",
              style: TextStyle(
                color: Colors.grey[500],
                fontSize: 12.sp,
                fontFamily: 'ElMessiri',
              ),
            ),
            SizedBox(width: 4.w),
            Text(
              "$rating نجوم",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 12.sp,
                color: Colors.grey[800],
                fontFamily: 'ElMessiri',
              ),
            ),
            SizedBox(width: 8.w),
            ...List.generate(
              5,
              (index) => Icon(
                Icons.star_rounded,
                color: index < (rating ?? 0).floor()
                    ? Colors.amber[400]
                    : Colors.grey[300],
                size: 18.sp,
              ),
            ),
          ],
        ),

        SizedBox(height: 16.h),
      ],
    );
  }
}
