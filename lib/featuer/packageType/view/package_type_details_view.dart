import 'package:flutter/material.dart';
import 'package:flutter_application_1/core/router/routes.dart';
import 'package:flutter_application_1/featuer/packageType/data/repo/package_types_repository.dart';
import 'package:flutter_application_1/featuer/packageType/manager/package_types_cubit.dart';
import 'package:flutter_application_1/featuer/packageType/manager/package_types_state.dart';
import 'package:flutter_application_1/featuer/packageType/view/widgets/gradient_image_container.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/theme/app_color.dart';

class PackageTypeDetailsView extends StatelessWidget {
  final String slug;
  final String title; // Pass title to show in AppBar

  const PackageTypeDetailsView({
    super.key,
    required this.slug,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          PackageTypesCubit(PackageTypesRepository())
            ..fetchCountriesByType(slug),
      child: Scaffold(
        backgroundColor: AppColor.primaryWhite,
        appBar: AppBar(
          backgroundColor: AppColor.primaryWhite,
          elevation: 0,
          centerTitle: true,
          title: Text(
            title,
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
        body: BlocBuilder<PackageTypesCubit, PackageTypesState>(
          builder: (context, state) {
            if (state is PackageTypeCountriesLoading) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is PackageTypeCountriesError) {
              return Center(child: Text(state.message));
            } else if (state is PackageTypeCountriesSuccess) {
              return ListView.separated(
                padding: EdgeInsets.all(16.w),
                itemCount: state.countries.length,
                separatorBuilder: (context, index) => SizedBox(height: 16.h),
                itemBuilder: (context, index) {
                  final country = state.countries[index];
                  return _buildCountryCard(context, country);
                },
              );
            }
            return const SizedBox();
          },
        ),
      ),
    );
  }

  Widget _buildCountryCard(BuildContext context, dynamic country) {
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(
          context,
          Routes.packagesInCountryView,
          arguments: {
            'packageTypeSlug': slug,
            'countrySlug': country.slug,
            'countryName': country.name,
          },
        );
      },
      child: Container(
        height: 180.h,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16.r),
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 5,
              offset: const Offset(0, 5),
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(16.r),
          child: Stack(
            children: [
              // Reusing your GradientImageContainer
              GradientImageContainer(
                imageUrl: country.imageCover,
                width: double.infinity,
                height: double.infinity,
              ),

              // Text Overlay
              Align(
                alignment: Alignment.bottomRight,
                child: Padding(
                  padding: EdgeInsets.all(16.w),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        country.name ?? "اسم الوجهة",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18.sp,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
