import 'package:flutter/material.dart';
import 'package:flutter_application_1/core/theme/app_text_style.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class RewardsBalanceCard extends StatelessWidget {
  final int currentPoints;
  final int targetPoints;

  const RewardsBalanceCard({
    super.key,
    required this.currentPoints,
    this.targetPoints = 2000,
  });

  @override
  Widget build(BuildContext context) {
    double progress = (currentPoints / targetPoints).clamp(0.0, 1.0);

    return Column(
      children: [
        // Top Tip Bar
        Container(
          width: double.infinity,
          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 10.h),
          decoration: BoxDecoration(
            color: const Color(0xFFE9EEF3),
            borderRadius: BorderRadius.circular(8.r),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Text(
                "استمر بالحجز واجمع نقاطًا إضافية لرحلاتك القادمة.",
                style: AppTextStyle.setelMessiriBlack(
                  fontSize: 12,
                  fontWeight: FontWeight.normal,
                ),
              ),
              SizedBox(width: 8.w),
              Image.asset(
                'assets/photo/mony.png',
                width: 20.w,
                height: 20.h,
              ),
            ],
          ),
        ),
        SizedBox(height: 16.h),
        // Balance Card
        Container(
          padding: EdgeInsets.all(20.w),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16.r),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.05),
                blurRadius: 10,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Icon(Icons.arrow_back_ios, size: 18.sp, color: Colors.black),
                  Row(
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text(
                            "رصيد نقاطك",
                            style: AppTextStyle.setelMessiriBlack(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            "$currentPoints / $targetPoints",
                            style: AppTextStyle.setelMessiriBlack(
                              fontSize: 16,
                              fontWeight: FontWeight.normal,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(width: 16.w),
                      Container(
                        width: 60.w,
                        height: 60.h,
                        decoration: const BoxDecoration(
                          color: Color(0xFFF9F5FF),
                          shape: BoxShape.circle,
                        ),
                        child: Center(
                          child: Image.asset(
                            'assets/photo/points.png',
                            width: 40.w,
                            height: 40.h,
                            errorBuilder: (context, error, stackTrace) =>
                                const Icon(
                                  Icons.monetization_on,
                                  color: Colors.amber,
                                ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              SizedBox(height: 20.h),
              // Progress Bar
              Container(
                height: 8.h,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: const Color(0xFFE4E7EC),
                  borderRadius: BorderRadius.circular(4.r),
                ),
                child: FractionallySizedBox(
                  alignment: Alignment.centerRight,
                  widthFactor: progress,
                  child: Container(
                    decoration: BoxDecoration(
                      gradient: const LinearGradient(
                        colors: [Color(0xFF2ED573), Color(0xFF7BED9F)],
                      ),
                      borderRadius: BorderRadius.circular(4.r),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
