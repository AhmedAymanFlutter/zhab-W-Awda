import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/theme/app_color.dart';

class TourStatsRow extends StatelessWidget {
  final String? days;
  final String? people;
  final String? type;

  const TourStatsRow({super.key, this.days, this.people, this.type});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 16.h, horizontal: 16.w),
      decoration: BoxDecoration(
        color: Colors.grey[50],
        borderRadius: BorderRadius.circular(20.r),
        border: Border.all(color: Colors.grey[200]!),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _buildModernStatItem(
            Icons.calendar_month_rounded,
            "المدة",
            "${days ?? 1} أيام",
          ),
          Container(width: 1, height: 40.h, color: Colors.grey[300]),
          _buildModernStatItem(
            Icons.groups_rounded,
            "المجموعة",
            "${people ?? 1} أفراد",
          ),
          Container(width: 1, height: 40.h, color: Colors.grey[300]),
          _buildModernStatItem(
            Icons.category_rounded,
            "النوع",
            type ?? "ترفيهي",
          ),
        ],
      ),
    );
  }

  Widget _buildModernStatItem(IconData icon, String label, String value) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, color: AppColor.primaryBlue, size: 24.sp),
        SizedBox(height: 8.h),
        Text(
          label,
          style: TextStyle(
            fontSize: 12.sp,
            color: Colors.grey[500],
            fontWeight: FontWeight.w500,
          ),
        ),
        SizedBox(height: 4.h),
        Text(
          value,
          style: TextStyle(
            fontSize: 14.sp,
            color: Colors.black87,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }
}
