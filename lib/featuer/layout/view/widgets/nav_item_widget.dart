import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../../../core/theme/app_text_style.dart';

class NavItemWidget extends StatelessWidget {
  final String label;
  final String? asset;
  final IconData? icon;
  final int index;
  final int currentIndex;
  final VoidCallback onTap;

  const NavItemWidget({
    super.key,
    required this.label,
    this.asset,
    this.icon,
    required this.index,
    required this.currentIndex,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final bool isSelected = currentIndex == index;
    final Color color = isSelected
        ? const Color(0xFF002868)
        : const Color(0xFF98A2B3);

    return Expanded(
      child: GestureDetector(
        onTap: onTap,
        behavior: HitTestBehavior.opaque,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (asset != null)
              SvgPicture.asset(
                asset!,
                width: 26.w,
                height: 26.h,
                colorFilter: ColorFilter.mode(color, BlendMode.srcIn),
              )
            else if (icon != null)
              Icon(icon, size: 28.sp, color: color),
            SizedBox(height: 4.h),
            Text(
              label,
              style: AppTextStyle.setelMessiriTextStyle(
                fontSize: 12,
                fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                color: color,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
