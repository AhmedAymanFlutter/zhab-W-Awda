import 'package:flutter/material.dart';
import 'package:flutter_application_1/core/theme/app_color.dart';
import 'package:flutter_application_1/core/theme/app_text_style.dart';
import 'package:flutter_application_1/featuer/reviews/data/models/review_model.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class ReviewHomeCard extends StatelessWidget {
  final ReviewModel review;

  const ReviewHomeCard({super.key, required this.review});

  @override
  Widget build(BuildContext context) {
    String initials = '';
    if (review.reviewer != null && review.reviewer!.isNotEmpty) {
      initials = review.reviewer![0].toUpperCase();
    }

    String displayText = review.reviewText ?? '';
    displayText = displayText.replaceAll('|', ' ');
    if (displayText.length > 80) {
      displayText = '${displayText.substring(0, 80)}...';
    }

    return Container(
      width: 280.w,
      padding: EdgeInsets.all(12.w),
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
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 40.w,
                height: 40.w,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: AppColor.primaryBlue,
                  image:
                      (review.reviewerPic != null &&
                          review.reviewerPic!.isNotEmpty)
                      ? DecorationImage(
                          image: NetworkImage(review.reviewerPic!),
                          fit: BoxFit.cover,
                          onError: (exception, stackTrace) {},
                        )
                      : null,
                ),
                alignment: Alignment.center,
                child:
                    (review.reviewerPic == null || review.reviewerPic!.isEmpty)
                    ? Text(
                        initials,
                        style: AppTextStyle.setelMessiriWhite(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                        ),
                      )
                    : null,
              ),
              SizedBox(width: 8.w),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      review.reviewer ?? 'Unknown',
                      style: AppTextStyle.setelMessiriBlack(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    RatingBarIndicator(
                      rating: (review.starRate ?? 0).toDouble(),
                      itemBuilder: (context, index) =>
                          const Icon(Icons.star, color: Colors.amber),
                      itemCount: 5,
                      itemSize: 12.w,
                      direction: Axis.horizontal,
                    ),
                  ],
                ),
              ),
              const Icon(FontAwesomeIcons.google, color: Colors.grey, size: 14),
            ],
          ),
          SizedBox(height: 8.h),
          Text(
            displayText,
            style: AppTextStyle.setelMessiriBlack(
              fontSize: 12,
              fontWeight: FontWeight.normal,
            ),
            maxLines: 3,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }
}
