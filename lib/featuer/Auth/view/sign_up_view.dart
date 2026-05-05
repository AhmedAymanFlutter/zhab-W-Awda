import 'package:flutter/material.dart';
import 'package:flutter_application_1/core/router/routes.dart';
import 'package:flutter_application_1/core/theme/app_text_style.dart';
import 'package:flutter_application_1/core/widgets/custom_button.dart';
import 'package:flutter_application_1/core/widgets/custom_phone_field.dart';
import 'package:flutter_application_1/core/widgets/custom_text_field.dart';
import 'package:flutter_application_1/featuer/Auth/manager/user_cubit.dart';
import 'package:flutter_application_1/featuer/Auth/view/widgets/auth_background.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SignUpView extends StatefulWidget {
  const SignUpView({super.key});

  @override
  State<SignUpView> createState() => _SignUpViewState();
}

class _SignUpViewState extends State<SignUpView> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return AuthBackground(
      child: Form(
        key: formKey,
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Logo
              Image.asset(
                'assets/photo/mainLogo.webp',
                height: 40.h,
                fit: BoxFit.contain,
              ),
              SizedBox(height: 24.h),
              // Title
              Text(
                "إنشاء حساب",
                style: AppTextStyle.setelMessiriBlack(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 8.h),
              // Subtitle
              Text(
                "أنشئ حسابك وابدأ رحلتك معنا.",
                style: AppTextStyle.setelMessiriSecondlightGrey(
                  fontSize: 14,
                  fontWeight: FontWeight.normal,
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 32.h),

              // Fields with 24px gaps
              CustomTextField(
                hintText: 'عبدالله سالم',
                controller: nameController,
                keyboardType: TextInputType.name,
              ),
              SizedBox(height: 16.h),
              CustomTextField(
                hintText: 'abdullah12@gmail.com',
                controller: emailController,
                keyboardType: TextInputType.emailAddress,
              ),
              SizedBox(height: 16.h),
              CustomPhoneField(
                hintText: '726-0592',
                controller: phoneController,
              ),
              SizedBox(height: 16.h),
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
              SizedBox(height: 32.h),

              // Button
              CustomButton(
                text: 'تسجيل',
                onPressed: () {
                  if (formKey.currentState!.validate()) {
                    context.read<UserCubit>().saveUser(
                          name: nameController.text,
                          email: emailController.text,
                        );
                    Navigator.pushReplacementNamed(context, Routes.layout);
                  }
                },
              ),
              SizedBox(height: 24.h),

              // Footer Links
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'هل لديك حساب بالفعل؟ ',
                    style: AppTextStyle.setelMessiriSecondaryBlack(
                      fontSize: 14,
                      fontWeight: FontWeight.normal,
                    ),
                  ),
                  InkWell(
                    onTap: () => Navigator.pop(context),
                    child: Text(
                      'تسجيل الدخول',
                      style: AppTextStyle.setelMessiriBlack(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                      ).copyWith(color: const Color(0xff00276C)),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 16.h),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'المتابعة كضيف',
                    style: AppTextStyle.setelMessiriBlack(
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  SizedBox(width: 8.w),
                  Icon(Icons.person_outline, size: 20.sp),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
