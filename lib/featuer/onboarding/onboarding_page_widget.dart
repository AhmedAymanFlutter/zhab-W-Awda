import 'package:flutter/material.dart';
import 'package:flutter_application_1/core/theme/app_text_style.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:flutter_svg/flutter_svg.dart';
import 'onboarding_data.dart';

class OnboardingPageWidget extends StatelessWidget {
  final OnboardingPage page;

  const OnboardingPageWidget({super.key, required this.page});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 24.w),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Spacer(flex: 5), // Increased flex to push text down
          Text(
            page.title,
            textAlign: TextAlign.center,
            style: AppTextStyle.setelMessiriWhite(
              fontSize: 28.sp, // Slightly larger
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 16.h),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 16.w),
            child: Text(
              page.description,
              textAlign: TextAlign.center,
              style: AppTextStyle.setelMessiriWhite(
                fontSize: 18.sp,
                fontWeight: FontWeight.w400,
              ).copyWith(color: Colors.white.withOpacity(0.9)),
            ),
          ),
          const Spacer(flex: 1),
        ],
      ),
    );
  }
}
