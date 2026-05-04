import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:flutter_application_1/core/theme/app_color.dart';
import 'package:flutter_application_1/core/theme/app_text_style.dart';
import 'package:skeletonizer/skeletonizer.dart';
import '../../manager/reviews_cubit.dart';
import '../../manager/reviews_state.dart';
import '../../data/repo/package_repo.dart';
import '../../data/model/get_reviews_model.dart';
import 'review_item_card.dart';

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
          final isLoading = state is ReviewsLoading;
          final reviews = (state is ReviewsSuccess) 
              ? state.reviews 
              : List.generate(3, (index) => ReviewModel(
                  authorName: "اسم العميل",
                  content: "هذا نص تجريبي لتقييم العميل على الباقة السياحية المقدمة من الشركة.",
                  rate: 5,
                  createdAt: DateTime.now().toIso8601String(),
                ));

          if (state is ReviewsError) return const SizedBox();
          if (state is ReviewsSuccess && reviews.isEmpty) return const SizedBox();

          return Skeletonizer(
            enabled: isLoading,
            child: Container(
              margin: EdgeInsets.symmetric(vertical: 24.h),
              padding: EdgeInsets.all(20.w),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(24.r),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.04),
                    blurRadius: 20,
                    offset: const Offset(0, 8),
                  ),
                ],
                border: Border.all(color: Colors.grey.shade50),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "آراء المسافرين",
                        style: AppTextStyle.setelMessiriBlack(fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 4.h),
                        decoration: BoxDecoration(
                          color: AppColor.primaryBlue.withOpacity(0.08),
                          borderRadius: BorderRadius.circular(12.r),
                        ),
                        child: Row(
                          children: [
                            Icon(Icons.star_rounded, color: Colors.amber, size: 18.sp),
                            SizedBox(width: 4.w),
                            Text(
                              "4.9",
                              style: TextStyle(fontSize: 13.sp, fontWeight: FontWeight.bold, color: AppColor.primaryBlue),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 24.h),
                  SizedBox(
                    height: 160.h,
                    child: PageView.builder(
                      controller: _pageController,
                      physics: const BouncingScrollPhysics(),
                      itemCount: reviews.length,
                      itemBuilder: (context, index) {
                        return ReviewItemCard(review: reviews[index]);
                      },
                    ),
                  ),
                  SizedBox(height: 20.h),
                  Center(
                    child: SmoothPageIndicator(
                      controller: _pageController,
                      count: reviews.length,
                      effect: ExpandingDotsEffect(
                        dotHeight: 6.h,
                        dotWidth: 6.w,
                        activeDotColor: AppColor.primaryBlue,
                        dotColor: Colors.grey.shade200,
                        expansionFactor: 4,
                        spacing: 8.w,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
