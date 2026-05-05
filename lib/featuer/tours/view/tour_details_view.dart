import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import '../../../../core/theme/app_text_style.dart';
import '../data/repo/tours_repository.dart';
import 'widgets/tour_gallery_grid.dart';
import 'widgets/tour_highlights_section.dart';
import 'widgets/tour_inclusions_grid.dart';
import 'widgets/tour_premium_options.dart';
import 'widgets/tour_quick_stats_row.dart';
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
        backgroundColor: const Color(0xFFF9F9F9),
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

              return Stack(
                children: [
                  SingleChildScrollView(
                    child: Center(
                      child: Container(
                        width: 345.w,
                        margin: EdgeInsets.only(top: 60.h, bottom: 100.h),
                        padding: EdgeInsets.all(16.w),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(13.r),
                          border: Border.all(color: const Color(0x121A1A1A)),
                          boxShadow: const [
                            BoxShadow(
                              color: Color(0x0D000000),
                              blurRadius: 4,
                              offset: Offset(0, 4),
                            ),
                          ],
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            // 1. Title & Rating Section
                            TourHighlightsSection(
                              title: tour.title ?? "",
                              rating: tour.rating?.average,
                              ratingCount: tour.rating?.count,
                              city: tour.city,
                              country: tour.country,
                            ),

                            SizedBox(height: 16.h),

                            // 2. Gallery Grid
                            TourGalleryGrid(images: tour.images ?? []),

                            SizedBox(height: 24.h),

                            // 3. Description
                            Text(
                              "وصف الجولة",
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
                                fontSize: 13.sp,
                                color: Colors.grey[700],
                                height: 1.6,
                                fontFamily: 'Tajawal',
                              ),
                            ),
                            
                            SizedBox(height: 24.h),

                            // 4. Quick Stats Chips
                            TourQuickStatsRow(),

                            SizedBox(height: 32.h),

                            // 5. Highlights (ابرز المميزات)
                            if (tour.includes != null && tour.includes!.isNotEmpty)
                              TourInclusionsGrid(includes: tour.includes!),

                            // 6. Map Section (Placeholder)
                            Text(
                              "الموقع",
                              style: AppTextStyle.setelMessiriBlack(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(height: 12.h),
                            ClipRRect(
                              borderRadius: BorderRadius.circular(12.r),
                              child: Image.network(
                                "https://images.unsplash.com/photo-1526772662000-3f88f10405ff?w=800&auto=format&fit=crop",
                                height: 180.h,
                                width: double.infinity,
                                fit: BoxFit.cover,
                              ),
                            ),
                            SizedBox(height: 8.h),
                            Center(
                              child: TextButton.icon(
                                onPressed: () {},
                                icon: const Icon(Icons.map_outlined, color: Colors.grey),
                                label: const Text(
                                  "اكتشف طريقك بسهولة",
                                  style: TextStyle(color: Colors.grey, decoration: TextDecoration.underline),
                                ),
                              ),
                            ),

                            SizedBox(height: 32.h),

                            // 7. Product Options (Packages)
                            if (tour.productOptions != null &&
                                tour.productOptions!.isNotEmpty)
                              TourPremiumOptions(options: tour.productOptions!),
                          ],
                        ),
                      ),
                    ),
                  ),

                  // Sticky Bottom Booking Bar
                  Positioned(
                    bottom: 0,
                    left: 0,
                    right: 0,
                    child: OfferBookingBar(
                      offerName: tour.title,
                      price: tour.price?.amount?.toStringAsFixed(0),
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


