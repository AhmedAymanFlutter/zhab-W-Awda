import 'package:flutter/material.dart';
import 'package:flutter_application_1/featuer/tours/data/model/get_all_tours_model.dart';
import 'package:flutter_application_1/featuer/tours/manager/tours_cubit.dart';
import 'package:flutter_application_1/featuer/tours/manager/tours_state.dart';
import 'package:flutter_application_1/featuer/tours/view/widgets/tour_card_v2.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:skeletonizer/skeletonizer.dart';
import '../../../../core/theme/app_color.dart';
import '../../../../core/widgets/main_app_header.dart';

import '../../../../core/widgets/cusstom_search_bar.dart';

class SavedToursView extends StatefulWidget {
  const SavedToursView({super.key});

  @override
  State<SavedToursView> createState() => _SavedToursViewState();
}

class _SavedToursViewState extends State<SavedToursView> {
  @override
  void initState() {
    super.initState();
    context.read<ToursCubit>().fetchSavedTours();
  }

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
              const MainAppHeader(title: "الجولات المحفوظة"),
              SizedBox(height: 16.h),
              ReusableSearchBar(
                hintText: "ابحث في جولاتك المحفوظة...",
                onSearchChanged: (value) {
                  context.read<ToursCubit>().fetchSavedTours(query: value);
                },
              ),
              SizedBox(height: 16.h),
              Expanded(
                child: BlocBuilder<ToursCubit, ToursState>(
                  buildWhen: (previous, current) =>
                      current is SavedToursLoading ||
                      current is SavedToursError ||
                      current is SavedToursSuccess,
                  builder: (context, state) {
                    if (state is SavedToursLoading) {
                      return Skeletonizer(
                        enabled: true,
                        child: ListView.builder(
                          itemCount: 3,
                          itemBuilder: (context, index) => Padding(
                            padding: EdgeInsets.symmetric(vertical: 12.h),
                            child: TourCardV2(tour: TourItem()),
                          ),
                        ),
                      );
                    } else if (state is SavedToursError) {
                      return Center(child: Text(state.message));
                    } else if (state is SavedToursSuccess) {
                      if (state.tours.isEmpty) {
                        return Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(Icons.bookmark_border,
                                  size: 64.sp, color: Colors.grey),
                              SizedBox(height: 16.h),
                              const Text("لا توجد جولات محفوظة حالياً"),
                            ],
                          ),
                        );
                      }

                      return ListView.builder(
                        physics: const BouncingScrollPhysics(),
                        itemCount: state.tours.length,
                        itemBuilder: (context, index) {
                          final tour = state.tours[index];
                          return Padding(
                            key: ValueKey(tour.sId ?? tour.id ?? index.toString()),
                            padding: EdgeInsets.symmetric(vertical: 12.h),
                            child: TourCardV2(tour: tour),
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
    );
  }
}
