import 'package:flutter/material.dart';
import 'package:flutter_application_1/core/router/routes.dart';
import 'package:flutter_application_1/core/theme/app_text_style.dart';
import 'package:flutter_application_1/core/widgets/custom_button.dart';
import 'package:flutter_application_1/core/widgets/custom_phone_field.dart';
import 'package:flutter_application_1/featuer/Auth/manager/user_cubit.dart';
import 'package:flutter_application_1/featuer/Auth/manager/auth_state.dart';
import 'package:flutter_application_1/featuer/Auth/view/widgets/auth_background.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ForgotPasswordView extends StatefulWidget {
  const ForgotPasswordView({super.key});

  @override
  State<ForgotPasswordView> createState() => _ForgotPasswordViewState();
}

class _ForgotPasswordViewState extends State<ForgotPasswordView> {
  final TextEditingController phoneController = TextEditingController();
  String countryCode = '+20';

  @override
  Widget build(BuildContext context) {
    return AuthBackground(
      child: BlocConsumer<UserCubit, AuthState>(
        listener: (context, state) {
          if (state is AuthForgotPasswordSuccess) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.message)),
            );
            Navigator.pushNamed(
              context,
              Routes.otp,
              arguments: {
                'phone': phoneController.text,
                'countryCode': countryCode,
                'purpose': 'reset',
              },
            );
          } else if (state is AuthError) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.message), backgroundColor: Colors.red),
            );
          }
        },
        builder: (context, state) {
          return Column(
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
                onCountryChanged: (code) {
                  countryCode = code.dialCode ?? '+20';
                },
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
              state is AuthLoading
                  ? const Center(child: CircularProgressIndicator())
                  : CustomButton(
                      text: 'ارسل رمز التحقق',
                      onPressed: () {
                        if (phoneController.text.isNotEmpty) {
                          context.read<UserCubit>().forgotPassword(
                                countryCode: countryCode,
                                phone: phoneController.text,
                              );
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text('يرجى إدخال رقم الهاتف'), backgroundColor: Colors.orange),
                          );
                        }
                      },
                    ),
            ],
          );
        },
      ),
    );
  }
}
