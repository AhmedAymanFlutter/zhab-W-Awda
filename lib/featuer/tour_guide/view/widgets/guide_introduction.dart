import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/theme/app_text_style.dart';

class GuideIntroduction extends StatelessWidget {
  final String? text;

  const GuideIntroduction({super.key, this.text});

  @override
  Widget build(BuildContext context) {
    if (text == null || text!.isEmpty) return const SizedBox.shrink();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "نظرة عامة",
          style: AppTextStyle.setelMessiriBlack(
            fontSize: 22,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(height: 12.h),
        Text(
          text!,
          style: TextStyle(
            fontSize: 16.sp,
            color: Colors.grey[700],
            height: 1.6,
          ),
        ),
      ],
    );
  }
}
