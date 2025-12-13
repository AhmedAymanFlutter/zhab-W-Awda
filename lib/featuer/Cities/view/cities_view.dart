import 'package:flutter/material.dart';
import 'package:flutter_application_1/core/widgets/cusstom_search_bar.dart';
import 'package:flutter_application_1/featuer/Cities/data/repo/cities_repo.dart';
import 'package:flutter_application_1/featuer/Cities/manager/cities_cubit.dart';
import 'package:flutter_application_1/featuer/Cities/manager/cities_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/theme/app_color.dart';

import 'widgets/city_card.dart';

class CitiesView extends StatelessWidget {
  const CitiesView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => CitiesCubit(CitiesRepository())..fetchCities(),
      child: Scaffold(
        backgroundColor: AppColor.primaryWhite,
        appBar: AppBar(
          backgroundColor: AppColor.primaryWhite,
          elevation: 0,
          centerTitle: true,
          title: Text(
            "الوجهات السياحية",
            style: TextStyle(
              fontSize: 20.sp,
              fontWeight: FontWeight.bold,
              color: AppColor.primaryBlue,
            ),
          ),
          leading: IconButton(
            icon: const Icon(Icons.arrow_back, color: AppColor.primaryBlue),
            onPressed: () => Navigator.pop(context),
          ),
        ),
        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w),
          child: Column(
            children: [
              SizedBox(height: 10.h),
              Builder(
                builder: (context) {
                  return ReusableSearchBar(
                    hintText: "Search cities (e.g. Cairo, Luxor...)",
                    useDebounce: true,
                    onFilterTap: () {},
                    onSearchChanged: (value) {
                      // Now this context works because it is inside the Builder
                      CitiesCubit.get(context).searchLocalCities(value);
                    },
                  );
                },
              ),
              SizedBox(height: 10.h),
              Expanded(
                child: BlocBuilder<CitiesCubit, CitiesState>(
                  builder: (context, state) {
                    if (state is CitiesLoading) {
                      return const Center(child: CircularProgressIndicator());
                    } else if (state is CitiesError) {
                      return Center(child: Text(state.message));
                    } else if (state is CitiesSuccess) {
                      return GridView.builder(
                        physics: const BouncingScrollPhysics(),
                        itemCount: state.cities.length,
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          crossAxisSpacing: 12.w,
                          mainAxisSpacing: 12.h,
                          childAspectRatio: 0.9, // Adjust height
                        ),
                        itemBuilder: (context, index) {
                          return CityCard(city: state.cities[index]);
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
