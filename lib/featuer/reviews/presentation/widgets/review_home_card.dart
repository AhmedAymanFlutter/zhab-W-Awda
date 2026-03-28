import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/theme/app_text_style.dart';
import '../../domain/entities/review.dart';

class ReviewHomeCard extends StatelessWidget {
  final Review review;

  const ReviewHomeCard({super.key, required this.review});

  @override
  Widget build(BuildContext context) {
    // Clean review text
    String displayText = review.reviewText ?? '';
    if (displayText.contains('|')) {
      displayText = displayText.split('|')[0].trim();
    }
    displayText = displayText.replaceAll('...More', '').trim();

    return Container(
      width: 280.w, // Match horizontal card width
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
        crossAxisAlignment: CrossAxisAlignment.start, // Start is Right in RTL
        children: [
          // Header Row
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // 1. Profile Pic (on the Right in RTL)
              _buildAvatar(),
              SizedBox(width: 12.w),
              // 2. Name & Stars
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      review.reviewer ?? 'بدون اسم',
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: AppTextStyle.setelMessiriBlack(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 4.h),
                    RatingBarIndicator(
                      rating: (review.starRate ?? 0).toDouble(),
                      itemBuilder: (context, index) => const Icon(Icons.star, color: Color(0xFFFFC107)),
                      itemCount: 5,
                      itemSize: 14.w,
                      direction: Axis.horizontal,
                    ),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(height: 12.h),
          // Review Text
          Expanded(
            child: Text(
              displayText,
              maxLines: 4,
              overflow: TextOverflow.ellipsis,
              textAlign: TextAlign.start, // RTL -> right aligned
              style: AppTextStyle.setelMessiriBlack(
                fontSize: 12,
                fontWeight: FontWeight.normal,
              ).copyWith(height: 1.5, color: Colors.grey[800]),
            ),
          ),
          SizedBox(height: 12.h),
          // Footer Row
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // Date on the Right (Start in RTL)
              Text(
                "12 يوم", // Or dynamic if available
                style: AppTextStyle.setelMessiriBlack(
                  fontSize: 12,
                  fontWeight: FontWeight.normal,
                ).copyWith(color: Colors.grey[600]),
              ),
              // Google Logo + Text on the Left (End in RTL)
              Row(
                children: [
                  Text(
                    "عرض علي Google",
                    style: AppTextStyle.setelMessiriBlack(
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  SizedBox(width: 6.w),
                  Image.network(
                    "https://cdn-icons-png.flaticon.com/512/2991/2991148.png",
                    width: 16.w,
                    height: 16.w,
                    errorBuilder: (context, error, stackTrace) => const SizedBox.shrink(),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildAvatar() {
    return Container(
      width: 45.w,
      height: 45.w,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: Colors.blueGrey[100], 
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(22.5.r),
        child: (review.reviewerPic != null && review.reviewerPic!.isNotEmpty)
            ? CachedNetworkImage(
                imageUrl: review.reviewerPic!,
                fit: BoxFit.cover,
                placeholder: (context, url) => Center(
                  child: SizedBox(
                    width: 16.w,
                    height: 16.w,
                    child: const CircularProgressIndicator(strokeWidth: 2),
                  ),
                ),
                errorWidget: (context, url, error) => _buildPlaceholder(),
              )
            : _buildPlaceholder(),
      ),
    );
  }

  Widget _buildPlaceholder() {
    String initials = '';
    if (review.reviewer != null && review.reviewer!.isNotEmpty) {
      initials = review.reviewer![0].toUpperCase();
    }
    return Center(
      child: Text(
        initials,
        style: AppTextStyle.setelMessiriBlack(fontSize: 16, fontWeight: FontWeight.bold),
      ),
    );
  }
}
