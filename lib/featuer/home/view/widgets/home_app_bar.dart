import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/theme/app_color.dart';
import '../../../Auth/manager/user_cubit.dart';

class HomeAppBar extends StatelessWidget {
  const HomeAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UserCubit, UserState>(
      builder: (context, state) {
        return Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              // Name
              Text(
                state.name,
                style: TextStyle(
                  fontSize: 13.sp,
                  fontWeight: FontWeight.w600,
                  fontFamily: 'cairo',
                ),
              ),
              SizedBox(width: 8.w),
              // Profile Image
              Container(
                width: 40.w,
                height: 40.w,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(color: AppColor.primaryBlue, width: 1.5),
                  image: state.imagePath != null
                      ? DecorationImage(
                          image: FileImage(File(state.imagePath!)),
                          fit: BoxFit.cover,
                        )
                      : const DecorationImage(
                          image: AssetImage("assets/photo/mainLogo.webp"),
                          fit: BoxFit.cover,
                        ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
