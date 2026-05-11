import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../data/repo/tours_repository.dart';
import 'widgets/tour_header_banner.dart';
import 'widgets/tour_details_content_section.dart';
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

              return Stack(
                children: [
                  // 1. Full-width Banner Image & Navigation
                  TourHeaderBanner(tour: tour),

                  // 2. Overlapping Content Card
                  SingleChildScrollView(
                    child: Column(
                      children: [
                        SizedBox(height: 310.h),
                        TourDetailsContentSection(tour: tour),
                      ],
                    ),
                  ),

                  // 3. Sticky Bottom Booking Bar
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
}
