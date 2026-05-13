import 'package:flutter/material.dart';
import 'package:flutter_application_1/core/theme/app_text_style.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class BookingDetailsTabs extends StatelessWidget {
  final int activeIndex;
  final Function(int) onTabChanged;

  const BookingDetailsTabs({
    super.key,
    required this.activeIndex,
    required this.onTabChanged,
  });

  @override
  Widget build(BuildContext context) {
    final List<String> tabs = ["البرنامج", "الفنادق", "الطيران"];

    return Container(
      color: Colors.white,
      padding: EdgeInsets.symmetric(vertical: 8.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: List.generate(tabs.length, (index) {
          final bool isActive = activeIndex == index;
          return InkWell(
            onTap: () => onTabChanged(index),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  tabs[index],
                  style: AppTextStyle.setelMessiriTextStyle(
                    color: isActive
                        ? const Color(0xFF00276C)
                        : const Color(0xFF667085),
                    fontSize: 16,
                    fontWeight: isActive ? FontWeight.bold : FontWeight.normal,
                  ),
                ),
                SizedBox(height: 4.h),
                if (isActive)
                  Container(
                    height: 2.h,
                    width: 40.w,
                    color: const Color(0xFF00276C),
                  ),
              ],
            ),
          );
        }),
      ),
    );
  }
}
