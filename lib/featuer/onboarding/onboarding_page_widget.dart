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
      padding: EdgeInsets.fromLTRB(32.w, 40.h, 32.w, 60.h),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Text(
            page.title,
            textAlign: TextAlign.center,
            style: AppTextStyle.setelMessiriWhite(
              fontSize: 30,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 16.h),
          Text(
            page.description,
            textAlign: TextAlign.center,
            style: AppTextStyle.setelMessiriWhite(
              fontSize: 16,
              fontWeight: FontWeight.w400,
            ).copyWith(
              color: Colors.white.withOpacity(0.85),
              height: 1.6,
            ),
          ),
        ],
      ),
    );
  }
}
