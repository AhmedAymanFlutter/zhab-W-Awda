import 'package:flutter/material.dart';
import 'package:flutter_application_1/core/router/routes.dart';
import 'package:flutter_application_1/core/theme/app_text_style.dart';
import 'package:flutter_application_1/core/widgets/custom_button.dart';
import 'package:flutter_application_1/core/widgets/custom_text_field.dart';
import 'package:flutter_application_1/featuer/Auth/manager/user_cubit.dart';
import 'package:flutter_application_1/featuer/Auth/manager/auth_state.dart';
import 'package:flutter_application_1/featuer/Auth/view/widgets/auth_background.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../core/validation/auth_validator.dart';

class ResetPasswordView extends StatefulWidget {
  final String resetToken;
  const ResetPasswordView({super.key, required this.resetToken});

  @override
  State<ResetPasswordView> createState() => _ResetPasswordViewState();
}

class _ResetPasswordViewState extends State<ResetPasswordView> {
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController = TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return AuthBackground(
      child: BlocConsumer<UserCubit, AuthState>(
        listener: (context, state) {
          if (state is AuthResetPasswordSuccess) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.message)),
            );
            Navigator.pushNamedAndRemoveUntil(context, Routes.loginView, (route) => false);
          } else if (state is AuthError) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.message), backgroundColor: Colors.red),
            );
          }
        },
        builder: (context, state) {
          return Form(
            key: formKey,
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
                validator: AuthValidator.validatePassword,
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
                validator: (value) => AuthValidator.validateConfirmPassword(
                  value,
                  passwordController.text,
                ),
              ),
              SizedBox(height: 40.h),

              // Button
              state is AuthLoading
                  ? const Center(child: CircularProgressIndicator())
                  : CustomButton(
                      text: 'تأكيد',
                      onPressed: () {
                        if (formKey.currentState!.validate()) {
                          context.read<UserCubit>().resetPassword(
                                resetToken: widget.resetToken,
                                password: passwordController.text,
                                passwordConfirm: confirmPasswordController.text,
                              );
                        }
                      },
                    ),
              ],
            ),
          );
        },
      ),
    );
  }
}
