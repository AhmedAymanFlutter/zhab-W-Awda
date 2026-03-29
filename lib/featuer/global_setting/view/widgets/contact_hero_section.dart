import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_application_1/core/theme/app_color.dart';
import 'package:flutter_application_1/core/theme/app_text_style.dart';
import 'package:flutter_application_1/core/widgets/stat_badge.dart';

class ContactHeroSection extends StatelessWidget {
  final VoidCallback? onContactTap;

  const ContactHeroSection({super.key, this.onContactTap});

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.only(
        bottomLeft: Radius.circular(28.r),
        bottomRight: Radius.circular(28.r),
      ),
      child: Container(
        width: double.infinity,
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/photo/onboarding.png'),
            fit: BoxFit.cover,
          ),
        ),
        child: Container(
          // Dark overlay for readability
          decoration: BoxDecoration(
            color: AppColor.primaryBlue.withValues(alpha: 0.82),
          ),
          padding: EdgeInsets.fromLTRB(20.w, 56.h, 20.w, 24.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                "ذهاب وعودة",
                style: AppTextStyle.setelMessiriWhite(
                  fontSize: 28,
                  fontWeight: FontWeight.w900,
                ),
              ),
              Text(
                "للسفر والسياحة",
                style: AppTextStyle.setelMessiriWhite(
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                ),
              ),
              SizedBox(height: 12.h),
              Text(
                "نساعدك في التخطيط لرحلاتك بسهولة، من خيار الطيران والفنادق إلى اختيار أفضل الجولات السياحية لتقديم خدمات سفر متكاملة، تحرص على تقديم أفضل تجربة لك للوصول إلى كل رحلة راحة ورفاة.",
                textAlign: TextAlign.center,
                style: AppTextStyle.setelMessiriWhite(
                  fontSize: 12,
                  fontWeight: FontWeight.w400,
                ).copyWith(height: 1.6),
              ),
              SizedBox(height: 20.h),
              // Contact CTA button
              InkWell(
                onTap: onContactTap,
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 12.h),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20.r),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        "تواصل معنا",
                        style: AppTextStyle.setelMessiriBlack(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                        ).copyWith(color: AppColor.primaryBlue),
                      ),
                      SizedBox(width: 8.w),
                      Icon(Icons.chevron_left, color: AppColor.primaryBlue, size: 18.sp),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 28.h),
              // Stats Row
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const StatBadge(number: "+200", label: "وجهة سفر حول العالم"),
                  SizedBox(width: 32.w),
                  const StatBadge(number: "+150", label: "عميل راضٍ تجربة سياحية"),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
