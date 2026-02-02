import 'package:flutter/material.dart';
import 'package:flutter_application_1/core/theme/app_text_style.dart';
import 'package:flutter_application_1/featuer/home/view/widgets/recommended_hotel_card.dart';
import 'package:flutter_application_1/featuer/hotels/data/model/getHotel_model.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class RelatedHotelsList extends StatelessWidget {
  final List<HotelItem> relatedHotels;

  const RelatedHotelsList({super.key, required this.relatedHotels});

  @override
  Widget build(BuildContext context) {
    if (relatedHotels.isEmpty) return const SizedBox();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "فنادق مشابهة",
          style: AppTextStyle.setelMessiriBlack(
            fontSize: 18.sp,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(height: 16.h),
        SizedBox(
          height: 280.h,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            itemCount: relatedHotels.length,
            separatorBuilder: (_, __) => SizedBox(width: 16.w),
            physics: const BouncingScrollPhysics(),
            itemBuilder: (context, index) {
              return SizedBox(
                width: 220.w, // Fixed width for cards
                child: RecommendedHotelCard(hotel: relatedHotels[index]),
              );
            },
          ),
        ),
      ],
    );
  }
}
