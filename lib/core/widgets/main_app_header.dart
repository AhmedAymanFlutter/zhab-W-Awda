import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../theme/app_color.dart';
import '../theme/app_text_style.dart';

class MainAppHeader extends StatelessWidget {
  final String title;
  final VoidCallback? onMenuTap;
  final Color? backgroundColor;
  final Color? textColor;
  final Color? iconColor;
  final IconData leadingIcon;

  const MainAppHeader({
    super.key,
    this.title = "ذهاب وعودة",
    this.onMenuTap,
    this.backgroundColor,
    this.textColor = Colors.white,
    this.iconColor = Colors.white,
    this.leadingIcon = Icons.menu,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 4.h),
      decoration: BoxDecoration(
        color: backgroundColor ?? AppColor.primaryBlue3,
        borderRadius: BorderRadius.circular(30.r),
      ),
      child: Row(
        textDirection: TextDirection.rtl,
        children: [
          Row(
            textDirection: TextDirection.ltr,
            children: [
              Text(
                title,
                style: AppTextStyle.setelMessiriWhite(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ).copyWith(color: textColor),
              ),
            ],
          ),
          const Spacer(),
          IconButton(
            icon: Icon(leadingIcon, color: iconColor, size: 24.sp),
            onPressed:
                onMenuTap ??
                () {
                  Scaffold.of(context).openDrawer();
                },
          ),

          SizedBox(width: 8.w), // Additional spacing to balance the menu icon
        ],
      ),
    );
  }
}
