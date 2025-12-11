import 'package:flutter/material.dart';
import 'package:flutter_application_1/core/theme/app_color.dart';
import 'package:flutter_application_1/core/theme/app_text_style.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AppTextFormField extends StatelessWidget {
  final String hintText;
  final Widget? suffixIcon;
  final bool? isObscureText;
  final TextEditingController? controller;
  final String? Function(String?)? validator;
  final TextInputType? keyboardType;

  const AppTextFormField({
    super.key,
    required this.hintText,
    this.suffixIcon,
    this.isObscureText,
    this.controller,
    this.validator,
    this.keyboardType,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      // validator: validator,
      obscureText: isObscureText ?? false,
      keyboardType: keyboardType,
      // ستايل الكلام اللي اليوزر بيكتبه
      style: AppTextStyle.setelMessiriBlack(
        fontSize: 14,
        fontWeight: FontWeight.w500,
      ),
      decoration: InputDecoration(
        isDense: true,
        contentPadding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 18.h),
        hintText: hintText,
        // ستايل الكلام التوضيحي (Hint)
        hintStyle: AppTextStyle.setelMessirisecondaryGery(
          fontSize: 14,
          fontWeight: FontWeight.normal,
        ),
        suffixIcon: suffixIcon,
        enabledBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: AppColor.lightGrey, width: 1.3),
          borderRadius: BorderRadius.circular(16.0),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: AppColor.primaryBlue, width: 1.3),
          borderRadius: BorderRadius.circular(16.0),
        ),
        errorBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: Colors.red, width: 1.3),
          borderRadius: BorderRadius.circular(16.0),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: Colors.red, width: 1.3),
          borderRadius: BorderRadius.circular(16.0),
        ),
        fillColor: AppColor.primaryWhite,
        filled: true,
      ),
    );
  }
}
