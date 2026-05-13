import 'package:flutter/material.dart';
import 'package:flutter_application_1/core/theme/app_text_style.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class BookingGeneralOverview extends StatelessWidget {
  final String description;
  final String fullDescription;

  const BookingGeneralOverview({
    super.key,
    required this.description,
    required this.fullDescription,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16.r),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Text(
                "نظرة عامة",
                style: AppTextStyle.setelMessiriBlack(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(width: 8.w),
              Container(
                padding: EdgeInsets.all(6.w),
                decoration: BoxDecoration(
                  color: const Color(0xFFE6F7FF),
                  borderRadius: BorderRadius.circular(8.r),
                ),
                child: const Icon(Icons.assignment_turned_in_outlined, color: Color(0xFF1890FF)),
              ),
            ],
          ),
          SizedBox(height: 12.h),
          Text(
            fullDescription,
            textAlign: TextAlign.right,
            style: AppTextStyle.setelMessiriTextStyle(
              fontSize: 14,
              color: const Color(0xFF475467),
              fontWeight: FontWeight.normal,
            ).copyWith(height: 1.6),
          ),
        ],
      ),
    );
  }
}
