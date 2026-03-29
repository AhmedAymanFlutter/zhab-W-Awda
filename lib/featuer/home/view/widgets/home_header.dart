import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/theme/app_color.dart';
import '../../../../core/theme/app_text_style.dart';
import '../../../../core/widgets/main_app_header.dart';

class HomeHeader extends StatelessWidget {
  const HomeHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.only(
        bottomLeft: Radius.circular(24.r),
        bottomRight: Radius.circular(24.r),
      ),
      child: ClipPath(
        child: Container(
          height: 363.h,
          width: double.infinity,
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/photo/onboarding.png'),
              fit: BoxFit.cover,
            ),
          ),
          child: Stack(
            children: [
              // Dark Gradient Overlay for readability
              Container(decoration: BoxDecoration()),
              // Top Bar: Menu + Brand
              Positioned(
                top: MediaQuery.of(context).padding.top + 10.h,
                left: 20.w,
                right: 20.w,
                child: MainAppHeader(title: "ذهاب وعودة"),
              ),
              // Center Content
              Positioned(
                top: 140.h,
                left: 30.w,
                right: 30.w,
                child: Column(
                  children: [
                    Text(
                      "ذهاب وعودة... اكتشف وجهات العالم\nبثقة وسافر بتجربة متكاملة",
                      textAlign: TextAlign.center,
                      style: AppTextStyle.setelMessiriWhite(
                        fontSize: 20,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    SizedBox(height: 16.h),
                    Text(
                      "احجز رحلاتك وفنادقك وجولاتك السياحية بخطوات بسيطة وتجربة موثوقة تضمن لك راحة البال من الانطلاق حتى العودة.",
                      textAlign: TextAlign.center,
                      style: AppTextStyle.setelMessiriWhite(
                        fontSize: 12,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ],
                ),
              ),
              // Bottom Search Button
              Positioned(
                bottom: 20.h,
                left: 60.w,
                right: 60.w,
                child: InkWell(
                  onTap: () {},
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      maximumSize: Size(142.w, 41.h),
                      backgroundColor: AppColor.primaryBlue2,

                      padding: EdgeInsets.fromLTRB(16.w, 8.h, 16.w, 8.h),
                    ),
                    onPressed: () {},
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "استكشف رحلتك",
                          style: AppTextStyle.setelMessiriWhite(
                            fontSize: 16,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        SizedBox(width: 8.w),
                        Icon(Icons.search, color: Colors.white, size: 20.sp),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
