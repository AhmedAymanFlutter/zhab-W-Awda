import 'package:flutter/material.dart';
import 'package:flutter_application_1/featuer/Auth/manager/user_cubit.dart';
import 'package:flutter_application_1/featuer/Auth/view/widgets/app_text_form_field.dart';
import 'package:flutter_application_1/featuer/Auth/view/widgets/profile_widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../core/router/routes.dart';
import '../../../core/theme/app_color.dart';
import 'widgets/app_button.dart';

class LogInView extends StatefulWidget {
  const LogInView({super.key});

  @override
  State<LogInView> createState() => _LogInViewState();
}

class _LogInViewState extends State<LogInView> {
  final TextEditingController nameController = TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  bool isObscureText = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.mainWhite,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 24.h),
          child: SingleChildScrollView(
            child: Form(
              key: formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 30.h),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Center(
                        child: AvatarPicker(
                          radius: 50,
                          backgroundColor: AppColor.primaryBlue,
                          iconColor: AppColor.mainWhite,
                        ),
                      ),
                    ],
                  ),

                  SizedBox(height: 16.h),
                  AppTextFormField(
                    hintText: 'الاسم',
                    controller: nameController,
                    keyboardType: TextInputType.name,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'يرجى إدخال الاسم';
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 36.h),

                  // --- Login Button ---
                  AppButton(
                    buttonText: 'تسجيل الدخول',
                    onPressed: () {
                      if (formKey.currentState!.validate()) {
                        context.read<UserCubit>().saveUser(
                          name: nameController.text,
                          imagePath:
                              AvatarPicker.selectedImagePath, // هنجيبها تحت
                        );
                        Navigator.pushReplacementNamed(context, Routes.layout);
                      }
                    },
                  ),

                  SizedBox(height: 24.h),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
