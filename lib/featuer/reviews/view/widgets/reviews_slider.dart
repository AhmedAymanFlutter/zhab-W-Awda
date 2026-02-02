import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/featuer/reviews/data/models/review_model.dart';
import 'package:flutter_application_1/featuer/reviews/view/widgets/review_home_card.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ReviewsSlider extends StatelessWidget {
  final List<ReviewModel> reviews;

  const ReviewsSlider({super.key, required this.reviews});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        CarouselSlider.builder(
          itemCount: reviews.length,
          itemBuilder: (context, index, realIndex) {
            final review = reviews[index];
            return Padding(
              padding: EdgeInsets.symmetric(horizontal: 4.w),
              child: ReviewHomeCard(review: review),
            );
          },
          options: CarouselOptions(
            height: 160.h,
            viewportFraction: 0.85,
            autoPlay: true,
            enlargeCenterPage: true,
            enableInfiniteScroll: true,
            autoPlayCurve: Curves.fastOutSlowIn,
            autoPlayInterval: const Duration(seconds: 4),
          ),
        ),
      ],
    );
  }
}
