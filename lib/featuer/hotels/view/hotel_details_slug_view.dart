import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/theme/app_text_style.dart';
import '../data/repo/hotels_repository.dart';
import '../manager/hotels_cubit.dart';
import '../manager/hotels_state.dart';
import 'widget/hotel_similar_hotels_section.dart';
import 'widget/hotel_amenities_section.dart';
import 'widget/hotel_booking_bottom_bar.dart';
import 'widget/hotel_gallery_section.dart';
import 'widget/hotel_location_section.dart';
import 'widget/hotel_policies_section.dart';
import 'widget/hotel_rooms_section.dart';

class HotelDetailsSlugView extends StatelessWidget {
  final String slug;

  const HotelDetailsSlugView({super.key, required this.slug});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          HotelsCubit(HotelsRepository())..fetchHotelBySlug(slug),
      child: Scaffold(
        backgroundColor: const Color(0xFFF2F4F7),
        body: Directionality(
          textDirection: TextDirection.rtl,
          child: BlocBuilder<HotelsCubit, HotelsState>(
            builder: (context, state) {
              if (state is HotelDetailsLoading) {
                return const Center(child: CircularProgressIndicator());
              } else if (state is HotelDetailsError) {
                return Center(child: Text(state.message));
              } else if (state is HotelSlugDetailsSuccess) {
                final hotel = state.hotelDetails.hotel!;

                return Stack(
                  children: [
                    CustomScrollView(
                      physics: const BouncingScrollPhysics(),
                      slivers: [
                        // Header with back button
                        const SliverAppBar(
                          backgroundColor: Colors.transparent,
                          elevation: 0,
                          leading: BackButton(color: Colors.black),
                        ),

                        SliverToBoxAdapter(
                          child: Padding(
                            padding: EdgeInsets.symmetric(horizontal: 12.w),
                            child: Container(
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(13.r),
                                border: Border.all(
                                  color: const Color(0x121A1A1A),
                                  width: 1,
                                ),
                                boxShadow: const [
                                  BoxShadow(
                                    color: Color(0x0D000000),
                                    blurRadius: 4,
                                    offset: Offset(0, 4),
                                  ),
                                ],
                              ),
                              padding: EdgeInsets.all(16.w),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  // --- Top Section: Title, Rating, and Share ---
                                  Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Expanded(
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              hotel.hotelTranslatedName ??
                                                  hotel.hotelName ??
                                                  "",
                                              style:
                                                  AppTextStyle.setelMessiriBlack(
                                                    fontSize: 20,
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                            ),
                                            SizedBox(height: 8.h),
                                            Row(
                                              children: [
                                                Icon(
                                                  Icons.star,
                                                  color: Colors.amber,
                                                  size: 16.sp,
                                                ),
                                                SizedBox(width: 4.w),
                                                Text(
                                                  "${hotel.ratingAverage ?? 0} (${hotel.starRating} نجوم)",
                                                  style: TextStyle(
                                                    fontSize: 12.sp,
                                                    color: Colors.grey[600],
                                                  ),
                                                ),
                                              ],
                                            ),
                                            SizedBox(height: 4.h),
                                            Row(
                                              children: [
                                                Icon(
                                                  Icons.location_on_outlined,
                                                  size: 14.sp,
                                                  color: Colors.grey,
                                                ),
                                                SizedBox(width: 4.w),
                                                Text(
                                                  "${hotel.city?.name}, ${hotel.country?.name}",
                                                  style: TextStyle(
                                                    fontSize: 12.sp,
                                                    color: Colors.grey[600],
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                      // Share Button
                                      Container(
                                        padding: EdgeInsets.symmetric(
                                          horizontal: 12.w,
                                          vertical: 6.h,
                                        ),
                                        decoration: BoxDecoration(
                                          border: Border.all(
                                            color: Colors.grey[300]!,
                                          ),
                                          borderRadius: BorderRadius.circular(
                                            8.r,
                                          ),
                                        ),
                                        child: Row(
                                          children: [
                                            Icon(
                                              Icons.share_outlined,
                                              size: 16.sp,
                                            ),
                                            SizedBox(width: 4.w),
                                            Text(
                                              "شارك",
                                              style: TextStyle(fontSize: 12.sp),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: 20.h),
                                  // Gallery
                                  HotelGallerySection(images: hotel.images),
                                  SizedBox(height: 24.h),
                                  // Overview / Description
                                  Text(
                                    "نظرة عامة للفندق",
                                    style: AppTextStyle.setelMessiriBlack(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  SizedBox(height: 8.h),
                                  Text(
                                    hotel.overview ?? hotel.description ?? "",
                                    style: TextStyle(
                                      fontSize: 13.sp,
                                      color: Colors.grey[700],
                                      height: 1.6,
                                    ),
                                  ),
                                  SizedBox(height: 24.h),
                                  // Amenities
                                  HotelAmenitiesSection(
                                    amenities: hotel.includes,
                                  ),
                                  SizedBox(height: 32.h),
                                  // Rooms
                                  HotelRoomsSection(rooms: hotel.rooms),
                                  SizedBox(height: 32.h),
                                  // Location
                                  Text(
                                    "الموقع الذي سنقيم فيه",
                                    style: AppTextStyle.setelMessiriBlack(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  SizedBox(height: 16.h),
                                  HotelLocationSection(
                                    latitude: hotel.latitude,
                                    longitude: hotel.longitude,
                                    address: hotel.addressline1,
                                  ),
                                  SizedBox(height: 32.h),
                                  // Policies
                                  HotelPoliciesSection(
                                    policies: hotel.policies,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        SliverToBoxAdapter(
                          child: Column(
                            children: [
                              SizedBox(height: 32.h),
                              Padding(
                                padding: EdgeInsets.symmetric(horizontal: 16.w),
                                child: HotelSimilarHotelsSection(
                                  similarHotels:
                                      state.hotelDetails.similarHotels,
                                ),
                              ),
                              SizedBox(height: 120.h),
                            ],
                          ),
                        ),
                      ],
                    ),
                    // Bottom Bar
                    Align(
                      alignment: Alignment.bottomCenter,
                      child: HotelBookingBottomBar(
                        price: hotel.price?.amount,
                        currency: hotel.price?.currency,
                      ),
                    ),
                  ],
                );
              }
              return const SizedBox();
            },
          ),
        ),
      ),
    );
  }
}
