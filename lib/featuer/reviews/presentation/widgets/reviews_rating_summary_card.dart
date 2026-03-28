import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../../../../core/theme/app_text_style.dart';

class ReviewsRatingSummaryCard extends StatelessWidget {
  const ReviewsRatingSummaryCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(24.w),
      decoration: BoxDecoration(
        color: const Color(0xFF8E9EB8), // Blue-ish grey from screenshot
        borderRadius: BorderRadius.circular(32.r),
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Left side: Rating text
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "تقييم ممتاز استنادًا إلى +1,248 مراجعة موثقة من عملائنا وتجارب سفر ناجحة من الحجز وحتى العودة.",
                      style: AppTextStyle.setelMessiriWhite(fontSize: 14, fontWeight: FontWeight.normal).copyWith(height: 1.5),
                      textAlign: TextAlign.right,
                    ),
                  ],
                ),
              ),
              SizedBox(width: 16.w),
              // Right side: Big 4.9
              Text(
                "4.9",
                style: AppTextStyle.setelMessiriWhite(fontSize: 64, fontWeight: FontWeight.bold),
              ),
            ],
          ),
          SizedBox(height: 24.h),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // Stars (Bottom Left)
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: List.generate(
                      5,
                      (index) => Icon(Icons.star, color: Colors.white, size: 20.sp),
                    ),
                  ),
                  SizedBox(height: 4.h),
                  Text(
                    "تقييمات موثقة",
                    style: AppTextStyle.setelMessiriWhite(fontSize: 14, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
              // Google Info (Bottom Right)
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  const Icon(FontAwesomeIcons.google, color: Colors.white, size: 32),
                  SizedBox(height: 4.h),
                  Text(
                    "معتمد من مراجعات\nGoogle",
                    textAlign: TextAlign.right,
                    style: AppTextStyle.setelMessiriWhite(fontSize: 12, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ],
          ),
          SizedBox(height: 24.h),
          // Large Button
          SizedBox(
            width: double.infinity,
            height: 56.h,
            child: ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF002868),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(28.r)),
                elevation: 0,
              ),
              child: Text(
                "اكتب تقييمك الآن",
                style: AppTextStyle.setelMessiriWhite(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
