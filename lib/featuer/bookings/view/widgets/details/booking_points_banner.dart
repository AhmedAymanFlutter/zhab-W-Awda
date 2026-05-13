import 'package:flutter/material.dart';
import 'package:flutter_application_1/core/theme/app_text_style.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class BookingPointsBanner extends StatelessWidget {
  final int points;

  const BookingPointsBanner({super.key, required this.points});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(12.w),
      decoration: BoxDecoration(
        color: const Color(0xFFFFFBE6),
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(color: const Color(0xFFFFF1B8)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
           Icon(Icons.arrow_back_ios, size: 14.sp, color: Colors.black87),
           const Spacer(),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                "اجمع $points نقطة واستمتع بعروض",
                style: AppTextStyle.setelMessiriTextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),
              Text(
                "حصرية",
                style: AppTextStyle.setelMessiriTextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),
            ],
          ),
          SizedBox(width: 12.w),
          Container(
            padding: EdgeInsets.all(8.w),
            decoration: BoxDecoration(
              color: const Color(0xFFFFE58F),
              borderRadius: BorderRadius.circular(8.r),
            ),
            child: const Icon(Icons.stars, color: Colors.orange),
          ),
        ],
      ),
    );
  }
}
