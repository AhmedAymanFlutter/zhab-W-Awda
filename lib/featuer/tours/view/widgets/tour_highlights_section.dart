import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/theme/app_text_style.dart';

class TourHighlightsSection extends StatelessWidget {
  final String title;
  final double? rating;
  final int? ratingCount;
  final List<String>? tags;
  final int? duration;
  final String? city;
  final String? country;

  const TourHighlightsSection({
    super.key,
    required this.title,
    this.rating,
    this.ratingCount,
    this.tags,
    this.duration,
    this.city,
    this.country,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Title
        Text(
          title,
          textAlign: TextAlign.right,
          style: AppTextStyle.setelMessiriBlack(
            fontSize: 22,
            fontWeight: FontWeight.bold,
          ).copyWith(height: 1.4),
        ),

        SizedBox(height: 8.h),

        // Rating
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Text(
              "($ratingCount تقييم)",
              style: TextStyle(color: Colors.grey[500], fontSize: 12.sp),
            ),
            SizedBox(width: 4.w),
            Text(
              "$rating نجوم",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 12.sp,
                color: Colors.grey[800],
              ),
            ),
            SizedBox(width: 4.w),
            ...List.generate(
              5,
              (index) => Icon(
                Icons.star_rounded,
                color: index < (rating ?? 0).floor()
                    ? Colors.amber[400]
                    : Colors.grey[300],
                size: 16.sp,
              ),
            ),
          ],
        ),

        SizedBox(height: 16.h),

        // Location & Share
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            // Share Button
            OutlinedButton.icon(
              onPressed: () {},
              icon: Icon(
                Icons.share_outlined,
                size: 18.sp,
                color: Colors.black87,
              ),
              label: Text(
                "شارك",
                style: TextStyle(
                  fontSize: 14.sp,
                  color: Colors.black87,
                  fontWeight: FontWeight.bold,
                ),
              ),
              style: OutlinedButton.styleFrom(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8.r),
                ),
                side: BorderSide(color: Colors.grey[300]!),
                padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
              ),
            ),

            // Location
            Expanded(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Flexible(
                    child: Text(
                      "${city ?? ''}${city != null && country != null ? '، ' : ''}${country ?? ''}",
                      style: TextStyle(color: Colors.grey[600], fontSize: 14.sp),
                      overflow: TextOverflow.ellipsis,
                      textAlign: TextAlign.right,
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
            ),
          ],
        ),

        Divider(height: 32.h, color: Colors.grey[100]),
      ],
    );
  }
}
