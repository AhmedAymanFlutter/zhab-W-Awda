import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/theme/app_color.dart';
import 'home_header_profile_pill.dart';
import 'home_header_notification_icon.dart';
import 'home_header_center_text.dart';
import 'home_header_search_bar.dart';

class HomeHeader extends StatelessWidget {
  const HomeHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.only(
        bottomLeft: Radius.circular(24.r),
        bottomRight: Radius.circular(24.r),
      ),
      child: ClipPath(
        child: Container(
          height: 320.h,
          width: double.infinity,
          decoration: BoxDecoration(
            color: AppColor.primaryBlue4,
            image: const DecorationImage(
              image: AssetImage('assets/photo/home_header.png'),
              fit: BoxFit.cover,
            ),
          ),
          child: Stack(
            children: [
              // Dark Gradient Overlay for readability
              Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      AppColor.primaryBlue4.withOpacity(0.5),
                      Colors.transparent,
                    ],
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                  ),
                ),
              ),

              // Top Bar: Profile Pill
              Positioned(
                top: MediaQuery.of(context).padding.top + 10.h,
                right: 20.w,
                child: const HomeHeaderProfilePill(),
              ),

              // Top Bar: Notification Icon
              Positioned(
                top: MediaQuery.of(context).padding.top + 10.h,
                left: 20.w,
                child: const HomeHeaderNotificationIcon(),
              ),

              // Center Content
              Positioned(
                top: 140.h,
                left: 30.w,
                right: 30.w,
                child: const HomeHeaderCenterText(),
              ),

              // Bottom Search Bar
              Positioned(
                bottom: 24.h,
                left: 20.w,
                right: 20.w,
                child: const HomeHeaderSearchBar(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
