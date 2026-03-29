import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/core/theme/app_color.dart';
import 'package:flutter_application_1/featuer/Auth/manager/user_cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ProfileCard extends StatelessWidget {
  const ProfileCard({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UserCubit, UserState>(
      builder: (context, state) {
        return Container(
          padding: EdgeInsets.all(16.w),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16.r),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.05),
                blurRadius: 10,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      state.name.isNotEmpty ? state.name : "منصور عبد الرحمن",
                      style: TextStyle(
                        fontSize: 18.sp,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                      textAlign: TextAlign.right,
                    ),
                    SizedBox(height: 4.h),
                    Text(
                      state.email ?? "Mansor932@gmai.com",
                      style: TextStyle(
                        fontSize: 14.sp,
                        color: Colors.grey[600],
                      ),
                      textAlign: TextAlign.right,
                    ),
                  ],
                ),
              ),
              SizedBox(width: 16.w),
              Stack(
                alignment: Alignment.bottomLeft,
                children: [
                  CircleAvatar(
                    radius: 35.r,
                    backgroundColor: Colors.grey[200],
                    backgroundImage: state.imagePath != null
                        ? FileImage(File(state.imagePath!))
                        : null,
                    child: state.imagePath == null
                        ? Icon(Icons.person, size: 40.r, color: Colors.grey)
                        : null,
                  ),
                  Container(
                    padding: EdgeInsets.all(4.w),
                    decoration: BoxDecoration(
                      color: AppColor.primaryBlue,
                      shape: BoxShape.circle,
                      border: Border.all(color: Colors.white, width: 2),
                    ),
                    child: Icon(
                      Icons.edit,
                      size: 14.r,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}
