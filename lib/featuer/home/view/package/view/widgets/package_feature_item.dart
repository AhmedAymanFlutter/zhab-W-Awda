import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_application_1/core/theme/app_text_style.dart';

class PackageFeatureItem extends StatelessWidget {
  final String text;
  final bool isIncluded;

  const PackageFeatureItem({
    super.key,
    required this.text,
    required this.isIncluded,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: 8.h),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(
            isIncluded ? Icons.check_circle_outline : Icons.highlight_off,
            color: isIncluded ? Colors.green : Colors.red,
            size: 20.sp,
          ),
          SizedBox(width: 8.w),
          Expanded(
            child: Text(
              text,
              style: AppTextStyle.setelMessiriBlack(
                fontSize: 14,
                fontWeight: FontWeight.normal,
              ).copyWith(height: 1.4),
            ),
          ),
        ],
      ),
    );
  }
}
