import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../../core/theme/app_color.dart';
import '../../../../../../core/theme/app_text_style.dart';

class PackageInfoChip extends StatelessWidget {
  final IconData icon;
  final String label;

  const PackageInfoChip({super.key, required this.icon, required this.label});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
      decoration: BoxDecoration(
        color: AppColor.primaryBlue.withOpacity(0.08),
        borderRadius: BorderRadius.circular(20.r),
        border: Border.all(color: AppColor.primaryBlue.withOpacity(0.1)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 16.sp, color: AppColor.primaryBlue),
          SizedBox(width: 6.w),
          Text(
            label,
            style: AppTextStyle.setelMessiriBlack(
              fontSize: 12,
              fontWeight: FontWeight.bold,
            ).copyWith(color: AppColor.primaryBlue),
          ),
        ],
      ),
    );
  }
}
