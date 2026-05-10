import 'package:flutter/material.dart';
import 'package:flutter_application_1/core/router/routes.dart';
import 'package:flutter_application_1/featuer/reviews/presentation/widgets/review_home_card.dart';
import 'package:flutter_application_1/featuer/reviews/data/review_data.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/theme/app_color.dart';
import '../../../../core/theme/app_text_style.dart';

class HomeReviewsSection extends StatelessWidget {
  const HomeReviewsSection({super.key});

  @override
  Widget build(BuildContext context) {
    final reviews = getReviews();

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 32.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // 1. Header Titles
          Text(
            "آراء عملائنا",
            style: AppTextStyle.setelMessiriBlack(
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 8.h),
          Text(
            "اكتشف تجارب عملائنا واستمتع بقصص نجاح رحلاتهم معنا.",
            textAlign: TextAlign.center,
            style: AppTextStyle.setelMessiriSecondlightGrey(
              fontSize: 14,
              fontWeight: FontWeight.w400,
            ).copyWith(color: const Color(0xFF667085)),
          ),
          SizedBox(height: 24.h),

          // 2. Horizontal Reviews List
          SizedBox(
            height: 204.h,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              padding: EdgeInsets.symmetric(horizontal: 8.w),
              physics: const BouncingScrollPhysics(),
              itemCount: reviews.length,
              separatorBuilder: (_, __) => SizedBox(width: 16.w),
              itemBuilder: (context, index) {
                return ReviewHomeCard(review: reviews[index]);
              },
            ),
          ),
          SizedBox(height: 24.h),

          // 3. View All Button Footer
          InkWell(
            onTap: () => Navigator.pushNamed(context, Routes.reviewsView),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  Icons.arrow_back_ios, // Points left in RTL
                  size: 14.sp,
                  color: AppColor.primaryBlue,
                ),
                SizedBox(width: 8.w),
                Text(
                  "عرض جميع التقييمات",
                  style: AppTextStyle.setelMessiriBlack(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ).copyWith(color: AppColor.primaryBlue),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
