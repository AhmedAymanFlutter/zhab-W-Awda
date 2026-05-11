import 'package:flutter/material.dart';
import 'package:flutter_application_1/core/theme/app_color.dart';
import 'package:flutter_application_1/core/theme/app_text_style.dart';
import 'package:flutter_application_1/core/widgets/custom_button.dart';
import 'package:flutter_application_1/core/widgets/custom_text_field.dart';
import 'package:flutter_application_1/featuer/Auth/manager/auth_state.dart';
import 'package:flutter_application_1/featuer/Auth/manager/user_cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../core/validation/auth_validator.dart';
import '../../../core/validation/input_validator.dart';
import '../../../core/validation/rules/required_rule.dart';

class ChangePasswordView extends StatefulWidget {
  const ChangePasswordView({super.key});

  @override
  State<ChangePasswordView> createState() => _ChangePasswordViewState();
}

class _ChangePasswordViewState extends State<ChangePasswordView> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _currentPasswordController = TextEditingController();
  final TextEditingController _newPasswordController = TextEditingController();
  final TextEditingController _confirmPasswordController = TextEditingController();



  @override
  void dispose() {
    _currentPasswordController.dispose();
    _newPasswordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F7FA),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0.5,
        centerTitle: true,
        title: Text(
          'تغيير كلمة المرور',
          style: AppTextStyle.setelMessiriTextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Colors.black87,
          ),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new, color: Colors.black87, size: 18),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: BlocConsumer<UserCubit, AuthState>(
        listener: (context, state) {
          if (state is AuthChangePasswordSuccess) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.message.isNotEmpty ? state.message : 'تم تغيير كلمة المرور بنجاح ✓'),
                backgroundColor: Colors.green,
                behavior: SnackBarBehavior.floating,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              ),
            );
            Navigator.pop(context);
          } else if (state is AuthError) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.message),
                backgroundColor: Colors.red,
                behavior: SnackBarBehavior.floating,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              ),
            );
          }
        },
        builder: (context, state) {
          return SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 28.h),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  // Icon header
                  Center(
                    child: Container(
                      width: 80.w,
                      height: 80.w,
                      decoration: BoxDecoration(
                        color: AppColor.primaryBlue.withOpacity(0.1),
                        shape: BoxShape.circle,
                      ),
                      child: Icon(
                        Icons.lock_reset_rounded,
                        size: 40.sp,
                        color: AppColor.primaryBlue,
                      ),
                    ),
                  ),
                  SizedBox(height: 12.h),
                  Center(
                    child: Text(
                      'أدخل كلمة المرور الحالية ثم كلمة المرور الجديدة',
                      textAlign: TextAlign.center,
                      style: AppTextStyle.setelMessiriTextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.normal,
                        color: Colors.grey[600]!,
                      ),
                    ),
                  ),
                  SizedBox(height: 36.h),

                  // Current Password
                  _buildLabel('كلمة المرور الحالية *'),
                  SizedBox(height: 8.h),
                  CustomTextField(
                    hintText: '••••••••',
                    controller: _currentPasswordController,
                    isObscureText: true,
                    validator: (value) => InputValidator([RequiredRule(message: 'يرجى إدخال كلمة المرور الحالية')]).validate(value),
                  ),
                  SizedBox(height: 20.h),

                  // New Password
                  _buildLabel('كلمة المرور الجديدة *'),
                  SizedBox(height: 8.h),
                  CustomTextField(
                    hintText: '••••••••',
                    controller: _newPasswordController,
                    isObscureText: true,
                    validator: AuthValidator.validatePassword,
                  ),
                  SizedBox(height: 20.h),

                  // Confirm Password
                  _buildLabel('تأكيد كلمة المرور الجديدة *'),
                  SizedBox(height: 8.h),
                  CustomTextField(
                    hintText: '••••••••',
                    controller: _confirmPasswordController,
                    isObscureText: true,
                    validator: (value) => AuthValidator.validateConfirmPassword(value, _newPasswordController.text),
                  ),
                  SizedBox(height: 40.h),

                  // Submit Button
                  state is AuthLoading
                      ? Center(
                          child: CircularProgressIndicator(color: AppColor.primaryBlue),
                        )
                      : CustomButton(
                          text: 'تغيير كلمة المرور',
                          onPressed: _submit,
                        ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildLabel(String text) {
    return Align(
      alignment: Alignment.centerRight,
      child: Text(
        text,
        style: AppTextStyle.setelMessiriTextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w600,
          color: Colors.black87,
        ),
      ),
    );
  }

  void _submit() {
    if (_formKey.currentState!.validate()) {
      context.read<UserCubit>().changePassword(
            password: _currentPasswordController.text.trim(),
            newPassword: _newPasswordController.text.trim(),
            passwordConfirm: _confirmPasswordController.text.trim(),
          );
    }
  }
}
