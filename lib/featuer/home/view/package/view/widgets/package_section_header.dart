import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../../core/theme/app_text_style.dart';

class PackageSectionHeader extends StatelessWidget {
  final String title;
  final EdgeInsetsGeometry? margin;

  const PackageSectionHeader({
    super.key,
    required this.title,
    this.margin,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: margin ?? EdgeInsets.only(bottom: 12.h),
      child: Text(
        title,
        style: AppTextStyle.setelMessiriBlack(
          fontSize: 18.sp,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
