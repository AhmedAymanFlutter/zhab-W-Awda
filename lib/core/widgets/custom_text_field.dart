import 'package:flutter/material.dart';
import 'package:flutter_application_1/core/theme/app_color.dart';
import 'package:flutter_application_1/core/theme/app_text_style.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomTextField extends StatelessWidget {
  final String hintText;
  final Widget? leftIcon;
  final Widget? rightIcon;
  final bool isObscureText;
  final TextEditingController? controller;
  final String? Function(String?)? validator;
  final TextInputType? keyboardType;

  const CustomTextField({
    super.key,
    required this.hintText,
    this.leftIcon,
    this.rightIcon,
    this.isObscureText = false,
    this.controller,
    this.validator,
    this.keyboardType,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 295.w,
      height: 46.h,
      decoration: BoxDecoration(
        color: AppColor.mainWhite,
        borderRadius: BorderRadius.circular(10.r),
        border: Border.all(color: const Color(0xffEDF1F3), width: 1),
        boxShadow: const [
          BoxShadow(
            color: Color(0x3DE4E5E7),
            blurRadius: 2,
            offset: Offset(0, 1),
          ),
        ],
      ),
      child: TextFormField(
        controller: controller,
        obscureText: isObscureText,
        keyboardType: keyboardType,
        validator: validator,
        textAlign: TextAlign.right,
        style: AppTextStyle.setelMessiriBlack(
          fontSize: 14,
          fontWeight: FontWeight.w500,
        ),
        decoration: InputDecoration(
          isDense: true,
          hintText: hintText,
          hintStyle: AppTextStyle.setelMessirisecondaryGery(
            fontSize: 14,
            fontWeight: FontWeight.w500,
          ).copyWith(color: const Color(0xff1A1C1E)),
          suffixIcon: leftIcon,
          prefixIcon: rightIcon,
          border: InputBorder.none,
          contentPadding: EdgeInsets.symmetric(
            horizontal: 14.w,
            vertical: 12.h,
          ),
        ),
      ),
    );
  }
}
