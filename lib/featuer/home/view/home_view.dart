import 'package:flutter/material.dart';
import 'package:flutter_application_1/core/theme/app_text_style.dart';
import 'package:flutter_application_1/featuer/home/view/offer/manager/offers_cubit.dart';
import 'package:flutter_application_1/featuer/home/view/offer/manager/offers_state.dart';
import 'package:flutter_application_1/featuer/home/view/package/data/model/get_all_packages_model.dart';
import 'package:flutter_application_1/featuer/home/view/package/manager/packages_cubit.dart';
import 'package:flutter_application_1/featuer/home/view/package/manager/packages_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:skeletonizer/skeletonizer.dart';
import '../../../../core/theme/app_color.dart';
import 'offer/view/offers_slider.dart';
import 'widgets/section_header.dart';
import 'package/view/package_card.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.primaryWhite,
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          children: [
            SizedBox(height: 10.h),

            SectionHeader(
              title: "العروض",
              onShowMoreTap: () {
                // Navigate to all offers
              },
            ),
            BlocBuilder<OffersCubit, OffersState>(
              builder: (context, state) {
                if (state is OffersListLoading) {
                  return Skeletonizer(
                    enabled: true,
                    child: SizedBox(
                      height: 190.h,
                      child: OffersSlider(offers: []), // هنا dummy data
                    ),
                  );
                } else if (state is OffersListError) {
                  return SizedBox(
                    height: 160.h,
                    child: Center(child: Text(state.message)),
                  );
                } else if (state is OffersListSuccess) {
                  return Skeletonizer(
                    enabled: state.offers.isEmpty,
                    child: OffersSlider(offers: state.offers),
                  );
                }
                return const SizedBox(); // Initial State
              },
            ),
            SizedBox(height: 24.h),

            Container(
              margin: EdgeInsets.symmetric(horizontal: 16.w),
              height: 70.h,
              width: double.infinity,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16.r),
                color: AppColor.primaryBlue,
                // image: DecorationImage(...)
              ),
              child: Center(
                child: Text(
                  "عروض جديدة",
                  style: AppTextStyle.setelMessiriTextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: AppColor.primaryWhite,
                  ),
                ),
              ),
            ),

            SizedBox(height: 24.h),

            // 4. Packages Section
            SectionHeader(title: "الباقات", onShowMoreTap: () {}),

            // Grid of Packages
            BlocBuilder<PackagesCubit, PackagesState>(
              builder: (context, state) {
                if (state is PackagesLoading) {
                  return Center(
                    child: Skeletonizer(
                      enabled: true,
                      child: SizedBox(
                        height: 200.h,
                        child: GridView.builder(
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 2,
                              ),
                          itemBuilder: (BuildContext context, int index) {
                            return PackageCard(package: PackageItem());
                          },
                        ),
                      ),
                    ),
                  );
                } else if (state is PackagesError) {
                  return Center(child: Text(state.message));
                } else if (state is PackagesSuccess) {
                  return Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16.w),
                    child: GridView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: state.packages.length,
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        crossAxisSpacing: 12.w,
                        mainAxisSpacing: 12.h,
                        childAspectRatio: 0.8,
                      ),
                      itemBuilder: (context, index) {
                        return PackageCard(package: state.packages[index]);
                      },
                    ),
                  );
                }
                return const SizedBox();
              },
            ),

            SizedBox(height: 100.h), // مساحة في الأسفل عشان الـ Bottom Nav
          ],
        ),
      ),
    );
  }
}
