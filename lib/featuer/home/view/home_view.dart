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
import 'package:flutter_application_1/featuer/reviews/data/review_data.dart';
import 'package:flutter_application_1/featuer/reviews/view/widgets/reviews_slider.dart';
import 'offer/view/offers_slider.dart';
import 'package/view/package_card.dart';
import 'widgets/recommended_hotel_card.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FA),
      body: SafeArea(
        child: CustomScrollView(
          physics: const BouncingScrollPhysics(),
          slivers: [
            SliverToBoxAdapter(child: SizedBox(height: 40.h)),
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
                            child: PackageCard(
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
                          return PackageCard(package: state.packages[index]);
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
                          return RecommendedHotelCard(
                            hotel: state.hotels[index],
                          );
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

            SliverToBoxAdapter(child: SizedBox(height: 32.h)),

            // --- Reviews Section ---
            SliverToBoxAdapter(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 32.w),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    InkWell(
                      onTap: () =>
                          Navigator.pushNamed(context, Routes.reviewsView),
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
                      "آراء العملاء",
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
            SliverToBoxAdapter(child: ReviewsSlider(reviews: getReviews())),

            SliverToBoxAdapter(child: SizedBox(height: 32.h)),

            // --- Spacing at bottom ---
            SliverToBoxAdapter(child: SizedBox(height: 100.h)),
          ],
        ),
      ),
    );
  }
}
