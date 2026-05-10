import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

class HomeHeaderNotificationIcon extends StatelessWidget {
  const HomeHeaderNotificationIcon({super.key});

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(96.r),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 20, sigmaY: 20),
        child: GestureDetector(
          onTap: () => Navigator.pushNamed(context, '/NotificationsView'),
          child: Container(
            width: 50.w,
            height: 50.h,
            decoration: const BoxDecoration(
              color: Color(0x1AFFFFFF),
              shape: BoxShape.circle,
            ),
            child: Stack(
              alignment: Alignment.center,
              children: [
                SvgPicture.asset(
                  'assets/icon/Alert.svg',
                  width: 24.w,
                  height: 24.h,
                ),
                Positioned(
                  top: 12.h,
                  left: 14.w,
                  child: Container(
                    width: 8.w,
                    height: 8.h,
                    decoration: const BoxDecoration(
                      color: Color(0xFFD63131),
                      shape: BoxShape.circle,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
