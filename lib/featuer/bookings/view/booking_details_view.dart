import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/theme/app_text_style.dart';
import '../manager/booking_details_cubit.dart';
import '../manager/booking_details_state.dart';
import 'widgets/details/booking_details_tabs.dart';
import 'widgets/details/booking_points_banner.dart';
import 'widgets/details/booking_overview_info_card.dart';
import 'widgets/details/booking_general_overview.dart';
import 'widgets/details/booking_itinerary_timeline.dart';
import 'widgets/details/booking_inclusions_list.dart';
import 'widgets/details/booking_destinations_list.dart';
import 'widgets/details/booking_hotel_details_section.dart';
import 'widgets/details/booking_flight_details_section.dart';

class BookingDetailsView extends StatefulWidget {
  final String bookingId;

  const BookingDetailsView({super.key, required this.bookingId});

  @override
  State<BookingDetailsView> createState() => _BookingDetailsViewState();
}

class _BookingDetailsViewState extends State<BookingDetailsView> {
  int _activeTabIndex = 0; // 0: Program, 1: Hotels, 2: Flights

  @override
  void initState() {
    super.initState();
    context.read<BookingDetailsCubit>().fetchBookingDetails(widget.bookingId);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF2F4F7),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          "تفاصيل الرحلة",
          style: AppTextStyle.setelMessiriBlack(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: BlocBuilder<BookingDetailsCubit, BookingDetailsState>(
        builder: (context, state) {
          if (state is BookingDetailsLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is BookingDetailsSuccess) {
            final booking = state.booking;
            return Column(
              children: [
                BookingDetailsTabs(
                  activeIndex: _activeTabIndex,
                  onTabChanged: (index) {
                    setState(() {
                      _activeTabIndex = index;
                    });
                  },
                ),
                Expanded(
                  child: SingleChildScrollView(
                    physics: const BouncingScrollPhysics(),
                    padding: EdgeInsets.symmetric(horizontal: 16.w),
                    child: Column(
                      children: [
                        SizedBox(height: 16.h),
                        // 1. Points Banner
                        if (booking.pointsEarned != null)
                          BookingPointsBanner(points: booking.pointsEarned!),
                        
                        SizedBox(height: 16.h),
                        
                        // 2. Trip Overview Card
                        BookingOverviewInfoCard(booking: booking),

                        SizedBox(height: 16.h),

                        // Render content based on tab
                        if (_activeTabIndex == 0) ...[
                          // 3. General Overview
                          BookingGeneralOverview(
                            description: booking.package?.packageType?.name ?? "",
                            fullDescription: "استمتعوا بتجربة شهر عسل رومانسية لا تُنسى في أجمل مدن إيطاليا...", // Placeholder or from package if available
                          ),

                          SizedBox(height: 16.h),

                          // 4. Itinerary Timeline
                          if (booking.package?.days != null)
                            BookingItineraryTimeline(days: booking.package!.days!),

                          SizedBox(height: 16.h),

                          // 5. Inclusions / Exclusions
                          BookingInclusionsList(
                            includes: booking.package?.includes ?? [],
                            excludes: booking.package?.excludes ?? [],
                          ),

                          SizedBox(height: 16.h),

                          // 6. Destinations
                          if (booking.package?.cities != null)
                            BookingDestinationsList(cities: booking.package!.cities!),

                          SizedBox(height: 24.h),
                        ] else if (_activeTabIndex == 1) ...[
                          if (booking.hotel != null)
                            BookingHotelDetailsSection(hotel: booking.hotel!)
                          else
                            const Center(child: Text("لا توجد تفاصيل فندق لهذا الحجز")),
                          SizedBox(height: 20.h),
                        ] else ...[
                          if (booking.flight != null)
                            BookingFlightDetailsSection(flight: booking.flight!)
                          else
                            const Center(child: Text("لا توجد تفاصيل طيران لهذا الحجز")),
                          SizedBox(height: 20.h),
                        ],
                      ],
                    ),
                  ),
                ),
              ],
            );
          } else if (state is BookingDetailsError) {
            return Center(child: Text(state.message));
          }
          return const SizedBox();
        },
      ),
    );
  }
}
