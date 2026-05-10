import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import '../../../../core/theme/app_text_style.dart';
import '../data/repo/tours_repository.dart';
import 'widgets/tour_highlights_section.dart';
import 'widgets/tour_inclusions_grid.dart';
import 'widgets/tour_premium_options.dart';
import 'widgets/tour_quick_stats_row.dart';
import 'widgets/tour_booking_bottom_bar.dart';
import '../manager/tours_cubit.dart';
import '../manager/tours_state.dart';

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
              final mainImage = (tour.images != null && tour.images!.isNotEmpty)
                  ? tour.images!.first
                  : "https://images.unsplash.com/photo-1542314831-068cd1dbfeeb?w=800";

              return Stack(
                children: [
                  // 1. Full-width Banner Image
                  Positioned(
                    top: 0,
                    left: 0,
                    right: 0,
                    child: Image.network(
                      mainImage,
                      height: 350.h,
                      width: double.infinity,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) => Container(
                        height: 350.h,
                        color: Colors.grey[200],
                        child: Icon(
                          Icons.image_not_supported_outlined,
                          color: Colors.grey,
                          size: 50.sp,
                        ),
                      ),
                    ),
                  ),

                  // 2. Navigation Buttons Over Image
                  Positioned(
                    top: 40.h,
                    left: 20.w,
                    right: 20.w,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        // Left buttons: Share & Bookmark
                        Row(
                          children: [
                            _buildCircularButton(Icons.share_outlined, () {}),
                            SizedBox(width: 12.w),
                            _buildCircularButton(Icons.bookmark_border, () {}),
                          ],
                        ),
                        // Right button: Back
                        _buildCircularButton(
                          Icons.arrow_forward,
                          () => Navigator.pop(context),
                        ),
                      ],
                    ),
                  ),

                  // 3. Image Counter
                  Positioned(
                    top: 280.h,
                    right: 20.w,
                    child: Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: 12.w,
                        vertical: 4.h,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.black.withOpacity(0.4),
                        borderRadius: BorderRadius.circular(20.r),
                      ),
                      child: Text(
                        "1/${tour.images?.length ?? 1}",
                        style: TextStyle(color: Colors.white, fontSize: 12.sp),
                      ),
                    ),
                  ),

                  // 4. Overlapping Content Card
                  SingleChildScrollView(
                    child: Column(
                      children: [
                        SizedBox(height: 310.h),
                        Container(
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
                              if (tour.includes != null &&
                                  tour.includes!.isNotEmpty)
                                TourInclusionsGrid(includes: tour.includes!),

                              // Map Section
                              Text(
                                "الموقع",
                                style: AppTextStyle.setelMessiriBlack(
                                  fontSize: 18,
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
                                  errorBuilder: (context, error, stackTrace) =>
                                      Container(
                                        height: 180.h,
                                        width: double.infinity,
                                        color: Colors.grey[100],
                                        child: Icon(
                                          Icons.map_outlined,
                                          color: Colors.grey,
                                          size: 40.sp,
                                        ),
                                      ),
                                ),
                              ),
                              SizedBox(height: 8.h),
                              Center(
                                child: InkWell(
                                  onTap: () {},
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Icon(
                                        Icons.map_outlined,
                                        color: Colors.grey[600],
                                        size: 18.sp,
                                      ),
                                      SizedBox(width: 8.w),
                                      Text(
                                        "اكتشف طريقك بسهولة",
                                        style: TextStyle(
                                          color: Colors.grey[600],
                                          fontSize: 14.sp,
                                          fontFamily: 'ElMessiri',
                                          decoration: TextDecoration.underline,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),

                              SizedBox(height: 32.h),

                              // Packages Section
                              if (tour.productOptions != null &&
                                  tour.productOptions!.isNotEmpty)
                                TourPremiumOptions(
                                  options: tour.productOptions!,
                                ),

                              SizedBox(height: 120.h), // Space for bottom bar
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),

                  // 5. Sticky Bottom Booking Bar
                  Positioned(
                    bottom: 0,
                    left: 0,
                    right: 0,
                    child: TourBookingBottomBar(
                      price: tour.price?.amount?.toStringAsFixed(0),
                      oldPrice: ((tour.price?.amount ?? 0) * 1.4)
                          .toStringAsFixed(0),
                      onQuickBookTap: () {},
                      onCheckAvailabilityTap: () {},
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

  Widget _buildCircularButton(IconData icon, VoidCallback onTap) {
    return InkWell(
      onTap: onTap,
      child: Container(
        width: 40.h,
        height: 40.h,
        decoration: BoxDecoration(
          color: Colors.black.withOpacity(0.3),
          shape: BoxShape.circle,
        ),
        child: Icon(icon, color: Colors.white, size: 20.sp),
      ),
    );
  }
}
