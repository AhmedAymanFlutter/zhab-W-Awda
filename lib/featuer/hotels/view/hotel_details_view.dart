import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/core/widgets/offer_booking_bar.dart';
import 'package:flutter_application_1/featuer/hotels/manager/hotels_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../../../../core/theme/app_color.dart';
import '../data/repo/hotels_repository.dart';

import '../manager/hotels_cubit.dart';

class HotelDetailsView extends StatelessWidget {
  final String hotelId;

  const HotelDetailsView({super.key, required this.hotelId});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      // 1. إنشاء الكيوبت واستدعاء دالة التفاصيل
      create: (context) =>
          HotelsCubit(HotelsRepository())..getHotelDetails(hotelId),
      child: Scaffold(
        backgroundColor: Colors.white,
        // 2. زر الحجز العائم في الأسفل
        bottomNavigationBar: OfferBookingBar(),
        body: BlocBuilder<HotelsCubit, HotelsState>(
          buildWhen: (previous, current) =>
              current is HotelDetailsLoading ||
              current is HotelDetailsSuccess ||
              current is HotelDetailsError,
          builder: (context, state) {
            if (state is HotelDetailsLoading) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is HotelDetailsError) {
              return Center(child: Text(state.message));
            } else if (state is HotelDetailsSuccess) {
              final hotel = state.hotel;

              return CustomScrollView(
                slivers: [
                  // --- 3. AppBar مع الصورة والتدرج اللوني ---
                  SliverAppBar(
                    expandedHeight: 500.h,
                    pinned: true,
                    stretch: true,
                    backgroundColor: Colors.transparent,
                    leading: Padding(
                      padding: EdgeInsets.only(left: 16.w),
                      child: Container(
                        margin: EdgeInsets.all(8.w),
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.3),
                          shape: BoxShape.circle,
                        ),
                        child: IconButton(
                          icon: const Icon(
                            Icons.arrow_back,
                            color: Colors.white,
                          ),
                          onPressed: () => Navigator.pop(context),
                        ),
                      ),
                    ),
                    flexibleSpace: FlexibleSpaceBar(
                      stretchModes: const [
                        StretchMode.zoomBackground,
                        StretchMode.blurBackground,
                      ],
                      background: Padding(
                        padding: EdgeInsets.only(
                          left: 12.w,
                          top: 20.h,
                          right: 12.w,
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.all(Radius.circular(20.r)),
                          child: Stack(
                            fit: StackFit.expand,
                            children: [
                              // الصورة
                              CachedNetworkImage(
                                imageUrl:
                                    hotel.imageCover ??
                                    "https://via.placeholder.com/300",
                                fit: BoxFit.cover,
                                placeholder: (context, url) => const Center(
                                  child: Icon(FontAwesomeIcons.image),
                                ),
                                errorWidget: (context, url, error) =>
                                    Icon(FontAwesomeIcons.image),
                              ),
                              // طبقة التدرج اللوني (لجعل الكتابة واضحة)
                              Container(
                                decoration: BoxDecoration(
                                  gradient: LinearGradient(
                                    begin: Alignment.topCenter,
                                    end: Alignment.bottomCenter,
                                    colors: [
                                      Colors.transparent,
                                      Colors.black.withOpacity(0.7),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),

                  // --- 4. محتوى التفاصيل ---
                  SliverToBoxAdapter(
                    child: Container(
                      // سحب الكونتينر للأعلى قليلاً فوق الصورة
                      transform: Matrix4.translationValues(0, -20, 0),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(30.r),
                          topRight: Radius.circular(30.r),
                        ),
                      ),
                      child: Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: 20.w,
                          vertical: 25.h,
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // الاسم والتقييم
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Expanded(
                                  child: Text(
                                    hotel.name ?? "اسم الفندق",
                                    style: TextStyle(
                                      fontSize: 20.sp,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black87,
                                    ),
                                  ),
                                ),
                                if (hotel.rating != null)
                                  Container(
                                    padding: EdgeInsets.symmetric(
                                      horizontal: 8.w,
                                      vertical: 4.h,
                                    ),
                                    decoration: BoxDecoration(
                                      color: Colors.amber.withOpacity(0.2),
                                      borderRadius: BorderRadius.circular(8.r),
                                    ),
                                    child: Row(
                                      children: [
                                        Icon(
                                          Icons.star,
                                          color: Colors.amber,
                                          size: 16.sp,
                                        ),
                                        SizedBox(width: 4.w),
                                        Text(
                                          hotel.rating!,
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            color: Colors.amber[800],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                              ],
                            ),

                            SizedBox(height: 8.h),

                            // السعر
                            if (hotel.price?.min != null)
                              Row(
                                children: [
                                  Text(
                                    "يبدأ من ",
                                    style: TextStyle(
                                      fontSize: 14.sp,
                                      color: Colors.grey,
                                    ),
                                  ),
                                  Text(
                                    "${hotel.price!.min} ج.م",
                                    style: TextStyle(
                                      fontSize: 22.sp,
                                      fontWeight: FontWeight.bold,
                                      color: AppColor.primaryBlue,
                                    ),
                                  ),
                                  Text(
                                    " / ليلة",
                                    style: TextStyle(
                                      fontSize: 12.sp,
                                      color: Colors.grey,
                                    ),
                                  ),
                                ],
                              ),

                            SizedBox(height: 25.h),
                            Divider(color: Colors.grey.withOpacity(0.2)),
                            SizedBox(height: 15.h),

                            // عنوان الوصف
                            Text(
                              "عن الفندق",
                              style: TextStyle(
                                fontSize: 18.sp,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(height: 10.h),

                            // نص الوصف
                            Text(
                              hotel.description ??
                                  hotel.descText ??
                                  "لا يوجد وصف متاح لهذا الفندق.",
                              style: TextStyle(
                                fontSize: 14.sp,
                                color: Colors.grey[600],
                                height: 1.6,
                              ),
                            ),
                            SizedBox(height: 80.h), // مساحة إضافية في الأسفل
                          ],
                        ),
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
