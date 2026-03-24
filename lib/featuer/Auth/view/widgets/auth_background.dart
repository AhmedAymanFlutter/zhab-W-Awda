import 'package:flutter/material.dart';
import 'package:flutter_application_1/core/theme/app_color.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AuthBackground extends StatelessWidget {
  final Widget child;
  final String title;
  final String subtitle;

  const AuthBackground({
    super.key,
    required this.child,
    required this.title,
    required this.subtitle,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.mainWhite, // Light background
      body: Stack(
        children: [
          // Decorative Circle 1 (Top Left)
          Positioned(
            top: -100.h,
            left: -100.w,
            child: Container(
              width: 300.w,
              height: 300.w,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: AppColor.primaryBlue.withOpacity(0.05),
              ),
            ),
          ),
          // Decorative Circle 2 (Top Right)
          Positioned(
            top: -50.h,
            right: -80.w,
            child: Container(
              width: 200.w,
              height: 200.w,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: AppColor.lightBlue.withOpacity(0.05),
              ),
            ),
          ),

          SafeArea(
            child: Column(
              children: [
                SizedBox(height: 40.h),
                // Header Section
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 24.w),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        title,
                        style: Theme.of(context).textTheme.headlineMedium
                            ?.copyWith(
                              fontFamily: 'elMessiri',
                              fontWeight: FontWeight.bold,
                              color: AppColor.primaryBlue,
                            ),
                      ),
                      SizedBox(height: 8.h),
                      Text(
                        subtitle,
                        style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                          fontFamily: 'elMessiri',
                          color: AppColor.secondaryGrey,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 40.h),
                // Main Content
                Expanded(
                  child: Container(
                    width: double.infinity,
                    padding: EdgeInsets.symmetric(horizontal: 24.w),
                    child: SingleChildScrollView(child: child),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
