import 'package:flutter/material.dart';
import 'package:flutter_application_1/core/theme/app_color.dart';
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
          const Spacer(flex: 3),
          Image.asset(
            page.illustrationPath,
            height: 280.h,
            fit: BoxFit.contain,
            color: AppColor.primaryBlue,
          ),
          SizedBox(height: 48.h),
          Text(
            page.title,
            textAlign: TextAlign.center,
            style: AppTextStyle.setelMessiriBlack(
              fontSize: 24.sp,
              fontWeight: FontWeight.w600,
            ),
          ),
          SizedBox(height: 16.h),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 16.w),
            child: Text(
              page.description,
              textAlign: TextAlign.center,
              style: AppTextStyle.setelMessiriSecondlightGrey(
                fontSize: 16.sp,
                fontWeight: FontWeight.w400,
              ),
            ),
          ),
          const Spacer(flex: 2),
        ],
      ),
    );
  }
}
