import 'package:flutter/material.dart';
import 'package:flutter_application_1/core/theme/app_color.dart';
import 'package:flutter_application_1/core/theme/app_text_style.dart';
import 'package:flutter_application_1/featuer/reviews/data/models/review_model.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:readmore/readmore.dart';

class ReviewCard extends StatelessWidget {
  final ReviewModel review;

  const ReviewCard({super.key, required this.review});

  @override
  Widget build(BuildContext context) {
    // Determine the user's name initials or first letter if no image
    String initials = '';
    if (review.reviewer != null && review.reviewer!.isNotEmpty) {
      initials = review.reviewer![0].toUpperCase();
    }

    // Split review text to separate Arabic and English if possible, or just show as is.
    // The format seems to be "Arabic Text...More|English Text...More" or just text.
    // For simplicity, we'll display the whole text but clean up the structure if needed.
    // The '|' character seems to separate translations.
    String displayText = review.reviewText ?? '';
    displayText = displayText.replaceAll('|', '\n\n');

    return Container(
      margin: EdgeInsets.symmetric(vertical: 8.h, horizontal: 16.w),
      padding: EdgeInsets.all(16.w),
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
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // User Avatar
              Container(
                width: 50.w,
                height: 50.w,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: AppColor.primaryBlue,
                  image:
                      (review.reviewerPic != null &&
                          review.reviewerPic!.isNotEmpty)
                      ? DecorationImage(
                          image: NetworkImage(review.reviewerPic!),
                          fit: BoxFit.cover,
                          onError:
                              (
                                exception,
                                stackTrace,
                              ) {}, // Fallback handled by child
                        )
                      : null,
                ),
                alignment: Alignment.center,
                child:
                    (review.reviewerPic == null || review.reviewerPic!.isEmpty)
                    ? Text(
                        initials,
                        style: AppTextStyle.setelMessiriWhite(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      )
                    : null,
              ),
              SizedBox(width: 12.w),

              // Name and Stars
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      review.reviewer ?? 'Unknown',
                      style: AppTextStyle.setelMessiriBlack(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    SizedBox(height: 4.h),
                    Row(
                      children: [
                        RatingBarIndicator(
                          rating: (review.starRate ?? 0).toDouble(),
                          itemBuilder: (context, index) =>
                              const Icon(Icons.star, color: Colors.amber),
                          itemCount: 5,
                          itemSize: 16.w,
                          direction: Axis.horizontal,
                        ),
                        SizedBox(width: 6.w),
                        if (review.reviewerMetaInfo != null)
                          Expanded(
                            child: Text(
                              review.reviewerMetaInfo!,
                              style: AppTextStyle.setelMessiriSecondlightGrey(
                                fontSize: 12,
                                fontWeight: FontWeight.normal,
                              ),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                      ],
                    ),
                  ],
                ),
              ),

              // Google Icon (to indicate source)
              const Icon(
                FontAwesomeIcons.google,
                color: Colors.grey, // Or brand color
                size: 18,
              ),
            ],
          ),

          SizedBox(height: 12.h),

          // Review Text
          ReadMoreText(
            displayText,
            trimLines: 4,
            colorClickableText: AppColor.primaryBlue,
            trimMode: TrimMode.Line,
            trimCollapsedText: '...قرأة المزيد',
            trimExpandedText: ' أقل',
            style: AppTextStyle.setelMessiriBlack(
              fontSize: 14,
              fontWeight: FontWeight.normal,
            ),
            moreStyle: AppTextStyle.setelMessiriTextStyle(
              fontSize: 14,
              fontWeight: FontWeight.bold,
              color: AppColor.primaryBlue,
            ),
          ),
        ],
      ),
    );
  }
}
