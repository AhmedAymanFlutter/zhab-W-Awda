import 'package:flutter/material.dart';
import 'package:flutter_application_1/core/router/routes.dart';
import 'package:flutter_application_1/core/theme/app_text_style.dart';
import 'package:flutter_application_1/core/widgets/custom_button.dart';
import 'package:flutter_application_1/core/widgets/custom_phone_field.dart';
import 'package:flutter_application_1/core/widgets/custom_text_field.dart';
import 'package:flutter_application_1/core/widgets/social_login_button.dart';
import 'package:flutter_application_1/featuer/Auth/manager/auth_state.dart';
import 'package:flutter_application_1/featuer/Auth/manager/user_cubit.dart';
import 'package:flutter_application_1/featuer/Auth/view/widgets/auth_background.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../core/validation/auth_validator.dart';

class LogInView extends StatefulWidget {
  const LogInView({super.key});

  @override
  State<LogInView> createState() => _LogInViewState();
}

class _LogInViewState extends State<LogInView> {
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  bool rememberMe = false;
  String countryCode = '+20';

  @override
  Widget build(BuildContext context) {
    return AuthBackground(
      child: BlocConsumer<UserCubit, AuthState>(
        listener: (context, state) {
          if (state is AuthVerifySuccess) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('تم تسجيل الدخول بنجاح')),
            );
            Navigator.pushReplacementNamed(context, Routes.layout);
          } else if (state is AuthError) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.message), backgroundColor: Colors.red),
            );
          }
        },
        builder: (context, state) {
          return Form(
            key: formKey,
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Logo
                  Image.asset(
                    'assets/photo/mainLogo.webp',
                    height: 40.h,
                    fit: BoxFit.contain,
                  ),
                  SizedBox(height: 4.h), // Reduced from 8
                  // Title
                  Text(
                    "تسجيل الدخول",
                    style: AppTextStyle.setelMessiriBlack(
                      fontSize: 28,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  SizedBox(height: 2.h), // Reduced from 4
                  // Subtitle
                  Text(
                    "سجل دخولك باستخدام رقم الهاتف وكلمة المرور.",
                    style: AppTextStyle.setelMessiriSecondlightGrey(
                      fontSize: 11,
                      fontWeight: FontWeight.w500,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 12.h),

                  // Fields
                  CustomPhoneField(
                    hintText: '726-0592',
                    controller: phoneController,
                    validator: AuthValidator.validatePhone,
                    onCountryChanged: (code) {
                      countryCode = code.dialCode ?? '+20';
                    },
                  ),
                  SizedBox(height: 8.h),
                  CustomTextField(
                    hintText: '*******',
                    controller: passwordController,
                    isObscureText: true,
                    validator: AuthValidator.validatePassword,
                  ),
                  SizedBox(height: 4.h),

                  // Remember me & Forgot password
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          SizedBox(
                            width: 20.w,
                            height: 20.h,
                            child: Checkbox(
                              value: rememberMe,
                              onChanged: (value) {
                                setState(() {
                                  rememberMe = value ?? false;
                                });
                              },
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(4.r),
                              ),
                            ),
                          ),
                          Text(
                            ' تذكرني',
                            style: AppTextStyle.setelMessiriBlack(
                              fontSize: 11,
                              fontWeight: FontWeight.w500,
                            ).copyWith(color: const Color(0xff707070)),
                          ),
                        ],
                      ),
                      TextButton(
                        onPressed: () =>
                            Navigator.pushNamed(context, Routes.forgotPassword),
                        style: TextButton.styleFrom(padding: EdgeInsets.zero),
                        child: Text(
                          'هل نسيت كلمة السر ؟',
                          style: AppTextStyle.setelMessiriBlack(
                            fontSize: 11,
                            fontWeight: FontWeight.w700,
                          ).copyWith(color: const Color(0xff00276C)),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 8.h), // Reduced from 12
                  // Button
                  state is AuthLoading
                      ? const Center(child: CircularProgressIndicator())
                      : CustomButton(
                          text: 'تسجيل الدخول',
                          onPressed: () {
                            if (formKey.currentState!.validate()) {
                              context.read<UserCubit>().login(
                                    countryCode: countryCode,
                                    phone: phoneController.text,
                                    password: passwordController.text,
                                  );
                            }
                          },
                        ),
                  SizedBox(height: 12.h), // Reduced from 16
                  // Or sign in with
                  Text(
                    "أو سجل عبر",
                    style: AppTextStyle.setelMessiriSecondlightGrey(
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                    ).copyWith(color: const Color(0xff959595)),
                  ),
                  SizedBox(height: 6.h), // Reduced from 8
                  // OAuth Buttons
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      SocialLoginButton(
                        icon: 'assets/icon/mail-02.svg',
                        onTap: () {},
                      ),
                      SocialLoginButton(
                        icon: 'assets/icon/apple-logo-svgrepo-com 1.svg',
                        onTap: () {},
                      ),
                      SocialLoginButton(
                        icon: 'assets/icon/2021_Facebook_icon 1.svg',
                        onTap: () {},
                      ),
                      SocialLoginButton(
                        icon: 'assets/icon/google.svg',
                        onTap: () {
                          context.read<UserCubit>().loginWithGoogle();
                        },
                      ),
                    ],
                  ),
                  SizedBox(height: 12.h), // Reduced from 16
                  // Footer Link
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'ليس لديك حساب؟ ',
                        style: AppTextStyle.setelMessiriSecondaryBlack(
                          fontSize: 12,
                          fontWeight: FontWeight.normal,
                        ),
                      ),
                      InkWell(
                        onTap: () => Navigator.pushNamed(context, Routes.signUp),
                        child: Text(
                          'سجل الآن',
                          style: AppTextStyle.setelMessiriBlack(
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                          ).copyWith(color: const Color(0xff00276C)),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 4.h), // Reduced from 8
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'المتابعة كضيف',
                        style: AppTextStyle.setelMessiriBlack(
                          fontSize: 12,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      SizedBox(width: 8.w),
                      Icon(Icons.person_outline, size: 18.sp),
                    ],
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
