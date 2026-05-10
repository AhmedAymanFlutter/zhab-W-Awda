import 'package:country_code_picker/country_code_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/core/theme/app_color.dart';
import 'package:flutter_application_1/core/theme/app_text_style.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomPhoneField extends StatelessWidget {
  final TextEditingController? controller;
  final String hintText;
  final Function(CountryCode)? onCountryChanged;

  final String? Function(String?)? validator;

  const CustomPhoneField({
    super.key,
    this.controller,
    required this.hintText,
    this.onCountryChanged,
    this.validator,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 295.w,
      constraints: BoxConstraints(minHeight: 46.h),
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
      child: Row(
        children: [
          Expanded(
            child: TextFormField(
              controller: controller,
              keyboardType: TextInputType.phone,
              style: AppTextStyle.setelMessiriBlack(
                fontSize: 14,
                fontWeight: FontWeight.w500,
              ),
              textAlign: TextAlign.right,
              validator: validator,
              decoration: InputDecoration(
                isDense: true,
                hintText: hintText,
                hintStyle: AppTextStyle.setelMessirisecondaryGery(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                ).copyWith(color: const Color(0xff1A1C1E)),
                border: InputBorder.none,
                contentPadding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 12.h),
                errorStyle: const TextStyle(height: 0),
              ),
            ),
          ),
          Container(
            width: 1,
            height: 24.h,
            color: const Color(0xffEDF1F3),
          ),
          CountryCodePicker(
            onChanged: onCountryChanged,
            initialSelection: 'SA',
            favorite: const ['+966', 'SA'],
            showCountryOnly: false,
            showOnlyCountryWhenClosed: false,
            alignLeft: false,
            padding: EdgeInsets.zero,
            textStyle: AppTextStyle.setelMessiriBlack(
              fontSize: 14,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}
