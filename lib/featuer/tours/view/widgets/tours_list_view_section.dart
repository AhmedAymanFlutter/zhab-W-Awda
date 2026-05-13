import 'package:flutter/material.dart';
import 'package:flutter_application_1/featuer/tours/data/model/get_all_tours_model.dart';
import 'package:flutter_application_1/featuer/tours/manager/tours_cubit.dart';
import 'package:flutter_application_1/featuer/tours/manager/tours_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:skeletonizer/skeletonizer.dart';

import 'tour_card_v2.dart';
import 'tours_pagination_widget.dart';

class ToursListViewSection extends StatelessWidget {
  const ToursListViewSection({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ToursCubit, ToursState>(
      buildWhen: (previous, current) =>
          current is ToursLoading ||
          current is ToursError ||
          current is ToursSuccess,
      builder: (context, state) {
        if (state is ToursLoading) {
          return Skeletonizer(
            enabled: true,
            child: GridView.builder(
              physics: const BouncingScrollPhysics(),
              itemCount: 4,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
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
          if (state.tours.isEmpty) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.search_off, size: 64.sp, color: Colors.grey),
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
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
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
    );
  }
}
