import 'package:flutter/material.dart';
import 'package:flutter_application_1/core/theme/app_text_style.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class BookingInclusionsList extends StatelessWidget {
  final List<String> includes;
  final List<String> excludes;

  const BookingInclusionsList({
    super.key,
    required this.includes,
    required this.excludes,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16.r),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          // Inclusions
          _buildSectionHeader(
            "ما تشمله الباقة",
            Icons.check_circle_outline,
            const Color(0xFF52C41A),
            const Color(0xFFF6FFED),
          ),
          SizedBox(height: 12.h),
          ...includes.map(
            (item) => _buildListItem(
              item,
              const Color(0xFF52C41A),
              const Color(0xFFF6FFED),
              Icons.check,
            ),
          ),

          SizedBox(height: 24.h),

          // Exclusions
          _buildSectionHeader(
            "ما لا تشمله الباقة",
            Icons.cancel_outlined,
            Colors.red,
            const Color(0xFFFFF1F0),
          ),
          SizedBox(height: 12.h),
          ...excludes.map(
            (item) => _buildListItem(
              item,
              Colors.red,
              const Color(0xFFFFF1F0),
              Icons.close,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSectionHeader(
    String title,
    IconData icon,
    Color color,
    Color bgColor,
  ) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Text(
          title,
          style: AppTextStyle.setelMessiriBlack(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(width: 8.w),
        Container(
          padding: EdgeInsets.all(6.w),
          decoration: BoxDecoration(
            color: bgColor,
            borderRadius: BorderRadius.circular(8.r),
          ),
          child: Icon(icon, color: color, size: 20.sp),
        ),
      ],
    );
  }

  Widget _buildListItem(
    String text,
    Color color,
    Color bgColor,
    IconData icon,
  ) {
    return Padding(
      padding: EdgeInsets.only(bottom: 8.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Text(
            text,
            style: AppTextStyle.setelMessiriTextStyle(
              fontSize: 14,
              color: const Color(0xFF475467),
              fontWeight: FontWeight.normal,
            ),
          ),
          SizedBox(width: 8.w),
          Container(
            padding: EdgeInsets.all(4.w),
            decoration: BoxDecoration(color: bgColor, shape: BoxShape.circle),
            child: Icon(icon, color: color, size: 12.sp),
          ),
        ],
      ),
    );
  }
}
