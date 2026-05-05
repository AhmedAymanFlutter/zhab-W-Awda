import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SocialLoginButton extends StatelessWidget {
  final String icon;
  final VoidCallback onTap;

  const SocialLoginButton({
    super.key,
    required this.icon,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(10.r),
      child: Container(
        width: 62.5.w,
        height: 48.h,
        padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.h),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10.r),
          border: Border.all(color: const Color(0xffEFF0F6), width: 1),
          boxShadow: [
            BoxShadow(
              color: const Color(0x99F4F5FA),
              blurRadius: 6,
              offset: const Offset(0, -3), // Inset shadow logic in Flutter is limited, using offset for effect
            ),
          ],
        ),
        child: SvgPicture.asset(
          icon,
          fit: BoxFit.contain,
        ),
      ),
    );
  }
}
