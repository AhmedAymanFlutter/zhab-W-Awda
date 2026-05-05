import 'package:flutter/material.dart';
import 'package:flutter_application_1/core/router/routes.dart';
import 'package:flutter_application_1/core/theme/app_text_style.dart';
import 'package:flutter_application_1/core/widgets/custom_button.dart';
import 'package:flutter_application_1/core/widgets/custom_text_field.dart';
import 'package:flutter_application_1/featuer/Auth/view/widgets/auth_background.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ResetPasswordView extends StatelessWidget {
  const ResetPasswordView({super.key});

  @override
  Widget build(BuildContext context) {
    final TextEditingController passwordController = TextEditingController();
    final TextEditingController confirmPasswordController = TextEditingController();

    return AuthBackground(
      child: Column(
        children: [
          // Logo
          Image.asset(
            'assets/photo/mainLogo.webp',
            height: 50.h,
            fit: BoxFit.contain,
          ),
          SizedBox(height: 24.h),
          // Title
          Text(
            "إعادة ضبط كلمة المرور",
            style: AppTextStyle.setelMessiriBlack(
              fontSize: 28,
              fontWeight: FontWeight.w700,
            ),
          ),
          SizedBox(height: 8.h),
          // Subtitle
          Text(
            "أدخل كلمة المرور الجديدة لتحديث حسابك.",
            style: AppTextStyle.setelMessiriSecondlightGrey(
              fontSize: 12,
              fontWeight: FontWeight.w500,
            ),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 40.h),

          // New Password Label
          Align(
            alignment: Alignment.centerRight,
            child: Text(
              "* كلمة المرور الجديدة",
              style: AppTextStyle.setelMessiriBlack(
                fontSize: 14,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          SizedBox(height: 8.h),
          CustomTextField(
            hintText: '*******',
            controller: passwordController,
            isObscureText: true,
            leftIcon: Icon(
              Icons.visibility_off_outlined,
              color: const Color(0xff959595).withOpacity(0.5),
              size: 20.sp,
            ),
          ),
          SizedBox(height: 16.h),

          // Confirm Password Label
          Align(
            alignment: Alignment.centerRight,
            child: Text(
              "* تأكيد كلمة المرور",
              style: AppTextStyle.setelMessiriBlack(
                fontSize: 14,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          SizedBox(height: 8.h),
          CustomTextField(
            hintText: '*******',
            controller: confirmPasswordController,
            isObscureText: true,
            leftIcon: Icon(
              Icons.visibility_off_outlined,
              color: const Color(0xff959595).withOpacity(0.5),
              size: 20.sp,
            ),
          ),
          SizedBox(height: 40.h),

          // Button
          CustomButton(
            text: 'تأكيد',
            onPressed: () {
              Navigator.pushNamedAndRemoveUntil(context, Routes.loginView, (route) => false);
            },
          ),
        ],
      ),
    );
  }
}
