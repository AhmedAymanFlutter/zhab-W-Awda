import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/theme/app_color.dart';
import '../../../../core/theme/app_text_style.dart';

class SectionHeader extends StatelessWidget {
  final String title;
  final VoidCallback onShowMoreTap;

  const SectionHeader({
    super.key,
    required this.title,
    required this.onShowMoreTap,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 10.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // زر عرض المزيد (يسار)
          InkWell(
            onTap: onShowMoreTap,
            child: Text(
              "عرض المزيد",
              style: AppTextStyle.setelMessiriTextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w600,
                color: AppColor.primaryBlue,
              ).copyWith(decoration: TextDecoration.underline),
            ),
          ),

          // العنوان (يمين - لأن التطبيق عربي)
          Container(
            padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 4.h),
            decoration: BoxDecoration(
              border: Border.all(color: AppColor.lightGrey, width: 1),
              borderRadius: BorderRadius.circular(20.r),
              color: AppColor.primaryBlue,
            ),
            child: Text(
              title,
              style: AppTextStyle.setelMessiriTextStyle(
                fontSize: 14,
                fontWeight: FontWeight.bold,
                color: AppColor.primaryRed,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
