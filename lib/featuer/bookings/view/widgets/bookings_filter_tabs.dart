import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../core/theme/app_text_style.dart';

class BookingsFilterTabs extends StatelessWidget {
  final bool isUpcomingActive;
  final Function(bool) onTabChanged;

  const BookingsFilterTabs({
    super.key,
    required this.isUpcomingActive,
    required this.onTabChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        _buildTab(
          title: "المنتهية",
          isActive: !isUpcomingActive,
          onTap: () => onTabChanged(false),
        ),
        SizedBox(width: 8.w),
        _buildTab(
          title: "القادمة",
          isActive: isUpcomingActive,
          onTap: () => onTabChanged(true),
        ),
      ],
    );
  }

  Widget _buildTab({
    required String title,
    required bool isActive,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 167.5.w,
        height: 48.h,
        padding: EdgeInsets.symmetric(vertical: 8.h, horizontal: 16.w),
        decoration: BoxDecoration(
          color: isActive ? const Color(0x2600276C) : Colors.white,
          borderRadius: BorderRadius.circular(12.r),
          border: Border.all(
            color: isActive ? const Color(0xFF00276C) : Colors.transparent,
            width: 1,
          ),
          boxShadow: [
            if (!isActive)
              BoxShadow(
                color: Colors.black.withOpacity(0.05),
                blurRadius: 4,
                offset: const Offset(0, 2),
              ),
          ],
        ),
        alignment: Alignment.center,
        child: Text(
          title,
          style: AppTextStyle.setelMessiriBlack(
            fontSize: 16,
            fontWeight: isActive ? FontWeight.bold : FontWeight.normal,
          ).copyWith(
            color: isActive ? const Color(0xFF00276C) : const Color(0xFF667085),
          ),
        ),
      ),
    );
  }
}
