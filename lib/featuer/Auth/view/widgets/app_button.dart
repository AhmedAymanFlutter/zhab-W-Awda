import 'package:flutter/material.dart';
import 'package:flutter_application_1/core/theme/app_text_style.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/theme/app_color.dart';

class AppButton extends StatelessWidget {
  final String buttonText;
  final VoidCallback onPressed;
  final double? width;
  final double? height;
  final Color? backgroundColor;

  const AppButton({
    super.key,
    required this.buttonText,
    required this.onPressed,
    this.width,
    this.height,
    this.backgroundColor,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width ?? double.infinity,
      height: height ?? 52.h,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: backgroundColor ?? AppColor.primaryBlue,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16.0),
          ),
          elevation: 0,
        ),
        onPressed: onPressed,
        child: Text(
          buttonText,
          style: AppTextStyle.setelMessiriWhite(
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
