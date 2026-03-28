import 'package:flutter/material.dart';
import 'package:flutter_application_1/core/router/routes.dart';
import 'package:flutter_application_1/core/theme/app_color.dart';
import 'package:flutter_application_1/featuer/home/view/offer/data/model/get_all_offers_model.dart';
import 'package:flutter_application_1/featuer/home/view/offer/manager/offers_cubit.dart';
import 'package:flutter_application_1/featuer/home/view/offer/manager/offers_state.dart';
import 'package:flutter_application_1/featuer/home/view/package/data/model/get_all_packages_model.dart';
import 'package:flutter_application_1/featuer/home/view/package/manager/packages_cubit.dart';
import 'package:flutter_application_1/featuer/home/view/package/manager/packages_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:skeletonizer/skeletonizer.dart';
import '../../../../core/theme/app_text_style.dart';
import 'package:flutter_application_1/featuer/hotels/manager/hotels_cubit.dart';
import 'package:flutter_application_1/featuer/hotels/manager/hotels_state.dart';

import 'package:flutter_application_1/featuer/countries/manager/countries_cubit.dart';
import 'package:flutter_application_1/featuer/countries/manager/countries_state.dart';
import 'package:flutter_application_1/featuer/countries/data/model/get_countries_model.dart';
import 'package:flutter_application_1/featuer/countries/view/widgets/modern_country_card_v2.dart';

import 'package:flutter_application_1/featuer/home/view/widgets/home_header.dart';
import 'package:flutter_application_1/featuer/home/view/widgets/home_services_section.dart';
import 'package:flutter_application_1/featuer/home/view/widgets/home_cities_section.dart';
import 'package:flutter_application_1/featuer/home/view/widgets/home_reviews_section.dart';
import 'package:flutter_application_1/featuer/home/view/widgets/home_tours_section.dart';
import 'package:flutter_application_1/featuer/layout/logic/layout_cubit.dart';
import 'offer/view/offers_slider.dart';
import 'package/view/modern_featured_package_card.dart';
import 'widgets/recommended_hotel_card.dart';

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
                LayoutCubit.get(context).changeBottomNav(4);
              },
            ),
          ),
          SliverToBoxAdapter(child: SizedBox(height: 32.h)),
          // --- Offers Section ---
          SliverToBoxAdapter(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 32.w),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  InkWell(
                    onTap: () =>
                        Navigator.pushNamed(context, Routes.offersView),
                    child: Text(
                      "عرض الكل",
                      style: TextStyle(
                        decoration: TextDecoration.underline,
                        decorationColor: AppColor.primaryBlue,
                        fontSize: 12.sp,
                        fontWeight: FontWeight.w600,
                        color: AppColor.primaryBlue,
                      ),
                    ),
                  ),
                  Text(
                    "أفضل العروض",
                    style: AppTextStyle.setelMessiriBlack(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),
          ),
          SliverToBoxAdapter(child: SizedBox(height: 16.h)),
          SliverToBoxAdapter(
            child: BlocBuilder<OffersCubit, OffersState>(
              builder: (context, state) {
                if (state is OffersListLoading) {
                  return Skeletonizer(
                    enabled: true,
                    child: OffersSlider(
                      offers: List.generate(
                        3,
                        (index) => OfferItem(
                          name: "عرض مميز ورائع جداً لك",
                          price: "15000",
                          imageCover: "https://via.placeholder.com/300",
                        ),
                      ),
                    ),
                  );
                } else if (state is OffersListError) {
                  return Center(child: Text(state.message));
                } else if (state is OffersListSuccess) {
                  return Skeletonizer(
                    enabled: state.offers.isEmpty,
                    child: OffersSlider(offers: state.offers),
                  );
                }
                return const SizedBox();
              },
            ),
          ),
          SliverToBoxAdapter(child: SizedBox(height: 32.h)),

          // --- 3. Tourist Guide (Countries) ---
          SliverToBoxAdapter(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 32.w),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  InkWell(
                    onTap: () =>
                        Navigator.pushNamed(context, Routes.countriesView),
                    child: Text(
                      "عرض الكل",
                      style: TextStyle(
                        decoration: TextDecoration.underline,
                        decorationColor: AppColor.primaryBlue,
                        fontSize: 12.sp,
                        fontWeight: FontWeight.w600,
                        color: AppColor.primaryBlue,
                      ),
                    ),
                  ),
                  Text(
                    "الدليل السياحي",
                    style: AppTextStyle.setelMessiriBlack(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),
          ),
          SliverToBoxAdapter(child: SizedBox(height: 16.h)),
          SliverToBoxAdapter(
            child: SizedBox(
              height: 350.h,
              child: BlocBuilder<CountriesCubit, CountriesState>(
                builder: (context, state) {
                  if (state is CountriesLoading) {
                    return ListView.separated(
                      padding: EdgeInsets.symmetric(horizontal: 16.w),
                      scrollDirection: Axis.horizontal,
                      itemCount: 4,
                      separatorBuilder: (_, __) => SizedBox(width: 16.w),
                      itemBuilder: (context, index) {
                        return Skeletonizer(
                          enabled: true,
                          child: ModernCountryCardV2(
                            country: CountryItem(
                              name: "اسم الدولة",
                              continent: "القارة",
                              imageCover: "https://via.placeholder.com/246x180",
                            ),
                          ),
                        );
                      },
                    );
                  } else if (state is CountriesSuccess) {
                    if (state.countries.isEmpty) return const SizedBox();
                    return ListView.separated(
                      physics: const BouncingScrollPhysics(),
                      padding: EdgeInsets.symmetric(horizontal: 16.w),
                      scrollDirection: Axis.horizontal,
                      itemCount: state.countries.length,
                      separatorBuilder: (_, __) => SizedBox(width: 16.w),
                      itemBuilder: (context, index) {
                        return ModernCountryCardV2(
                          country: state.countries[index],
                        );
                      },
                    );
                  } else if (state is CountriesError) {
                    return Center(child: Text(state.message));
                  }
                  return const SizedBox();
                },
              ),
            ),
          ),
          SliverToBoxAdapter(child: SizedBox(height: 32.h)),
          const SliverToBoxAdapter(child: HomeToursSection()),
          const SliverToBoxAdapter(child: HomeCitiesSection()),

          SliverToBoxAdapter(child: SizedBox(height: 32.h)),

          // --- 4. Packages Section (Horizontal) ---
          SliverToBoxAdapter(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 32.w),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  InkWell(
                    onTap: () =>
                        Navigator.pushNamed(context, Routes.packagesView),
                    child: Text(
                      "عرض الكل",
                      style: TextStyle(
                        decoration: TextDecoration.underline,
                        decorationColor: AppColor.primaryBlue,
                        fontSize: 12.sp,
                        fontWeight: FontWeight.w600,
                        color: AppColor.primaryBlue,
                      ),
                    ),
                  ),
                  Text(
                    "باقات مميزة",
                    style: AppTextStyle.setelMessiriBlack(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),
          ),
          SliverToBoxAdapter(child: SizedBox(height: 16.h)),
          SliverToBoxAdapter(
            child: SizedBox(
              height: 260.h,
              child: BlocBuilder<PackagesCubit, PackagesState>(
                builder: (context, state) {
                  if (state is PackagesLoading) {
                    return ListView.separated(
                      padding: EdgeInsets.symmetric(horizontal: 16.w),
                      scrollDirection: Axis.horizontal,
                      itemCount: 4,
                      separatorBuilder: (_, __) => SizedBox(width: 16.w),
                      itemBuilder: (context, index) {
                        return Skeletonizer(
                          enabled: true,
                          child: ModernFeaturedPackageCard(
                            package: PackageItem(
                              name: "اسم الباقة السياحية هنا",
                              price: "25000",
                              imageCover: "https://via.placeholder.com/200",
                              header: Header(dayNumber: "5"),
                            ),
                          ),
                        );
                      },
                    );
                  } else if (state is PackagesError) {
                    return Center(child: Text(state.message));
                  } else if (state is PackagesSuccess) {
                    return ListView.separated(
                      physics: const BouncingScrollPhysics(),
                      padding: EdgeInsets.symmetric(horizontal: 16.w),
                      scrollDirection: Axis.horizontal,
                      itemCount: state.packages.length,
                      separatorBuilder: (_, __) => SizedBox(width: 16.w),
                      itemBuilder: (context, index) {
                        return ModernFeaturedPackageCard(
                          package: state.packages[index],
                        );
                      },
                    );
                  }
                  return const SizedBox();
                },
              ),
            ),
          ),

          SliverToBoxAdapter(child: SizedBox(height: 32.h)),

          // --- Recommended Hotels Section ---
          SliverToBoxAdapter(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 32.w),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  InkWell(
                    onTap: () =>
                        Navigator.pushNamed(context, Routes.hotelsView),
                    child: Text(
                      "عرض الكل",
                      style: TextStyle(
                        decoration: TextDecoration.underline,
                        decorationColor: AppColor.primaryBlue,
                        fontSize: 12.sp,
                        fontWeight: FontWeight.w600,
                        color: AppColor.primaryBlue,
                      ),
                    ),
                  ),
                  Text(
                    "فنادق موصى بها",
                    style: AppTextStyle.setelMessiriBlack(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),
          ),
          SliverToBoxAdapter(child: SizedBox(height: 16.h)),
          SliverToBoxAdapter(
            child: SizedBox(
              height: 300.h,
              child: BlocBuilder<HotelsCubit, HotelsState>(
                builder: (context, state) {
                  if (state is HotelsLoading) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (state is HotelsSuccess) {
                    if (state.hotels.isEmpty) {
                      return const Center(child: Text("No hotels available"));
                    }
                    return ListView.separated(
                      physics: const BouncingScrollPhysics(),
                      padding: EdgeInsets.symmetric(horizontal: 16.w),
                      scrollDirection: Axis.horizontal,
                      itemCount: state.hotels.length,
                      separatorBuilder: (_, __) => SizedBox(width: 16.w),
                      itemBuilder: (context, index) {
                        return RecommendedHotelCard(hotel: state.hotels[index]);
                      },
                    );
                  } else if (state is HotelsError) {
                    return Center(child: Text(state.message));
                  }
                  return const SizedBox();
                },
              ),
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
