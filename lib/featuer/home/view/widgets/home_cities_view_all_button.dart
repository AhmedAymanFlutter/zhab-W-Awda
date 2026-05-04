import 'package:flutter/material.dart';
import 'package:flutter_application_1/core/router/routes.dart';
import 'package:flutter_application_1/core/theme/app_color.dart';
import 'package:flutter_application_1/core/theme/app_text_style.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class HomeCitiesViewAllButton extends StatelessWidget {
  const HomeCitiesViewAllButton({super.key});

  @override
  Widget build(BuildContext context) {
    return TextButton.icon(
      onPressed: () => Navigator.pushNamed(context, Routes.cities),
      icon: Icon(FontAwesomeIcons.chevronLeft, size: 14.sp, color: AppColor.primaryBlue),
      label: Text(
        "عرض جميع الوجهات",
        style: AppTextStyle.setelMessiriTextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: AppColor.primaryBlue),
      ),
      style: TextButton.styleFrom(
        padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 12.h),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.r)),
      ),
    );
  }
}
