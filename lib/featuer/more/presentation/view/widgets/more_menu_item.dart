import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

class MoreMenuItem extends StatelessWidget {
  final String title;
  final String iconPath;
  final VoidCallback onTap;
  final bool isSvg;
  final Color? iconColor;

  const MoreMenuItem({
    super.key,
    required this.title,
    required this.iconPath,
    required this.onTap,
    this.isSvg = true,
    this.iconColor,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 12.h, horizontal: 16.w),
        child: Row(
          children: [
            const Icon(Icons.arrow_back_ios_new, size: 16, color: Colors.grey),
            const Spacer(),
            Text(
              title,
              style: TextStyle(
                fontSize: 16.sp,
                fontWeight: FontWeight.w500,
                color: Colors.black87,
              ),
            ),
            SizedBox(width: 16.w),
            Container(
              padding: EdgeInsets.all(8.w),
              decoration: BoxDecoration(
                color: Colors.grey[100],
                borderRadius: BorderRadius.circular(10.r),
              ),
              child: isSvg
                  ? SvgPicture.asset(
                      iconPath,
                      width: 20.r,
                      height: 20.r,
                      colorFilter: iconColor != null
                          ? ColorFilter.mode(iconColor!, BlendMode.srcIn)
                          : null,
                    )
                  : Image.asset(
                      iconPath,
                      width: 20.r,
                      height: 20.r,
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
