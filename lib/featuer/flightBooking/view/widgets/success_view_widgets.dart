import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/theme/app_color.dart';
import '../../../../core/theme/app_text_style.dart';

class BookingSuccessHeader extends StatelessWidget {
  final String title;
  final String subtitle;

  const BookingSuccessHeader({
    super.key,
    required this.title,
    required this.subtitle,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(height: 40.h),
        // Success Icon Section with a more premium look
        Container(
          padding: EdgeInsets.all(20.w),
          decoration: BoxDecoration(
            color: Colors.green.withOpacity(0.1),
            shape: BoxShape.circle,
          ),
          child: Container(
            padding: EdgeInsets.all(15.w),
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                colors: [Colors.green, Color(0xFF4CAF50)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  color: Colors.green.withOpacity(0.3),
                  blurRadius: 10,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: Icon(Icons.check, color: Colors.white, size: 40.sp),
          ),
        ),
        SizedBox(height: 24.h),
        Text(
          title,
          style: AppTextStyle.setelMessiriBlack(
            fontSize: 22,
            fontWeight: FontWeight.bold,
          ),
          textAlign: TextAlign.center,
        ),
        SizedBox(height: 8.h),
        Text(
          subtitle,
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 14.sp,
            color: AppColor.secondeLightGrey,
            height: 1.5,
          ),
        ),
      ],
    );
  }
}

class SuccessInfoCard extends StatelessWidget {
  final String title;
  final IconData icon;
  final List<Widget> children;

  const SuccessInfoCard({
    super.key,
    required this.title,
    required this.icon,
    required this.children,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: EdgeInsets.only(bottom: 16.h),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.03),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.all(16.w),
            child: Row(
              children: [
                Icon(icon, color: AppColor.primaryBlue2, size: 20.sp),
                SizedBox(width: 8.w),
                Text(
                  title,
                  style: AppTextStyle.setelMessiriBlack(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
          const Divider(height: 1, color: Color(0xFFF1F1F1)),
          Padding(
            padding: EdgeInsets.all(16.w),
            child: Column(children: children),
          ),
        ],
      ),
    );
  }
}

class SuccessInfoRow extends StatelessWidget {
  final String label;
  final String value;

  const SuccessInfoRow({
    super.key,
    required this.label,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: 12.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: TextStyle(
              fontSize: 14.sp,
              color: AppColor.secondeLightGrey,
              fontWeight: FontWeight.w500,
            ),
          ),
          Text(
            value,
            style: TextStyle(
              fontSize: 14.sp,
              color: AppColor.mainBlack,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}
