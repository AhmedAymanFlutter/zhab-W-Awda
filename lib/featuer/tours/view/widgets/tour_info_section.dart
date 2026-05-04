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

  bool _isId(String? text) {
    if (text == null) return false;
    // Check if it's a 24-character hex string (MongoDB ID)
    final idRegex = RegExp(r'^[a-fA-F0-9]{24}$');
    return idRegex.hasMatch(text);
  }

  @override
  Widget build(BuildContext context) {
    final displayCity = _isId(city) ? null : city;
    final displayCountry = _isId(country) ? null : country;
    final hasLocation = displayCity != null || displayCountry != null;

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
                  if (hasLocation)
                    Row(
                      children: [
                        Icon(
                          Icons.location_on_outlined,
                          size: 16.sp,
                          color: AppColor.primaryBlue,
                        ),
                        SizedBox(width: 4.w),
                        Expanded(
                          child: Text(
                            "${displayCity ?? ''}${displayCity != null && displayCountry != null ? ', ' : ''}${displayCountry ?? ''}",
                            style: TextStyle(
                              fontSize: 14.sp,
                              color: Colors.grey[600],
                              fontWeight: FontWeight.w500,
                            ),
                            overflow: TextOverflow.ellipsis,
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
