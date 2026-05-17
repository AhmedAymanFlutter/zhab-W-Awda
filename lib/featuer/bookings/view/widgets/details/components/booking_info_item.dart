import 'package:flutter/material.dart';
import 'package:flutter_application_1/core/theme/app_text_style.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class BookingInfoItem extends StatelessWidget {
  final String label;
  final String value;
  final String? subValue;

  const BookingInfoItem({
    super.key,
    required this.label,
    required this.value,
    this.subValue,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          label,
          style: AppTextStyle.setelMessiriTextStyle(
            fontSize: 12,
            color: const Color(0xFF98A2B3),
            fontWeight: FontWeight.normal,
          ),
        ),
        SizedBox(height: 2.h),
        Text(
          value,
          style: AppTextStyle.setelMessiriBlack(
            fontSize: 14,
            fontWeight: FontWeight.bold,
          ),
        ),
        if (subValue != null)
          Text(
            subValue!,
            style: AppTextStyle.setelMessiriTextStyle(
              fontSize: 12,
              color: const Color(0xFF98A2B3),
              fontWeight: FontWeight.normal,
            ),
          ),
      ],
    );
  }
}
