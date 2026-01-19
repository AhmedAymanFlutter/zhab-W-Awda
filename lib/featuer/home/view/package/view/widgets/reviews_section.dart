import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:flutter_application_1/core/theme/app_color.dart';
import 'package:flutter_application_1/core/theme/app_text_style.dart';
import '../../manager/reviews_cubit.dart';
import '../../manager/reviews_state.dart';
import '../../data/repo/package_repo.dart';
import '../../data/model/get_reviews_model.dart';
import 'package:intl/intl.dart';

class ReviewsSection extends StatefulWidget {
  final String packageSlug;

  const ReviewsSection({super.key, required this.packageSlug});

  @override
  State<ReviewsSection> createState() => _ReviewsSectionState();
}

class _ReviewsSectionState extends State<ReviewsSection> {
  final PageController _pageController = PageController();

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          ReviewsCubit(PackagesRepository())..getReviews(widget.packageSlug),
      child: BlocBuilder<ReviewsCubit, ReviewsState>(
        builder: (context, state) {
          if (state is ReviewsLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is ReviewsError) {
            return const SizedBox(); // Hide if error or handle gracefully
          } else if (state is ReviewsSuccess) {
            final reviews = state.reviews;
            if (reviews.isEmpty) return const SizedBox();

            return Container(
              margin: EdgeInsets.symmetric(vertical: 20.h),
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
                  // Title & Stars
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: List.generate(5, (index) {
                          return Icon(
                            Icons.star,
                            color: Colors.amber,
                            size: 20.sp,
                          );
                        }),
                      ),
                      Text(
                        "آراء العملاء",
                        style: AppTextStyle.setelMessiriBlack(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 16.h),

                  // Reviews Slider
                  SizedBox(
                    height: 180.h,
                    child: PageView.builder(
                      controller: _pageController,
                      itemCount: reviews.length,
                      itemBuilder: (context, index) {
                        return _buildReviewItem(reviews[index]);
                      },
                    ),
                  ),

                  SizedBox(height: 12.h),

                  // Indicator
                  Center(
                    child: SmoothPageIndicator(
                      controller: _pageController,
                      count: reviews.length,
                      effect: ExpandingDotsEffect(
                        dotHeight: 8.h,
                        dotWidth: 8.w,
                        activeDotColor: AppColor.primaryBlue,
                        dotColor: Colors.grey.shade300,
                      ),
                    ),
                  ),
                ],
              ),
            );
          }
          return const SizedBox();
        },
      ),
    );
  }

  Widget _buildReviewItem(ReviewModel review) {
    // Format date if possible, else use raw or placeholder
    String dateStr = "";
    if (review.createdAt != null) {
      try {
        final date = DateTime.parse(review.createdAt!);
        dateStr = DateFormat(
          'dd MMMM yyyy',
          'ar',
        ).format(date); // Arabic locale if supported or default
      } catch (e) {
        dateStr = review.createdAt!;
      }
    }

    return Container(
      padding: EdgeInsets.symmetric(horizontal: 8.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // Quote Icon
              Icon(
                Icons.format_quote,
                color: AppColor.primaryBlue,
                size: 32.sp,
              ),

              // Author Info
              Row(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        review.authorName ?? "Anonymous",
                        style: AppTextStyle.setelMessiriBlack(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Row(
                        children: List.generate(5, (index) {
                          return Icon(
                            index < (review.rate ?? 0)
                                ? Icons.star
                                : Icons.star_border,
                            color: Colors.amber,
                            size: 14.sp,
                          );
                        }),
                      ),
                    ],
                  ),
                  SizedBox(width: 10.w),
                  CircleAvatar(
                    backgroundColor: Colors.grey.shade200,
                    child: Text(
                      (review.authorName != null &&
                              review.authorName!.isNotEmpty)
                          ? review.authorName![0].toUpperCase()
                          : "U",
                      style: AppTextStyle.setelMessiriBlack(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
          SizedBox(height: 12.h),
          Text(
            review.content ?? "",
            style: AppTextStyle.setelMessiriSecondlightGrey(
              fontSize: 14,
              fontWeight: FontWeight.normal,
            ).copyWith(fontStyle: FontStyle.italic),
            maxLines: 3,
            overflow: TextOverflow.ellipsis,
            textAlign: TextAlign.right,
          ),
          const Spacer(),
          Align(
            alignment: Alignment.bottomLeft,
            child: Text(
              dateStr,
              style: TextStyle(color: Colors.grey, fontSize: 10.sp),
            ),
          ),
        ],
      ),
    );
  }
}
