import 'package:flutter/material.dart';
import 'package:flutter_application_1/featuer/tours/manager/tours_cubit.dart';
import 'package:flutter_application_1/featuer/tours/manager/tours_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/theme/app_color.dart';
import '../../../../core/theme/app_text_style.dart';
import '../../../../core/widgets/cusstom_search_bar.dart';
import '../../../Cities/manager/cities_cubit.dart';
import '../../../Cities/manager/cities_state.dart';
import 'tour_filter_bottom_sheet.dart';

class ToursHeaderSection extends StatelessWidget {
  const ToursHeaderSection({super.key});

  @override
  Widget build(BuildContext context) {
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
              builder: (_) => MultiBlocProvider(
                providers: [
                  BlocProvider.value(value: toursCubit),
                  BlocProvider.value(value: citiesCubit),
                ],
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
                    separatorBuilder: (_, __) => SizedBox(width: 8.w),
                    itemBuilder: (context, index) {
                      final isSelected =
                          (index == 0 && toursCubit.selectedCityId == null) ||
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
                            borderRadius: BorderRadius.circular(20.r),
                          ),
                          child: Center(
                            child: Text(
                              index == 0
                                  ? "الكل"
                                  : cities[index - 1].name ?? "",
                              style: AppTextStyle.setelMessiriTextStyle(
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
  }
}
