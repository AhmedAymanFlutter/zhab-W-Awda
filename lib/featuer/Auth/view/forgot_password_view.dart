import 'package:flutter/material.dart';
import 'package:flutter_application_1/core/router/routes.dart';
import 'package:flutter_application_1/core/theme/app_text_style.dart';
import 'package:flutter_application_1/core/widgets/custom_button.dart';
import 'package:flutter_application_1/core/widgets/custom_phone_field.dart';
import 'package:flutter_application_1/featuer/Auth/view/widgets/auth_background.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ForgotPasswordView extends StatelessWidget {
  const ForgotPasswordView({super.key});

  @override
  Widget build(BuildContext context) {
    final TextEditingController phoneController = TextEditingController();

    return AuthBackground(
      child: Column(
        children: [
          // Logo
          Image.asset(
            'assets/photo/mainLogo.webp',
            height: 40.h,
            fit: BoxFit.contain,
          ),
          SizedBox(height: 16.h),
          // Title
          Text(
            "نسيت كلمة المرور؟",
            style: AppTextStyle.setelMessiriBlack(
              fontSize: 26,
              fontWeight: FontWeight.w700,
            ),
          ),
          SizedBox(height: 4.h),
          // Subtitle
          Text(
            "أدخل رقم هاتفك لإعادة تعيين كلمة المرور.",
            style: AppTextStyle.setelMessiriSecondlightGrey(
              fontSize: 11,
              fontWeight: FontWeight.w500,
            ),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 32.h),

          // Label
          Align(
            alignment: Alignment.centerRight,
            child: Text(
              "* رقم الجوال",
              style: AppTextStyle.setelMessiriBlack(
                fontSize: 13,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          SizedBox(height: 8.h),

          // Field
          CustomPhoneField(
            hintText: '726-0592',
            controller: phoneController,
          ),
          SizedBox(height: 12.h),

          // Info row
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Text(
                "سيتم إرسال رمز التحقق إلى رقم هاتفك.",
                style: AppTextStyle.setelMessiriSecondlightGrey(
                  fontSize: 11,
                  fontWeight: FontWeight.w500,
                ).copyWith(color: const Color(0xff707070)),
              ),
              SizedBox(width: 8.w),
              Icon(Icons.info_outline, size: 14.sp, color: const Color(0xff707070)),
            ],
          ),
          SizedBox(height: 32.h),

          // Button
          CustomButton(
            text: 'ارسل رمز التحقق',
            onPressed: () {
              Navigator.pushNamed(context, Routes.otp);
            },
          ),
        ],
      ),
    );
  }
}
