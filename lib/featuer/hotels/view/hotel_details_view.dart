import 'package:flutter/material.dart';
import 'package:flutter_application_1/core/widgets/offer_booking_bar.dart';
import 'package:flutter_application_1/featuer/hotels/manager/hotels_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../data/repo/hotels_repository.dart';
import '../manager/hotels_cubit.dart';
import 'widget/hotel_description.dart';
import 'widget/hotel_info_section.dart';
import 'widget/hotel_location_section.dart';
import 'widget/hotel_title_section.dart';
import 'widget/premium_gallery_header.dart';
import 'widget/related_hotels_list.dart';

class HotelDetailsView extends StatelessWidget {
  final String hotelId;

  const HotelDetailsView({super.key, required this.hotelId});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          HotelsCubit(HotelsRepository())..getHotelDetails(hotelId),
      child: Scaffold(
        backgroundColor: Colors.white,
        body: BlocBuilder<HotelsCubit, HotelsState>(
          builder: (context, state) {
            if (state is HotelDetailsLoading) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is HotelDetailsError) {
              return Center(child: Text(state.message));
            } else if (state is HotelDetailsSuccess) {
              final hotel = state.hotel;

              return Stack(
                children: [
                  CustomScrollView(
                    slivers: [
                      // --- Premium Gallery Header ---
                      PremiumGalleryHeader(
                        image: hotel.imageCover,
                        images: hotel.images,
                      ),

                      // --- Body Content ---
                      SliverToBoxAdapter(
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.vertical(
                              top: Radius.circular(30.r),
                            ),
                          ),
                          // Pull up to overlap the image slightly
                          transform: Matrix4.translationValues(0, -20, 0),
                          padding: EdgeInsets.symmetric(horizontal: 20.w),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(height: 30.h),

                              // Hotel Title & Location
                              HotelTitleSection(
                                name: hotel.name,
                                city: hotel.city,
                                country: hotel.country,
                              ),
                              SizedBox(height: 20.h),

                              // Rating & Reviews Row
                              HotelInfoSection(
                                ratingAverage: hotel.ratingAverage,
                                rating: hotel.rating,
                                numberOfReviews: hotel.numberOfReviews,
                                checkIn: hotel.checkIn,
                              ),
                              SizedBox(height: 24.h),

                              // Description
                              HotelDescription(description: hotel.description),
                              SizedBox(height: 24.h),

                              // Map Section
                              HotelLocationSection(
                                latitude: hotel.latitude,
                                longitude: hotel.longitude,
                                address: hotel.addressline1,
                              ),

                              SizedBox(height: 24.h),

                              // Related Hotels
                              RelatedHotelsList(
                                relatedHotels: state.relatedHotels,
                              ),

                              SizedBox(height: 100.h), // Bottom padding
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),

                  // Bottom Bar
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: OfferBookingBar(
                      price: hotel.price != null ? "\$${hotel.price}" : null,
                      offerName: hotel.name,
                      targetPhoneNumber: hotel.phone,
                      bookingUrl: hotel.url,
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
