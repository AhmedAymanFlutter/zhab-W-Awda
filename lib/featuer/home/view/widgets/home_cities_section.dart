import 'package:flutter/material.dart';
import 'package:flutter_application_1/featuer/Cities/data/model/getcitiesModel.dart';
import 'package:flutter_application_1/featuer/Cities/manager/cities_cubit.dart';
import 'package:flutter_application_1/featuer/Cities/manager/cities_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'home_cities_header.dart';
import 'home_cities_grid.dart';
import 'home_cities_view_all_button.dart';

class HomeCitiesSection extends StatelessWidget {
  const HomeCitiesSection({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CitiesCubit, CitiesState>(
      builder: (context, state) {
        final isLoading = state is CitiesLoading;
        final List<CityItem> cities = (state is CitiesSuccess) 
            ? state.cities.take(5).toList() 
            : List.generate(5, (_) => CityItem(name: "المدينة", imageCover: ""));

        if (state is CitiesError) return const SizedBox.shrink();
        if (state is CitiesSuccess && state.cities.isEmpty) return const SizedBox.shrink();

        return Skeletonizer(
          enabled: isLoading,
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 32.h),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const HomeCitiesHeader(),
                SizedBox(height: 24.h),
                HomeCitiesGrid(cities: cities),
                SizedBox(height: 20.h),
                const HomeCitiesViewAllButton(),
              ],
            ),
          ),
        );
      },
    );
  }
}
