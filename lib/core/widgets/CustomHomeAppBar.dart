import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomHomeAppBar extends StatelessWidget implements PreferredSizeWidget {
  final Widget? leading;
  final Widget? title;
  final List<Widget>? actions;
  final Color backgroundColor;
  final Color borderColor;

  const CustomHomeAppBar({
    super.key,
    this.leading,
    this.title,
    this.actions,
    this.backgroundColor = Colors.white,
    this.borderColor = const Color(0xFFEAE9EB),
  });

  @override
  Size get preferredSize => Size.fromHeight(60.h);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60.h,
      padding: EdgeInsets.only(top: 8.h, right: 16.w, bottom: 16.h, left: 16.w),
      decoration: BoxDecoration(
        color: backgroundColor,
        border: Border(bottom: BorderSide(color: borderColor, width: 2)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          leading ?? const SizedBox(),

          Expanded(child: Center(child: title ?? const SizedBox())),

          Row(mainAxisSize: MainAxisSize.min, children: actions ?? []),
        ],
      ),
    );
  }
}
