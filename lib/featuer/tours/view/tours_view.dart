import 'package:flutter/material.dart';
import 'package:flutter_application_1/featuer/tours/data/model/get_all_tours_model.dart';
import 'package:flutter_application_1/featuer/tours/data/repo/tours_repository.dart';
import 'package:flutter_application_1/featuer/tours/manager/tours_cubit.dart';
import 'package:flutter_application_1/featuer/tours/manager/tours_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:skeletonizer/skeletonizer.dart';
import '../../../../core/theme/app_color.dart';
import 'widgets/tour_card.dart';

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
                                  crossAxisCount: 2,
                                  crossAxisSpacing: 12.w,
                                  mainAxisSpacing: 12.h,
                                  childAspectRatio: 0.8,
                                ),
                            itemBuilder: (context, index) {
                              return TourCard(tour: TourItem());
                            },
                          ),
                        );
                      } else if (state is ToursError) {
                        return Center(child: Text(state.message));
                      } else if (state is ToursSuccess) {
                        return GridView.builder(
                          physics: const BouncingScrollPhysics(),
                          itemCount: state.tours.length,
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 2,
                                crossAxisSpacing: 12.w,
                                mainAxisSpacing: 12.h,
                                childAspectRatio: 0.8,
                              ),
                          itemBuilder: (context, index) {
                            return TourCard(tour: state.tours[index]);
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
