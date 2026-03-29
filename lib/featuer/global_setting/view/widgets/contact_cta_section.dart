import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_application_1/core/theme/app_color.dart';
import 'package:flutter_application_1/core/theme/app_text_style.dart';

/// Bottom CTA section with dark background, description text, and a button.
class ContactCtaSection extends StatelessWidget {
  final VoidCallback? onContactTap;

  const ContactCtaSection({super.key, this.onContactTap});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 16.w),
      padding: EdgeInsets.all(24.w),
      decoration: BoxDecoration(
        color: const Color(0xFF1A2A4A),
        borderRadius: BorderRadius.circular(20.r),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Text(
            "تواصل معنا بسهولة",
            textDirection: TextDirection.rtl,
            style: AppTextStyle.setelMessiriWhite(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 8.h),
          Text(
            "نحن هنا لمساعدتك في أي استفسار عن رحلاتك أو جولاتك. تواصل معنا وسيستجيب فريقنا في أقرب وقت.",
            textDirection: TextDirection.rtl,
            textAlign: TextAlign.right,
            style: AppTextStyle.setelMessiriWhite(
              fontSize: 12,
              fontWeight: FontWeight.w400,
            ).copyWith(height: 1.6, color: Colors.white70),
          ),
          SizedBox(height: 20.h),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton.icon(
              onPressed: onContactTap,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.white,
                foregroundColor: AppColor.primaryBlue,
                padding: EdgeInsets.symmetric(vertical: 14.h),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12.r),
                ),
              ),
              icon: Icon(Icons.chevron_left, size: 18.sp),
              label: Text(
                "تواصل معنا",
                style: AppTextStyle.setelMessiriBlack(
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                ).copyWith(color: AppColor.primaryBlue),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
