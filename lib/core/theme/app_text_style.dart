import 'package:flutter/material.dart';
import 'package:flutter_application_1/core/theme/app_color.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTextStyle {
  static TextStyle setelMessiriTextStyle({
    required double fontSize,
    required FontWeight fontWeight,
    required Color color,
  }) {
    return GoogleFonts.elMessiri(
      fontSize: fontSize.sp,
      fontWeight: fontWeight,
      color: color,
    );
  }

  static TextStyle setelMessiriWhite({
    required double fontSize,
    required FontWeight fontWeight,
  }) {
    return GoogleFonts.elMessiri(
      fontSize: fontSize.sp,
      fontWeight: fontWeight,
      color: AppColor.mainWhite,
    );
  }

  static TextStyle setelMessiriSecondaryBlack({
    required double fontSize,
    required FontWeight fontWeight,
  }) {
    return GoogleFonts.elMessiri(
      fontSize: fontSize.sp,
      fontWeight: fontWeight,
      color: AppColor.secondaryBlack,
    );
  }

  static TextStyle setelMessiriSecondlightGrey({
    required double fontSize,
    required FontWeight fontWeight,
  }) {
    return GoogleFonts.elMessiri(
      fontSize: fontSize.sp,
      fontWeight: fontWeight,
      color: AppColor.secondeLightGrey,
    );
  }

  static TextStyle setelMessirisecondaryGery({
    required double fontSize,
    required FontWeight fontWeight,
  }) {
    return GoogleFonts.elMessiri(
      fontSize: fontSize.sp,
      fontWeight: fontWeight,
      color: AppColor.secondaryGrey,
    );
  }

  static TextStyle setelMessiriBlack({
    required double fontSize,
    required FontWeight fontWeight,
  }) {
    return GoogleFonts.elMessiri(
      fontSize: fontSize.sp,
      fontWeight: fontWeight,
      color: AppColor.mainBlack,
    );
  }

  static TextStyle setelMessiriDeepPurple({
    required double fontSize,
    required FontWeight fontWeight,
  }) {
    return GoogleFonts.elMessiri(
      fontSize: fontSize.sp,
      fontWeight: fontWeight,
      color: AppColor.lightPurple,
    );
  }
}
