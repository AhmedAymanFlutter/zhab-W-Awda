import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class TagsRow extends StatelessWidget {
  final bool isCheapest;
  final bool isFastest;
  final bool isBest;
  final String cabinClass;

  const TagsRow({
    super.key,
    required this.isCheapest,
    required this.isFastest,
    required this.isBest,
    required this.cabinClass,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            if (isCheapest) _buildTag("الأرخص", Colors.green),
            if (isFastest) _buildTag("الأسرع", Colors.blue),
            if (isBest) _buildTag("الأفضل", Colors.orange),
          ],
        ),
        Text(
          cabinClass,
          style: TextStyle(
            fontSize: 12.sp,
            color: Colors.grey.shade600,
            fontFamily: 'ElMessiri',
          ),
        ),
      ],
    );
  }

  Widget _buildTag(String label, Color color) {
    return Container(
      margin: EdgeInsets.only(left: 8.w),
      padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(4.r),
      ),
      child: Text(
        label,
        style: TextStyle(
          fontSize: 10.sp,
          color: color,
          fontWeight: FontWeight.bold,
          fontFamily: 'ElMessiri',
        ),
      ),
    );
  }
}
