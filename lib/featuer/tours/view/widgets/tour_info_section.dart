import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/theme/app_color.dart';
import '../../../../core/theme/app_text_style.dart';

class TourInfoSection extends StatelessWidget {
  final String? title;
  final String? city;
  final String? country;
  final String? description;

  const TourInfoSection({
    super.key,
    this.title,
    this.city,
    this.country,
    this.description,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Title & Location
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title ?? "عنوان الجولة",
                    style: AppTextStyle.setelMessiriBlack(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ).copyWith(height: 1.2),
                  ),
                  SizedBox(height: 8.h),
                  if (city != null || country != null)
                    Row(
                      children: [
                        Icon(
                          Icons.location_on_outlined,
                          size: 16.sp,
                          color: AppColor.primaryBlue,
                        ),
                        SizedBox(width: 4.w),
                        Text(
                          "${city ?? ''}, ${country ?? ''}",
                          style: TextStyle(
                            fontSize: 14.sp,
                            color: Colors.grey[600],
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                ],
              ),
            ),
          ],
        ),

        SizedBox(height: 32.h),
      ],
    );
  }
}
