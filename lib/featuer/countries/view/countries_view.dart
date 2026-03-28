import 'package:flutter/material.dart';
import 'package:flutter_application_1/core/widgets/cusstom_search_bar.dart';
import 'package:flutter_application_1/featuer/countries/data/repo/countries_repository.dart';
import 'package:flutter_application_1/featuer/countries/manager/countries_cubit.dart';
import 'package:flutter_application_1/featuer/countries/manager/countries_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/theme/app_color.dart';

import 'widgets/modern_country_card_v2.dart';

class CountriesView extends StatelessWidget {
  const CountriesView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          CountriesCubit(CountriesRepository())..fetchCountries(),
      child: Scaffold(
        backgroundColor: AppColor.primaryWhite,
        appBar: AppBar(
          backgroundColor: AppColor.primaryWhite,
          elevation: 0,
          centerTitle: true,
          title: Text(
            "وجهات السفر",
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
              Builder(
                builder: (context) {
                  return ReusableSearchBar(
                    hintText: "Search countries...",
                    useDebounce: true,
                    onFilterTap: () {},
                    onSearchChanged: (value) {
                      // Now this context works because it is inside the Builder
                      CountriesCubit.get(context).searchLocalCountries(value);
                    },
                  );
                },
              ),
              SizedBox(height: 10.h),
              Expanded(
                child: BlocBuilder<CountriesCubit, CountriesState>(
                  builder: (context, state) {
                    if (state is CountriesLoading) {
                      return const Center(child: CircularProgressIndicator());
                    } else if (state is CountriesError) {
                      return Center(child: Text(state.message));
                    } else if (state is CountriesSuccess) {
                      return GridView.builder(
                        physics: const BouncingScrollPhysics(),
                        itemCount: state.countries.length,
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 1,
                          mainAxisSpacing: 16.h,
                          childAspectRatio: 1.1,
                        ),
                        itemBuilder: (context, index) {
                          return ModernCountryCardV2(country: state.countries[index]);
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
