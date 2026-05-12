import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/theme/app_text_style.dart';

class HomeHeaderCenterText extends StatelessWidget {
  const HomeHeaderCenterText({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          "اكتشف العالم بطريقتك",
          textAlign: TextAlign.center,
          style: AppTextStyle.setelMessiriWhite(
            fontSize: 24.sp,
            fontWeight: FontWeight.w600,
          ),
        ),
        SizedBox(height: 8.h),
        Text(
          "استمتع بأفضل الوجهات والباقات السياحية المصممة خصيصًا لك.",
          textAlign: TextAlign.center,
          style: AppTextStyle.setelMessiriWhite(
            fontSize: 14.sp,
            fontWeight: FontWeight.w400,
          ),
        ),
      ],
    );
  }
}
