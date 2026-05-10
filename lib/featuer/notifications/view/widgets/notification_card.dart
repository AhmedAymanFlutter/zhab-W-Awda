import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../core/theme/app_text_style.dart';

class NotificationCard extends StatelessWidget {
  final String title;
  final String subtitle;
  final String time;
  final Color iconBackgroundColor;
  final Widget icon;
  final bool isUnread;

  const NotificationCard({
    super.key,
    required this.title,
    required this.subtitle,
    required this.time,
    required this.iconBackgroundColor,
    required this.icon,
    this.isUnread = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 343.w,
      height: 91.h,
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
      decoration: BoxDecoration(
        color: isUnread ? const Color(0xFFF2F4F7) : Colors.white,
        borderRadius: BorderRadius.circular(12.r),
        boxShadow: const [
          BoxShadow(
            color: Color(0x14000000), // #00000014
            offset: Offset(0, 1),
            blurRadius: 4,
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // Texts (Right side in RTL)
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  title,
                  style: AppTextStyle.setelMessiriBlack(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 4.h),
                Text(
                  subtitle,
                  style: AppTextStyle.setelMessiriSecondlightGrey(
                    fontSize: 10,
                    fontWeight: FontWeight.w400,
                  ).copyWith(color: const Color(0xFF667085)),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                SizedBox(height: 4.h),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Container(
                      width: 6.w,
                      height: 6.w,
                      decoration: const BoxDecoration(
                        color: Color(0xFF12B76A), // Green dot
                        shape: BoxShape.circle,
                      ),
                    ),
                    SizedBox(width: 4.w),
                    Text(
                      time,
                      style: AppTextStyle.setelMessiriSecondlightGrey(
                        fontSize: 10,
                        fontWeight: FontWeight.w400,
                      ).copyWith(color: const Color(0xFF98A2B3)),
                    ),
                  ],
                ),
              ],
            ),
          ),
          SizedBox(width: 12.w),
          // Icon (Left side in RTL)
          Container(
            width: 40.w,
            height: 40.w,
            decoration: BoxDecoration(
              color: iconBackgroundColor,
              shape: BoxShape.circle,
            ),
            child: Center(child: icon),
          ),
        ],
      ),
    );
  }
}
