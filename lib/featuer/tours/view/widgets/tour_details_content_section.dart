import 'package:flutter/material.dart';
import 'package:flutter_application_1/featuer/tours/data/model/get_tour_id_model.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import '../../../../core/theme/app_text_style.dart';
import 'tour_highlights_section.dart';
import 'tour_inclusions_grid.dart';
import 'tour_map_section.dart';
import 'tour_premium_options.dart';
import 'tour_quick_stats_row.dart';

class TourDetailsContentSection extends StatelessWidget {
  final TourIdData tour;

  const TourDetailsContentSection({super.key, required this.tour});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(24.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(30.r),
          topRight: Radius.circular(30.r),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, -5),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          // Title, Rating, Location
          TourHighlightsSection(
            title: tour.title ?? "",
            rating: tour.rating?.average,
            ratingCount: tour.rating?.count,
            city: tour.city,
            country: tour.country,
          ),

          // Description Section
          Text(
            "وصف الجولة",
            style: AppTextStyle.setelMessiriBlack(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 12.h),
          HtmlWidget(
            tour.description ??
                tour.descText ??
                "استمتع بتجربة فريدة ومميزة مع هذه الجولة السياحية.",
            textStyle: TextStyle(
              fontSize: 14.sp,
              color: Colors.grey[700],
              height: 1.6,
              fontFamily: 'ElMessiri',
            ),
          ),

          SizedBox(height: 20.h),

          // Quick Stats Chips
          TourQuickStatsRow(),

          SizedBox(height: 32.h),

          // Highlights (ابرز المميزات)
          if (tour.includes != null && tour.includes!.isNotEmpty)
            TourInclusionsGrid(includes: tour.includes!),

          const TourMapSection(),

          SizedBox(height: 32.h),

          // Packages Section
          if (tour.productOptions != null && tour.productOptions!.isNotEmpty)
            TourPremiumOptions(
              options: tour.productOptions!,
              tourDescription: tour.descText ?? tour.description,
            ),

          SizedBox(height: 120.h), // Space for bottom bar
        ],
      ),
    );
  }
}
