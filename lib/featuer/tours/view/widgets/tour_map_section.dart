import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/theme/app_text_style.dart';

class TourMapSection extends StatelessWidget {
  const TourMapSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Text(
          "الموقع",
          style: AppTextStyle.setelMessiriBlack(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(height: 12.h),
        ClipRRect(
          borderRadius: BorderRadius.circular(12.r),
          child: Image.network(
            "https://images.unsplash.com/photo-1526772662000-3f88f10405ff?w=800&auto=format&fit=crop",
            height: 180.h,
            width: double.infinity,
            fit: BoxFit.cover,
            errorBuilder: (context, error, stackTrace) => Container(
              height: 180.h,
              width: double.infinity,
              color: Colors.grey[100],
              child: Icon(
                Icons.map_outlined,
                color: Colors.grey,
                size: 40.sp,
              ),
            ),
          ),
        ),
        SizedBox(height: 8.h),
        Center(
          child: InkWell(
            onTap: () {},
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.map_outlined,
                  color: Colors.grey[600],
                  size: 18.sp,
                ),
                SizedBox(width: 8.w),
                Text(
                  "اكتشف طريقك بسهولة",
                  style: TextStyle(
                    color: Colors.grey[600],
                    fontSize: 14.sp,
                    fontFamily: 'ElMessiri',
                    decoration: TextDecoration.underline,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
