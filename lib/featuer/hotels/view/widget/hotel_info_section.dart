import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/theme/app_color.dart';
import '../../../../core/theme/app_text_style.dart';

class HotelInfoSection extends StatelessWidget {
  final dynamic ratingAverage;
  final dynamic rating;
  final num? numberOfReviews;
  final String? checkIn;

  const HotelInfoSection({
    super.key,
    required this.ratingAverage,
    required this.rating,
    required this.numberOfReviews,
    required this.checkIn,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 6.h),
          decoration: BoxDecoration(
            color: AppColor.primaryBlue,
            borderRadius: BorderRadius.circular(20.r),
          ),
          child: Row(
            children: [
              Icon(Icons.star, color: Colors.white, size: 16.sp),
              SizedBox(width: 4.w),
              Text(
                ratingAverage?.toStringAsFixed(1) ?? rating ?? "0.0",
                style: AppTextStyle.setelMessiriWhite(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
        SizedBox(width: 12.w),
        Text(
          "${numberOfReviews ?? 0} Reviews",
          style: AppTextStyle.setelMessiriSecondlightGrey(
            fontSize: 14,
            fontWeight: FontWeight.bold,
          ).copyWith(decoration: TextDecoration.underline),
        ),
        const Spacer(),
        if (checkIn != null)
          Row(
            children: [
              Icon(Icons.access_time, size: 16.sp, color: Colors.grey),
              SizedBox(width: 4.w),
              Text(
                "Check-in: $checkIn",
                style: AppTextStyle.setelMessiriSecondlightGrey(
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
      ],
    );
  }
}
