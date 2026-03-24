import 'package:flutter/material.dart';
import 'package:flutter_application_1/core/theme/app_color.dart';
import 'package:flutter_application_1/core/theme/app_text_style.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomTextField extends StatelessWidget {
  final String hintText;
  final String? labelText;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final bool isObscureText;
  final TextEditingController? controller;
  final String? Function(String?)? validator;
  final TextInputType? keyboardType;
  final bool isGlass;

  const CustomTextField({
    super.key,
    required this.hintText,
    this.labelText,
    this.prefixIcon,
    this.suffixIcon,
    this.isObscureText = false,
    this.controller,
    this.validator,
    this.keyboardType,
    this.isGlass = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: isGlass ? Colors.white.withOpacity(0.1) : AppColor.mainWhite,
        borderRadius: BorderRadius.circular(16.r),
        boxShadow: isGlass
            ? []
            : [
                BoxShadow(
                  color: Colors.black.withOpacity(0.05),
                  blurRadius: 10,
                  offset: const Offset(0, 4),
                ),
              ],
        border: isGlass
            ? Border.all(color: Colors.white.withOpacity(0.2), width: 1)
            : Border.all(color: AppColor.lightGrey.withOpacity(0.3), width: 1),
      ),
      child: TextFormField(
        controller: controller,
        obscureText: isObscureText,
        keyboardType: keyboardType,
        validator: validator,
        style: AppTextStyle.setelMessiriBlack(
          fontSize: 16,
          fontWeight: FontWeight.w500,
        ).copyWith(color: isGlass ? Colors.white : AppColor.mainBlack),
        decoration: InputDecoration(
          labelText: labelText,
          labelStyle:
              AppTextStyle.setelMessiriSecondlightGrey(
                fontSize: 14,
                fontWeight: FontWeight.normal,
              ).copyWith(
                color: isGlass ? Colors.white70 : AppColor.secondeLightGrey,
              ),
          hintText: hintText,
          hintStyle: AppTextStyle.setelMessirisecondaryGery(
            fontSize: 14,
            fontWeight: FontWeight.normal,
          ).copyWith(color: isGlass ? Colors.white54 : AppColor.secondaryGrey),
          prefixIcon: prefixIcon,
          suffixIcon: suffixIcon,
          border: InputBorder.none,
          contentPadding: EdgeInsets.symmetric(
            horizontal: 20.w,
            vertical: 16.h,
          ),
          errorStyle: const TextStyle(height: 0, color: Colors.transparent),
          // Hide default error text to keep design clean, or customize it if needed.
          // For now, we rely on the validator red border in standard implementation,
          // but since we are using Container decoration, we might need to handle error state visually if strict validation visualization is needed.
          // However, for this aesthetic, a simple clean input is prioritized.
        ),
      ),
    );
  }
}
