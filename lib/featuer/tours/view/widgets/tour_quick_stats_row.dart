import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class TourQuickStatsRow extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Wrap(
      alignment: WrapAlignment.end,
      spacing: 8.w,
      runSpacing: 8.h,
      children: [
        _buildStatChip("الغاء مجاني", Icons.cancel_outlined),
        _buildStatChip("الى 4 اشخاص", Icons.groups_outlined),
        _buildStatChip("6 ساعات", Icons.access_time),
      ],
    );
  }


  Widget _buildStatChip(String label, IconData icon) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(color: Colors.grey[200]!),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            label,
            style: TextStyle(
              fontSize: 12.sp,
              color: Colors.grey[800],
              fontWeight: FontWeight.w500,
            ),
          ),
          SizedBox(width: 6.w),
          Icon(icon, size: 16.sp, color: Colors.grey[600]),
        ],
      ),
    );
  }
}
