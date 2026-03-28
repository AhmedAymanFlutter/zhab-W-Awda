import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/theme/app_color.dart';
import '../../../../core/theme/app_text_style.dart';

class ContactBanner extends StatelessWidget {
  const ContactBanner({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(24.w),
      decoration: BoxDecoration(
        color: AppColor.primaryBlue3, // Dark blue from the theme
        borderRadius: BorderRadius.circular(20.r),
        image: const DecorationImage(
          image: AssetImage('assets/photo/onboarding.png'), // Using a subtle background if needed, or just color
          fit: BoxFit.cover,
          opacity: 0.1,
        ),
      ),
      child: Column(
        children: [
          Text(
            "تواصل معنا بسهولة",
            style: AppTextStyle.setelMessiriWhite(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 8.h),
          Text(
            "نحن هنا لمساعدتك في أي استفسار عن رحلاتك أو حجوزاتك، تواصل معنا وسيسعد فريقنا بالرد عليك في أسرع وقت.",
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 12.sp,
              color: Colors.white70,
              fontFamily: 'Tajawal',
            ),
          ),
          SizedBox(height: 20.h),
          ElevatedButton(
            onPressed: () {},
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.white,
              foregroundColor: AppColor.primaryBlue3,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30.r),
              ),
              padding: EdgeInsets.symmetric(horizontal: 32.w, vertical: 12.h),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Icon(Icons.headset_mic_outlined, size: 20),
                SizedBox(width: 8.w),
                Text(
                  "تواصل معنا",
                  style: AppTextStyle.setelMessiriTextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: AppColor.primaryBlue3,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
