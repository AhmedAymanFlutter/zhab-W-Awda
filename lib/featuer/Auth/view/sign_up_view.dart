import 'package:flutter/material.dart';
import 'package:flutter_application_1/core/router/routes.dart';
import 'package:flutter_application_1/core/theme/app_color.dart';
import 'package:flutter_application_1/core/theme/app_text_style.dart';
import 'package:flutter_application_1/core/widgets/custom_button.dart';
import 'package:flutter_application_1/core/widgets/custom_text_field.dart';
import 'package:flutter_application_1/featuer/Auth/manager/user_cubit.dart';
import 'package:flutter_application_1/featuer/Auth/view/widgets/auth_background.dart';
import 'package:flutter_application_1/featuer/Auth/view/widgets/profile_widgets.dart';
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
  final TextEditingController passwordController = TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return AuthBackground(
      title: 'حساب جديد 🚀',
      subtitle: 'انضم إلينا واكتشف العالم معنا',
      child: Form(
        key: formKey,
        child: Column(
          children: [
            // Avatar Picker
            Center(
              child: Stack(
                children: [
                  Container(
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(
                          color: AppColor.primaryBlue.withOpacity(0.2),
                          blurRadius: 20,
                          offset: const Offset(0, 10),
                        ),
                      ],
                    ),
                    child: AvatarPicker(
                      radius: 60.r,
                      backgroundColor: AppColor.mainWhite,
                      iconColor: AppColor.lightGrey,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 40.h),

            // Name Field
            CustomTextField(
              hintText: 'الاسم',
              labelText: 'ادخل اسمك',
              controller: nameController,
              keyboardType: TextInputType.name,
              prefixIcon: const Icon(
                Icons.person_outline,
                color: AppColor.primaryBlue,
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'يرجى إدخال الاسم';
                }
                return null;
              },
            ),
            SizedBox(height: 20.h),

            // Email Field
            CustomTextField(
              hintText: 'البريد الإلكتروني',
              labelText: 'ادخل بريدك الإلكتروني',
              controller: emailController,
              keyboardType: TextInputType.emailAddress,
              prefixIcon: const Icon(
                Icons.email_outlined,
                color: AppColor.primaryBlue,
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'يرجى إدخال البريد الإلكتروني';
                }
                return null;
              },
            ),
            SizedBox(height: 20.h),
            // Password Field
            CustomTextField(
              hintText: 'كلمة المرور',
              labelText: 'ادخل كلمة المرور',
              controller: passwordController,
              isObscureText: true,
              keyboardType: TextInputType.visiblePassword,
              prefixIcon: const Icon(
                Icons.lock_outline,
                color: AppColor.primaryBlue,
              ),
              suffixIcon: const Icon(
                Icons.visibility_off_outlined,
                color: AppColor.secondaryGrey,
              ), // Placeholder for visibility toggle logic
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'يرجى إدخال كلمة المرور';
                }
                if (value.length < 6) {
                  return 'كلمة المرور يجب أن تكون 6 أحرف على الأقل';
                }
                return null;
              },
            ),
            SizedBox(height: 40.h),

            // Sign Up Button
            CustomButton(
              text: 'إنشاء حساب',
              onPressed: () {
                if (formKey.currentState!.validate()) {
                  context.read<UserCubit>().saveUser(
                    name: nameController.text,
                    imagePath: AvatarPicker.selectedImagePath,
                    email: emailController
                        .text, // Saving email as well to UserCubit (need to ensure UserCubit supports it or update it)
                  );
                  Navigator.pushReplacementNamed(context, Routes.layout);
                }
              },
            ),
            SizedBox(height: 24.h),

            // Login Link
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'لديك حساب بالفعل؟',
                  style: AppTextStyle.setelMessiriSecondaryBlack(
                    fontSize: 14,
                    fontWeight: FontWeight.normal,
                  ),
                ),
                TextButton(
                  onPressed: () {
                    Navigator.pop(context); // Go back to login
                  },
                  child: Text(
                    'تسجيل الدخول',
                    style: AppTextStyle.setelMessiriDeepPurple(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 24.h),
          ],
        ),
      ),
    );
  }
}
