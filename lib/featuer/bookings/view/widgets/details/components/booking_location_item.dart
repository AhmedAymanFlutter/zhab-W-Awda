import 'package:flutter/material.dart';
import 'package:flutter_application_1/core/theme/app_text_style.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class BookingLocationItem extends StatelessWidget {
  final String label;
  final String city;
  final String country;
  final String airport;
  final String formattedDateTime;
  final bool isLeft;

  const BookingLocationItem({
    super.key,
    required this.label,
    required this.city,
    required this.country,
    required this.airport,
    required this.formattedDateTime,
    required this.isLeft,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: isLeft ? CrossAxisAlignment.start : CrossAxisAlignment.end,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          label,
          style: AppTextStyle.setelMessiriTextStyle(
            fontSize: 12,
            color: const Color(0xFF98A2B3),
            fontWeight: FontWeight.normal,
          ),
        ),
        SizedBox(height: 4.h),
        Text(
          "$city، $country",
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: AppTextStyle.setelMessiriBlack(
            fontSize: 14,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(height: 2.h),
        Text(
          airport,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: AppTextStyle.setelMessiriTextStyle(
            fontSize: 11,
            color: const Color(0xFF98A2B3),
            fontWeight: FontWeight.normal,
          ),
        ),
        SizedBox(height: 2.h),
        Text(
          formattedDateTime,
          style: AppTextStyle.setelMessiriTextStyle(
            fontSize: 11,
            color: const Color(0xFF98A2B3),
            fontWeight: FontWeight.normal,
          ),
        ),
      ],
    );
  }
}
