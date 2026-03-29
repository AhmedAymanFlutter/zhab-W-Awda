import 'package:flutter/material.dart';
import 'package:flutter_application_1/core/widgets/cusstom_search_bar.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:skeletonizer/skeletonizer.dart';
import '../../../../core/theme/app_color.dart';
import '../data/model/get_all_tours_model.dart';
import '../data/repo/tours_repository.dart';
import '../manager/tours_cubit.dart';
import '../manager/tours_state.dart';
import 'widgets/tour_card_v2.dart';

class ToursView extends StatelessWidget {
  const ToursView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ToursCubit(ToursRepository())..fetchTours(),
      child: Scaffold(
        backgroundColor: AppColor.primaryWhite,
        body: SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.w),
            child: Column(
              children: [
                SizedBox(height: 16.h),

                // --- ADDED SEARCH BAR HERE ---
                Builder(
                  builder: (context) {
                    return ReusableSearchBar(
                      hintText: "Search tours (e.g. Cairo, Luxury...)",
                      useDebounce: true,
                      onFilterTap: () {},
                      onSearchChanged: (value) {
                        ToursCubit.get(context).searchLocalTours(value);
                      },
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
                          return const Center(child: Text("No tours found."));
                        }

                        return GridView.builder(
                          physics: const BouncingScrollPhysics(),
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
                              padding: EdgeInsets.all(16.h),
                              child: TourCardV2(tour: state.tours[index]),
                            );
                          },
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
      ),
    );
  }
}
