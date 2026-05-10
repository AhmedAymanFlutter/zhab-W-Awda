import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../../../core/theme/app_text_style.dart';

class HomeHeaderSearchBar extends StatelessWidget {
  const HomeHeaderSearchBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 343.5.w,
      height: 44.h,
      padding: EdgeInsets.fromLTRB(16.w, 8.h, 16.w, 8.h),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14.r),
        border: Border.all(
          color: const Color(0xC9D9D9D9), // CSS #D9D9D9C9 -> Flutter 0xC9D9D9D9
          width: 1,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        children: [
          SvgPicture.asset(
            'assets/icon/setting-4.svg',
            width: 20.w,
            height: 20.h,
          ),

          Spacer(), // 8px gap
          Text(
            "بحث",
            style: AppTextStyle.setelMessiriSecondlightGrey(
              fontSize: 16,
              fontWeight: FontWeight.w400,
            ),
          ),
          SizedBox(width: 8.w), // 8px gap
          SvgPicture.asset(
            'assets/icon/search-normal.svg',
            width: 20.w,
            height: 20.h,
          ),
        ],
      ),
    );
  }
}
