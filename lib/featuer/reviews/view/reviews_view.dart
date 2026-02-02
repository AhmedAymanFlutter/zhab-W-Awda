import 'package:flutter/material.dart';
import 'package:flutter_application_1/core/theme/app_color.dart';
import 'package:flutter_application_1/core/theme/app_text_style.dart';
import 'package:flutter_application_1/featuer/reviews/data/review_data.dart';
import 'package:flutter_application_1/featuer/reviews/view/widgets/review_card.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ReviewsView extends StatelessWidget {
  const ReviewsView({super.key});

  @override
  Widget build(BuildContext context) {
    final reviews = getReviews();

    return Scaffold(
      backgroundColor: AppColor.primaryWhite,
      appBar: AppBar(
        backgroundColor: AppColor.primaryBlue,
        elevation: 0,
        centerTitle: true,
        title: Text(
          'آراء العملاء',
          style: AppTextStyle.setelMessiriTextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: ListView.builder(
        padding: EdgeInsets.only(top: 10.h, bottom: 20.h),
        itemCount: reviews.length,
        itemBuilder: (context, index) {
          return ReviewCard(review: reviews[index]);
        },
      ),
    );
  }
}
