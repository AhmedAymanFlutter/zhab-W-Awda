import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/core/router/routes.dart';
import 'package:flutter_application_1/core/theme/app_text_style.dart';
import 'package:flutter_application_1/core/widgets/custom_button.dart';
import 'package:flutter_application_1/featuer/Auth/manager/user_cubit.dart';
import 'package:flutter_application_1/featuer/Auth/manager/auth_state.dart';
import 'package:flutter_application_1/featuer/Auth/view/widgets/auth_background.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pinput/pinput.dart';
import 'package:flutter_application_1/core/theme/app_color.dart';

class OTPView extends StatefulWidget {
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
  State<OTPView> createState() => _OTPViewState();
}

class _OTPViewState extends State<OTPView> {
  final TextEditingController otpController = TextEditingController();
  Timer? _timer;
  int _secondsRemaining = 30;
  bool _canResend = false;

  @override
  void initState() {
    super.initState();
    _startTimer();
  }

  void _startTimer() {
    _secondsRemaining = 30;
    _canResend = false;
    _timer?.cancel();
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_secondsRemaining > 0) {
        setState(() {
          _secondsRemaining--;
        });
      } else {
        setState(() {
          _canResend = true;
          _timer?.cancel();
        });
      }
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    otpController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final defaultPinTheme = PinTheme(
      width: 48.w,
      height: 52.h,
      textStyle: AppTextStyle.setelMessiriBlack(
        fontSize: 20,
        fontWeight: FontWeight.bold,
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(color: const Color(0xFFE2E8F0)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
    );

    final focusedPinTheme = defaultPinTheme.copyWith(
      decoration: defaultPinTheme.decoration!.copyWith(
        border: Border.all(color: AppColor.primaryBlue2, width: 2),
      ),
    );

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
          } else if (state is AuthResendOtpSuccess) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.message)),
            );
            _startTimer();
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
                    "${widget.countryCode} ${widget.phone}",
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

              // Pinput Input
              Directionality(
                textDirection: TextDirection.ltr,
                child: Pinput(
                  length: 6,
                  controller: otpController,
                  defaultPinTheme: defaultPinTheme,
                  focusedPinTheme: focusedPinTheme,
                  onCompleted: (pin) {
                    context.read<UserCubit>().verifyOtp(
                          countryCode: widget.countryCode,
                          phone: widget.phone,
                          code: pin,
                          purpose: widget.purpose,
                        );
                  },
                ),
              ),
              SizedBox(height: 16.h),

              // Resend info
              Text(
                _canResend
                    ? "يمكنك الآن إعادة إرسال الرمز"
                    : "يمكنك إعادة إرسال الكود خلال ${_secondsRemaining}ث",
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
                        if (otpController.text.length == 6) {
                          context.read<UserCubit>().verifyOtp(
                                countryCode: widget.countryCode,
                                phone: widget.phone,
                                code: otpController.text,
                                purpose: widget.purpose,
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
                    onTap: _canResend
                        ? () {
                            context.read<UserCubit>().resendOtp(
                                  countryCode: widget.countryCode,
                                  phone: widget.phone,
                                  purpose: widget.purpose,
                                );
                          }
                        : null,
                    child: Text(
                      'إعادة الإرسال',
                      style: AppTextStyle.setelMessiriBlack(
                        fontSize: 13,
                        fontWeight: FontWeight.bold,
                      ).copyWith(
                        color: _canResend ? const Color(0xff00276C) : Colors.grey,
                      ),
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
