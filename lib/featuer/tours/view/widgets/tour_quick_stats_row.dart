import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class TourQuickStatsRow extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      reverse: true, // For RTL flow
      child: Row(
        textDirection: TextDirection.rtl,
        children: [
          _buildStatChip("6 ساعات", Icons.access_time),
          SizedBox(width: 8.w),
          _buildStatChip("إلى 4 أشخاص", Icons.people_outline),
          SizedBox(width: 8.w),
          _buildStatChip("إلغاء مجاني", Icons.highlight_off),
        ],
      ),
    );
  }

  Widget _buildStatChip(String label, IconData icon) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10.r),
        border: Border.all(color: const Color(0xFFEAEAEA)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        textDirection: TextDirection.rtl,
        children: [
          Icon(icon, size: 18.sp, color: Colors.grey[700]),
          SizedBox(width: 8.w),
          Text(
            label,
            style: TextStyle(
              fontSize: 13.sp,
              color: Colors.black87,
              fontWeight: FontWeight.w500,
              fontFamily: 'ElMessiri',
            ),
          ),
        ],
      ),
    );
  }
}
