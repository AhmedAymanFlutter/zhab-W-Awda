import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:flutter_application_1/core/theme/app_color.dart';
import 'package:flutter_application_1/core/theme/app_text_style.dart';
import '../../data/model/get_reviews_model.dart';

class ReviewItemCard extends StatelessWidget {
  final ReviewModel review;

  const ReviewItemCard({super.key, required this.review});

  @override
  Widget build(BuildContext context) {
    String dateStr = "-";
    if (review.createdAt != null) {
      try {
        final date = DateTime.parse(review.createdAt!);
        dateStr = DateFormat('dd MMMM yyyy', 'ar').format(date);
      } catch (e) {
        dateStr = review.createdAt!;
      }
    }

    return Container(
      padding: EdgeInsets.symmetric(horizontal: 4.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              // Avatar
              CircleAvatar(
                radius: 22.r,
                backgroundColor: AppColor.primaryBlue.withOpacity(0.1),
                child: Text(
                  (review.authorName?.isNotEmpty == true)
                      ? review.authorName![0].toUpperCase()
                      : "U",
                  style: TextStyle(
                    color: AppColor.primaryBlue,
                    fontSize: 16.sp,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              SizedBox(width: 12.w),
              // Name & Rate
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      review.authorName ?? "مسافر",
                      style: AppTextStyle.setelMessiriBlack(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Row(
                      children: List.generate(5, (index) {
                        return Icon(
                          index < (review.rate ?? 5)
                              ? Icons.star_rounded
                              : Icons.star_outline_rounded,
                          color: Colors.amber,
                          size: 14.sp,
                        );
                      }),
                    ),
                  ],
                ),
              ),
              // Date
              Text(
                dateStr,
                style: TextStyle(
                  color: Colors.grey.shade500,
                  fontSize: 11.sp,
                ),
              ),
            ],
          ),
          SizedBox(height: 16.h),
          // Content
          Expanded(
            child: Stack(
              children: [
                Positioned(
                  top: 0,
                  left: 0,
                  child: Icon(
                    Icons.format_quote_rounded,
                    color: Colors.grey.shade100,
                    size: 40.sp,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 8.h),
                  child: Text(
                    review.content ?? "",
                    style: TextStyle(
                      fontSize: 14.sp,
                      color: Colors.grey.shade700,
                      height: 1.6,
                      fontStyle: FontStyle.italic,
                    ),
                    maxLines: 3,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
