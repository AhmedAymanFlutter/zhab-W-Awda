import 'package:flutter/material.dart';
import 'package:flutter_application_1/core/router/routes.dart';
import 'package:flutter_application_1/core/theme/app_color.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/theme/app_text_style.dart';
import 'package:flutter_application_1/featuer/hotels/manager/hotels_cubit.dart';
import 'package:flutter_application_1/featuer/hotels/manager/hotels_state.dart';
import 'package:flutter_application_1/featuer/home/view/widgets/home_header.dart';
import 'package:flutter_application_1/featuer/home/view/widgets/home_services_section.dart';
import 'package:flutter_application_1/featuer/home/view/widgets/home_cities_section.dart';
import 'package:flutter_application_1/featuer/home/view/widgets/home_reviews_section.dart';
import 'package:flutter_application_1/featuer/home/view/widgets/home_tours_section.dart';
import 'widgets/recommended_hotel_card.dart';
import 'package:flutter_application_1/featuer/home/view/widgets/home_destinations_section.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'package:flutter_application_1/featuer/hotels/data/model/getHotel_model.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FA),
      body: CustomScrollView(
        physics: const BouncingScrollPhysics(),
        slivers: [
          const SliverToBoxAdapter(child: HomeHeader()),
          SliverToBoxAdapter(child: SizedBox(height: 24.h)),
          SliverToBoxAdapter(
            child: HomeServicesSection(
              onViewAllTap: () {
                Navigator.pushNamed(context, Routes.servicesView);
              },
            ),
          ),
          SliverToBoxAdapter(child: SizedBox(height: 32.h)),
          // --- 3. Top Destinations (Countries) ---
          const SliverToBoxAdapter(child: HomeDestinationsSection()),
          SliverToBoxAdapter(child: SizedBox(height: 32.h)),
          const SliverToBoxAdapter(child: HomeToursSection()),
          const SliverToBoxAdapter(child: HomeCitiesSection()),

          SliverToBoxAdapter(child: SizedBox(height: 32.h)),

          // --- Recommended Hotels Section ---
          SliverToBoxAdapter(
            child: Column(
              children: [
                Text(
                  "احجز فندقك الآن",
                  style: AppTextStyle.setelMessiriBlack(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 8.h),
                Text(
                  "استمتع بإقامة مريحة في أفضل الفنادق حول العالم.",
                  style: AppTextStyle.setelMessiriSecondlightGrey(
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                  ).copyWith(color: const Color(0xFF667085)),
                ),
              ],
            ),
          ),
          SliverToBoxAdapter(child: SizedBox(height: 24.h)),
          SliverToBoxAdapter(
            child: BlocBuilder<HotelsCubit, HotelsState>(
              builder: (context, state) {
                if (state is HotelsLoading) {
                  return Skeletonizer(
                    enabled: true,
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 16.w),
                      child: Column(
                        children: [
                          ListView.separated(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemCount: 3,
                            separatorBuilder: (_, __) => SizedBox(height: 16.h),
                            itemBuilder: (context, index) {
                              return RecommendedHotelCard(
                                hotel: HotelItem(
                                  name: "اسم الفندق يظهر هنا",
                                  price: 500,
                                  description: "عنوان الفندق يظهر هنا",
                                  images: [],
                                ),
                              );
                            },
                          ),
                        ],
                      ),
                    ),
                  );
                } else if (state is HotelsSuccess) {
                  if (state.hotels.isEmpty) {
                    return const Center(child: Text("لا توجد فنادق متاحة"));
                  }
                  // We show only a few items (e.g. 3) in the vertical list on Home
                  final displayHotels = state.hotels.take(3).toList();
                  return Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16.w),
                    child: Column(
                      children: [
                        ListView.separated(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: displayHotels.length,
                          separatorBuilder: (_, __) => SizedBox(height: 16.h),
                          itemBuilder: (context, index) {
                            return RecommendedHotelCard(
                              hotel: displayHotels[index],
                            );
                          },
                        ),
                        SizedBox(height: 24.h),
                        GestureDetector(
                          onTap: () =>
                              Navigator.pushNamed(context, Routes.hotelsView),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.arrow_back_ios,
                                size: 14.sp,
                                color: AppColor.primaryBlue,
                              ),
                              SizedBox(width: 8.w),
                              Text(
                                "اكتشف جميع الفنادق",
                                style: AppTextStyle.setelMessiriBlack(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ).copyWith(color: AppColor.primaryBlue),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  );
                } else if (state is HotelsError) {
                  return Center(child: Text(state.message));
                }
                return const SizedBox();
              },
            ),
          ),

          SliverToBoxAdapter(child: SizedBox(height: 16.h)),
          const SliverToBoxAdapter(child: HomeReviewsSection()),
          SliverToBoxAdapter(child: SizedBox(height: 100.h)),
        ],
      ),
    );
  }
}
