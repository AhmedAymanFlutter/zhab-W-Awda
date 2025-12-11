import 'package:flutter/material.dart';
import 'package:flutter_application_1/featuer/home/view/package/view/package_card.dart';
import 'package:flutter_application_1/featuer/packageType/manager/package_types_cubit.dart';
import 'package:flutter_application_1/featuer/packageType/manager/package_types_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/theme/app_color.dart';
import '../data/repo/package_types_repository.dart';

class PackagesInCountryView extends StatelessWidget {
  final String packageTypeSlug;
  final String countrySlug;
  final String countryName;

  const PackagesInCountryView({
    super.key,
    required this.packageTypeSlug,
    required this.countrySlug,
    required this.countryName,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => PackageTypesCubit(PackageTypesRepository())
        ..fetchPackagesInCountry(
          packageTypeSlug: packageTypeSlug,
          countrySlug: countrySlug,
        ),
      child: Scaffold(
        backgroundColor: AppColor.primaryWhite,
        appBar: AppBar(
          backgroundColor: AppColor.primaryWhite,
          elevation: 0,
          centerTitle: true,
          title: Text(
            "باقات $countryName",
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
              Expanded(
                child: BlocBuilder<PackageTypesCubit, PackageTypesState>(
                  builder: (context, state) {
                    if (state is PackagesInCountryLoading) {
                      return const Center(child: CircularProgressIndicator());
                    } else if (state is PackagesInCountryError) {
                      return Center(child: Text(state.message));
                    } else if (state is PackagesInCountrySuccess) {
                      return GridView.builder(
                        physics: const BouncingScrollPhysics(),
                        itemCount: state.packages.length,
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          crossAxisSpacing: 12.w,
                          mainAxisSpacing: 12.h,
                          childAspectRatio:
                              0.8, // Adjust to match your Card design
                        ),
                        itemBuilder: (context, index) {
                          // Reusing the PackageCard from Home Feature
                          return PackageCard(package: state.packages[index]);
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
