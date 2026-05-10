import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
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
                    // 1. Full-width Background Image Banner
                    Positioned(
                      top: 0,
                      left: 0,
                      right: 0,
                      height: 320.h,
                      child: Stack(
                        fit: StackFit.expand,
                        children: [
                          (hotel.images != null && hotel.images!.isNotEmpty)
                              ? CachedNetworkImage(
                                  imageUrl: hotel.images!.last,
                                  fit: BoxFit.cover,
                                  placeholder: (context, url) => Container(color: Colors.grey[200]),
                                  errorWidget: (context, url, error) => const Center(child: Icon(Icons.error)),
                                )
                              : Container(color: Colors.grey[300]),
                          // Gradient to make top buttons visible
                          Container(
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                begin: Alignment.topCenter,
                                end: Alignment.bottomCenter,
                                colors: [
                                  Colors.black.withOpacity(0.5),
                                  Colors.transparent,
                                  Colors.transparent,
                                ],
                                stops: const [0.0, 0.3, 1.0],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),

                    // 2. Scrollable Content
                    CustomScrollView(
                      physics: const BouncingScrollPhysics(),
                      slivers: [
                        // Transparent App Bar for the back button
                        SliverAppBar(
                          backgroundColor: Colors.transparent,
                          elevation: 0,
                          pinned: true,
                          leading: Padding(
                            padding: EdgeInsets.all(8.w),
                            child: CircleAvatar(
                              backgroundColor: Colors.white.withOpacity(0.3),
                              child: const BackButton(color: Colors.white),
                            ),
                          ),
                          actions: [
                            Padding(
                              padding: EdgeInsets.symmetric(horizontal: 16.w),
                              child: CircleAvatar(
                                backgroundColor: Colors.white.withOpacity(0.3),
                                child: IconButton(
                                  icon: const Icon(Icons.share_outlined, color: Colors.white),
                                  onPressed: () {},
                                ),
                              ),
                            ),
                          ],
                        ),

                        // Spacing to push content down
                        SliverToBoxAdapter(
                          child: SizedBox(height: 200.h),
                        ),

                        // Main Content Card
                        SliverToBoxAdapter(
                          child: Container(
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(32.r),
                                topRight: Radius.circular(32.r),
                              ),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.05),
                                  blurRadius: 10,
                                  offset: const Offset(0, -5),
                                ),
                              ],
                            ),
                            padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 24.h),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                // --- Header: Title and Location ---
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            hotel.hotelTranslatedName ?? hotel.hotelName ?? "",
                                            style: AppTextStyle.setelMessiriBlack(
                                              fontSize: 22.sp,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                          SizedBox(height: 8.h),
                                          Row(
                                            children: [
                                              Icon(Icons.star, color: Colors.amber, size: 18.sp),
                                              SizedBox(width: 4.w),
                                              Text(
                                                "${hotel.ratingAverage ?? 0} (${hotel.starRating} نجوم)",
                                                style: TextStyle(
                                                  fontSize: 14.sp,
                                                  color: Colors.grey[600],
                                                  fontFamily: 'ElMessiri',
                                                ),
                                              ),
                                            ],
                                          ),
                                          SizedBox(height: 6.h),
                                          Row(
                                            children: [
                                              Icon(Icons.location_on_outlined, size: 16.sp, color: Colors.grey),
                                              SizedBox(width: 4.w),
                                              Text(
                                                "${hotel.city?.name}, ${hotel.country?.name}",
                                                style: TextStyle(
                                                  fontSize: 14.sp,
                                                  color: Colors.grey[600],
                                                  fontFamily: 'ElMessiri',
                                                ),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),

                                SizedBox(height: 24.h),
                                // Gallery
                                HotelGallerySection(images: hotel.images),
                                SizedBox(height: 32.h),

                                // Overview
                                Text(
                                  "نظرة عامة للفندق",
                                  style: AppTextStyle.setelMessiriBlack(
                                    fontSize: 18.sp,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                SizedBox(height: 12.h),
                                Text(
                                  hotel.overview ?? hotel.description ?? "",
                                  style: TextStyle(
                                    fontSize: 14.sp,
                                    color: Colors.grey[700],
                                    height: 1.6,
                                    fontFamily: 'ElMessiri',
                                  ),
                                ),
                                SizedBox(height: 32.h),

                                // Amenities
                                HotelAmenitiesSection(amenities: hotel.includes),
                                SizedBox(height: 32.h),

                                // Rooms
                                HotelRoomsSection(rooms: hotel.rooms),
                                SizedBox(height: 32.h),

                                // Location
                                Text(
                                  "الموقع الجغرافي",
                                  style: AppTextStyle.setelMessiriBlack(
                                    fontSize: 18.sp,
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
                                HotelPoliciesSection(policies: hotel.policies),
                                
                                SizedBox(height: 32.h),
                                // Similar Hotels
                                HotelSimilarHotelsSection(
                                  similarHotels: state.hotelDetails.similarHotels,
                                ),
                                SizedBox(height: 120.h),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),

                    // 3. Sticky Bottom Booking Bar
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
