import 'package:flutter/material.dart';
import 'package:flutter_application_1/core/router/routes.dart';
import 'package:flutter_application_1/core/theme/app_text_style.dart';
import 'package:flutter_application_1/core/widgets/custom_button.dart';
import 'package:flutter_application_1/core/widgets/otp_input.dart';
import 'package:flutter_application_1/featuer/Auth/manager/user_cubit.dart';
import 'package:flutter_application_1/featuer/Auth/manager/auth_state.dart';
import 'package:flutter_application_1/featuer/Auth/view/widgets/auth_background.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class OTPView extends StatelessWidget {
  final String phone;
  final String countryCode;
  final String purpose;

  const OTPView({
    super.key,
    required this.phone,
    required this.countryCode,
    this.purpose = 'signup',
  });

  @override
  Widget build(BuildContext context) {
    final controllers = List.generate(6, (_) => TextEditingController());

    return AuthBackground(
      child: BlocConsumer<UserCubit, AuthState>(
        listener: (context, state) {
          if (state is AuthVerifySuccess) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('تم التحقق بنجاح')),
            );
            Navigator.pushNamedAndRemoveUntil(context, Routes.layout, (route) => false);
          } else if (state is AuthVerifyOtpForResetSuccess) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('تم التحقق من الرمز بنجاح')),
            );
            Navigator.pushNamed(
              context,
              Routes.resetPassword,
              arguments: state.resetToken,
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
              SizedBox(height: 12.h),
              // Title
              Text(
                "تحقق من حسابك",
                style: AppTextStyle.setelMessiriBlack(
                  fontSize: 24,
                  fontWeight: FontWeight.w700,
                ),
              ),
              SizedBox(height: 4.h),
              // Subtitle
              Text(
                "يرجى إدخال رمز التحقق لإكمال العملية.",
                style: AppTextStyle.setelMessiriSecondlightGrey(
                  fontSize: 11,
                  fontWeight: FontWeight.w500,
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 8.h),

              // Phone info
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  InkWell(
                    onTap: () => Navigator.pop(context),
                    child: Text(
                      "تغيير",
                      style: AppTextStyle.setelMessiriBlack(
                        fontSize: 11,
                        fontWeight: FontWeight.bold,
                      ).copyWith(color: const Color(0xff00276C), decoration: TextDecoration.underline),
                    ),
                  ),
                  SizedBox(width: 8.w),
                  Text(
                    "$countryCode $phone",
                    style: AppTextStyle.setelMessiriBlack(
                      fontSize: 13,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 20.h),

              // OTP Section Label
              Align(
                alignment: Alignment.centerRight,
                child: Text(
                  "تأكيد رقم الهاتف",
                  style: AppTextStyle.setelMessiriBlack(
                    fontSize: 13,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
              Align(
                alignment: Alignment.centerRight,
                child: Text(
                  "أدخل رمز التحقق المكون من 6 أرقام المرسل إلى رقم هاتفك.",
                  style: AppTextStyle.setelMessiriSecondlightGrey(
                    fontSize: 11,
                    fontWeight: FontWeight.w500,
                  ),
                  textAlign: TextAlign.right,
                ),
              ),
              SizedBox(height: 16.h),

              // OTP Input
              OTPInput(controllers: controllers),
              SizedBox(height: 16.h),

              // Resend info
              Text(
                "يمكنك إعادة إرسال الكود خلال 12ث",
                style: AppTextStyle.setelMessiriSecondlightGrey(
                  fontSize: 11,
                  fontWeight: FontWeight.w500,
                ),
              ),
              SizedBox(height: 24.h),

              // Button
              state is AuthLoading
                  ? const Center(child: CircularProgressIndicator())
                  : CustomButton(
                      text: 'التحقق من الرمز',
                      onPressed: () {
                        String otp = controllers.map((e) => e.text).join();
                        if (otp.length == 6) {
                          context.read<UserCubit>().verifyOtp(
                                countryCode: countryCode,
                                phone: phone,
                                code: otp,
                                purpose: purpose,
                              );
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text('يرجى إدخال رمز التحقق كاملاً'), backgroundColor: Colors.orange),
                          );
                        }
                      },
                    ),
              SizedBox(height: 16.h),

              // Resend Link
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  InkWell(
                    onTap: () {},
                    child: Text(
                      'إعادة الإرسال',
                      style: AppTextStyle.setelMessiriBlack(
                        fontSize: 13,
                        fontWeight: FontWeight.bold,
                      ).copyWith(color: const Color(0xff00276C)),
                    ),
                  ),
                  Text(
                    ' لم يصلك الرمز؟ ',
                    style: AppTextStyle.setelMessiriSecondaryBlack(
                      fontSize: 13,
                      fontWeight: FontWeight.normal,
                    ),
                  ),
                ],
              ),
            ],
          );
        },
      ),
    );
  }
}
