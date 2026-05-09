import 'package:flutter/material.dart';
import 'package:flutter_application_1/core/widgets/cusstom_search_bar.dart';
import 'package:flutter_application_1/featuer/Cities/manager/cities_cubit.dart';
import 'package:flutter_application_1/featuer/Cities/manager/cities_state.dart';
import 'package:flutter_application_1/featuer/tours/view/widgets/tour_filter_bottom_sheet.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:skeletonizer/skeletonizer.dart';
import '../../../../core/theme/app_color.dart';
import '../../../core/theme/app_text_style.dart';
import '../data/model/get_all_tours_model.dart';
import '../manager/tours_cubit.dart';
import '../manager/tours_state.dart';
import 'widgets/tour_card_v2.dart';
import 'widgets/tours_pagination_widget.dart';

class ToursView extends StatelessWidget {
  const ToursView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.primaryWhite,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w),
          child: Column(
            children: [
              SizedBox(height: 16.h),

              // --- SEARCH & FILTER BAR ---
              Builder(
                builder: (context) {
                  final toursCubit = ToursCubit.get(context);
                  final citiesCubit = BlocProvider.of<CitiesCubit>(context);
                  
                  return Column(
                    children: [
                      ReusableSearchBar(
                        hintText: "ابحث عن الجولات (مثلاً: القاهرة...)",
                        useDebounce: true,
                        onFilterTap: () {
                          showModalBottomSheet(
                            context: context,
                            isScrollControlled: true,
                            backgroundColor: Colors.transparent,
                            builder: (_) => BlocProvider.value(
                              value: toursCubit,
                              child: BlocProvider.value(
                                value: citiesCubit,
                                child: BlocBuilder<CitiesCubit, CitiesState>(
                                  builder: (context, state) {
                                    final cities = citiesCubit.cities;
                                    return BlocBuilder<ToursCubit, ToursState>(
                                      builder: (context, state) {
                                        return TourFilterBottomSheet(
                                          cities: cities,
                                          onApply: (cityId, priceRange) {
                                            toursCubit.fetchTours(
                                              cityId: cityId,
                                              priceRange: priceRange,
                                            );
                                          },
                                        );
                                      },
                                    );
                                  },
                                ),
                              ),
                            ),
                          );
                        },
                        onSearchChanged: (value) {
                          toursCubit.searchLocalTours(value);
                        },
                      ),
                      SizedBox(height: 12.h),
                      // Modern Horizontal City Filter
                      BlocBuilder<CitiesCubit, CitiesState>(
                        builder: (context, state) {
                          final cities = citiesCubit.cities;
                          if (cities.isEmpty) return const SizedBox();
                          
                          return BlocBuilder<ToursCubit, ToursState>(
                            builder: (context, state) {
                              return SizedBox(
                                height: 40.h,
                                child: ListView.separated(
                                  scrollDirection: Axis.horizontal,
                                  itemCount: cities.length + 1,
                                  separatorBuilder: (_, __) =>
                                      SizedBox(width: 8.w),
                                  itemBuilder: (context, index) {
                                    final isSelected =
                                        (index == 0 &&
                                            toursCubit.selectedCityId == null) ||
                                        (index > 0 &&
                                            toursCubit.selectedCityId ==
                                                cities[index - 1].sId);

                                    return InkWell(
                                      onTap: () {
                                        final cityId = index == 0
                                            ? null
                                            : cities[index - 1].sId;
                                        toursCubit.fetchTours(cityId: cityId);
                                      },
                                      child: Container(
                                        padding: EdgeInsets.symmetric(
                                          horizontal: 16.w,
                                          vertical: 8.h,
                                        ),
                                        decoration: BoxDecoration(
                                          color: isSelected
                                              ? AppColor.primaryBlue
                                              : Colors.grey[100],
                                          borderRadius: BorderRadius.circular(
                                            20.r,
                                          ),
                                        ),
                                        child: Center(
                                          child: Text(
                                            index == 0
                                                ? "الكل"
                                                : cities[index - 1].name ??
                                                      "",
                                            style:
                                                AppTextStyle.setelMessiriTextStyle(
                                                  fontSize: 13,
                                                  fontWeight: isSelected
                                                      ? FontWeight.bold
                                                      : FontWeight.normal,
                                                  color: isSelected
                                                      ? Colors.white
                                                      : Colors.black87,
                                                ),
                                          ),
                                        ),
                                      ),
                                    );
                                  },
                                ),
                              );
                            },
                          );
                        },
                      ),
                    ],
                  );
                },
              ),

              // -----------------------------
              SizedBox(height: 16.h),

              Expanded(
                child: BlocBuilder<ToursCubit, ToursState>(
                  builder: (context, state) {
                    if (state is ToursLoading) {
                      return Skeletonizer(
                        enabled: true,
                        child: GridView.builder(
                          physics: const BouncingScrollPhysics(),
                          itemCount: 4,
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 1,
                                crossAxisSpacing: 12.w,
                                mainAxisSpacing: 12.h,
                                childAspectRatio: 0.82,
                              ),
                          itemBuilder: (context, index) {
                            return TourCardV2(tour: TourItem());
                          },
                        ),
                      );
                    } else if (state is ToursError) {
                      return Center(child: Text(state.message));
                    } else if (state is ToursSuccess) {
                      // Handle empty result
                      if (state.tours.isEmpty) {
                        return Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.search_off,
                                size: 64.sp,
                                color: Colors.grey,
                              ),
                              SizedBox(height: 16.h),
                              const Text("لا توجد جولات تطابق البحث"),
                            ],
                          ),
                        );
                      }

                      return ListView(
                        physics: const BouncingScrollPhysics(),
                        children: [
                          GridView.builder(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemCount: state.tours.length,
                            gridDelegate:
                                SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 1,
                                  crossAxisSpacing: 12.w,
                                  mainAxisSpacing: 12.h,
                                  childAspectRatio: 0.82,
                                ),
                            itemBuilder: (context, index) {
                              return Padding(
                                padding: EdgeInsets.symmetric(vertical: 16.h),
                                child: TourCardV2(tour: state.tours[index]),
                              );
                            },
                          ),
                          if (state.pagination != null)
                            ToursPaginationWidget(
                              pagination: state.pagination!,
                              onPageChanged: (page) {
                                ToursCubit.get(context).fetchTours(page: page);
                              },
                            ),
                          SizedBox(height: 30.h),
                        ],
                      );
                    }
                    return const SizedBox();
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
