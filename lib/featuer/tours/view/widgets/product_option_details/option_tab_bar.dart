import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../core/theme/app_color.dart';

class OptionTabBar extends StatelessWidget {
  final int selectedIndex;
  final Function(int) onTabChanged;

  const OptionTabBar({
    super.key,
    required this.selectedIndex,
    required this.onTabChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(color: Colors.grey[200]!, width: 1),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _buildTab("الشروط والأحكام", 2),
          _buildTab("كيفية الإستخدام", 1),
          _buildTab("وصف الباقة", 0),
        ],
      ),
    );
  }

  Widget _buildTab(String label, int index) {
    final bool isSelected = selectedIndex == index;
    return InkWell(
      onTap: () => onTabChanged(index),
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.symmetric(vertical: 12.h),
            child: Text(
              label,
              style: TextStyle(
                fontSize: 14.sp,
                fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                color: isSelected ? AppColor.primaryBlue3 : Colors.grey[600],
                fontFamily: 'ElMessiri',
              ),
            ),
          ),
          if (isSelected)
            Container(
              width: 60.w,
              height: 2.h,
              color: AppColor.primaryBlue3,
            ),
        ],
      ),
    );
  }
}
