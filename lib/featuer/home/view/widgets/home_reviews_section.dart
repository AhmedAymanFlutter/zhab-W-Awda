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
            "نفخر بثقة عملائنا وتجاربهم المميزة معنا. اطلع على تقييمات المسافرين\nالحقيقية عبر Google وشاهد كيف كانت رحلاتهم معنا من الحجز وحتى\nالعودة.",
            textAlign: TextAlign.center,
            style: AppTextStyle.setelMessiriBlack(
              fontSize: 13,
              fontWeight: FontWeight.normal,
            ).copyWith(color: Colors.grey[700], height: 1.5),
          ),
          SizedBox(height: 24.h),

          // 2. Big Summary Card
          _buildSummaryCard(),
          SizedBox(height: 24.h),

          // 3. Horizontal Reviews List
          SizedBox(
            height: 190.h,
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

          // 4. View All Button Footer
          InkWell(
            onTap: () => Navigator.pushNamed(context, Routes.reviewsView),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  "عرض جميع التقييمات",
                  style: AppTextStyle.setelMessiriBlack(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ).copyWith(color: AppColor.primaryBlue),
                ),
                SizedBox(width: 8.w),
                Icon(
                  Icons.arrow_back_ios, // Points left in RTL
                  size: 16.sp,
                  color: AppColor.primaryBlue,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSummaryCard() {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(24.w),
      decoration: BoxDecoration(
        color: const Color(0xFF8EA1C0), // Light blue-grey from image
        borderRadius: BorderRadius.circular(24.r),
      ),
      child: Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Right side (RTL start): Text and Google certified
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "تقييم ممتاز استنادًا إلى +1,248 مراجعة\nموثقة من عملائنا وتجارب سفر ناجحة من\nالحجز وحتى العودة.",
                      style: AppTextStyle.setelMessiriWhite(
                        fontSize: 14,
                        fontWeight: FontWeight.normal,
                      ).copyWith(height: 1.5),
                    ),
                    SizedBox(height: 20.h),
                    Row(
                      children: [
                        Container(
                          width: 36.w,
                          height: 36.w,
                          decoration: const BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.white,
                          ),
                          child: Center(
                            child: Image.network(
                                "https://cdn-icons-png.flaticon.com/512/2991/2991148.png",
                                width: 20.w,
                                height: 20.w,
                                errorBuilder: (context, error, stackTrace) => const SizedBox.shrink(),
                            ),
                          ),
                        ),
                        SizedBox(width: 12.w),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "معتمد من مراجعات",
                              style: AppTextStyle.setelMessiriWhite(
                                fontSize: 13,
                                fontWeight: FontWeight.normal,
                              ),
                            ),
                            Text(
                              "Google",
                              style: AppTextStyle.setelMessiriWhite(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              // Left side (RTL end): 4.9 and Stars
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    "4.9",
                    style: AppTextStyle.setelMessiriWhite(
                      fontSize: 48,
                      fontWeight: FontWeight.bold,
                    ).copyWith(height: 1.0),
                  ),
                  SizedBox(height: 4.h),
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: List.generate(
                      5,
                      (index) => Icon(Icons.star, color: Colors.white, size: 16.w),
                    ),
                  ),
                  SizedBox(height: 4.h),
                  Text(
                    "تقييمات موثقة",
                    style: AppTextStyle.setelMessiriWhite(
                      fontSize: 12,
                      fontWeight: FontWeight.normal,
                    ),
                  ),
                ],
              ),
            ],
          ),
          SizedBox(height: 24.h),
          // Button
          SizedBox(
            width: double.infinity,
            height: 48.h,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF032D60), // Dark blue from image
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(24.r),
                ),
                elevation: 0,
              ),
              onPressed: () {},
              child: Text(
                "اكتب تقييمك الآن",
                style: AppTextStyle.setelMessiriWhite(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
