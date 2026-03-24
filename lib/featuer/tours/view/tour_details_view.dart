import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import '../../../../core/theme/app_text_style.dart';
import '../data/repo/tours_repository.dart';
import 'widgets/tour_details_app_bar.dart';
import 'widgets/tour_info_section.dart';
import 'widgets/tour_stats_row.dart';
import 'widgets/tour_timeline.dart';
import 'package:flutter_application_1/core/widgets/offer_booking_bar.dart';
import 'package:flutter_application_1/featuer/tours/manager/tours_cubit.dart';
import 'package:flutter_application_1/featuer/tours/manager/tours_state.dart';

class TourDetailsView extends StatelessWidget {
  final String tourId;

  const TourDetailsView({super.key, required this.tourId});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          ToursCubit(ToursRepository())..getTourDetails(tourId),
      child: Scaffold(
        backgroundColor: Colors.white,
        bottomNavigationBar: const OfferBookingBar(),
        body: BlocBuilder<ToursCubit, ToursState>(
          buildWhen: (previous, current) =>
              current is TourDetailsLoading ||
              current is TourDetailsSuccess ||
              current is TourDetailsError,
          builder: (context, state) {
            if (state is TourDetailsLoading) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is TourDetailsError) {
              return Center(child: Text(state.message));
            } else if (state is TourDetailsSuccess) {
              final tour = state.tour;

              return CustomScrollView(
                slivers: [
                  // --- 1. Immersive AppBar ---
                  TourDetailsAppBar(imageCover: tour.imageCover),

                  // --- 2. Content Body ---
                  SliverToBoxAdapter(
                    child: Container(
                      transform: Matrix4.translationValues(0, -30, 0),
                      padding: EdgeInsets.symmetric(
                        horizontal: 24.w,
                        vertical: 32.h,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.vertical(
                          top: Radius.circular(32.r),
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.05),
                            blurRadius: 20,
                            offset: const Offset(0, -5),
                          ),
                        ],
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Title & Location
                          TourInfoSection(
                            title: tour.title,
                            city: tour.city,
                            country: tour.country,
                          ),

                          SizedBox(height: 32.h),

                          // Quick Stats
                          TourStatsRow(
                            days: tour.header?.days,
                            people: tour.header?.people,
                            type: tour.header?.type,
                          ),

                          SizedBox(height: 32.h),

                          // Description
                          Text(
                            "نبذة عن الرحلة",
                            style: AppTextStyle.setelMessiriBlack(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(height: 12.h),
                          HtmlWidget(
                            tour.description ??
                                tour.descText ??
                                "استمتع بتجربة فريدة ومميزة مع هذه الجولة السياحية.",
                            textStyle: TextStyle(
                              fontSize: 15.sp,
                              color: Colors.grey[700],
                              height: 1.6,
                              fontFamily: 'Tajawal',
                            ),
                          ),

                          SizedBox(height: 32.h),

                          // Timeline
                          if (tour.paths != null && tour.paths!.isNotEmpty)
                            TourTimeline(paths: tour.paths!),

                          SizedBox(height: 100.h), // Bottom padding
                        ],
                      ),
                    ),
                  ),
                ],
              );
            }
            return const SizedBox();
          },
        ),
      ),
    );
  }
}
