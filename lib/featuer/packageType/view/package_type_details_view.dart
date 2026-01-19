import 'package:flutter/material.dart';
import 'package:flutter_application_1/core/router/routes.dart';
import 'package:flutter_application_1/featuer/packageType/data/repo/package_types_repository.dart';
import 'package:flutter_application_1/featuer/packageType/manager/package_types_cubit.dart';
import 'package:flutter_application_1/featuer/packageType/manager/package_types_state.dart';
import 'package:flutter_application_1/featuer/packageType/view/widgets/gradient_image_container.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/theme/app_color.dart';
import 'dart:ui';

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
          leading: Container(
            margin: EdgeInsets.all(8.w),
            decoration: BoxDecoration(
              color: AppColor.primaryBlue.withOpacity(0.1),
              shape: BoxShape.circle,
            ),
            child: ClipOval(
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                child: Container(
                  decoration: BoxDecoration(
                    color: AppColor.primaryBlue.withOpacity(0.1),
                    shape: BoxShape.circle,
                  ),
                  child: IconButton(
                    icon: Icon(
                      Icons.arrow_back_ios_new,
                      color: AppColor.primaryBlue,
                      size: 20.sp,
                    ),
                    onPressed: () => Navigator.pop(context),
                    padding: EdgeInsets.zero,
                  ),
                ),
              ),
            ),
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
        // User requested to navigate directly to Package Details
        // The item "country" here effectively represents a Package
        Navigator.pushNamed(
          context,
          Routes.packageDetailsView,
          arguments: {
            'packageTypeSlug': slug, // the package type slug
            'packageSlug':
                country.slug, // treating this slug as the package slug
          },
        );
      },
      child: Container(
        height: 180.h,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20.r), // More rounded
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(
                0.08,
              ), // Slightly darker for depth
              blurRadius: 15, // Softer shadow
              offset: const Offset(0, 8),
              spreadRadius: 0,
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(20.r),
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
                  padding: EdgeInsets.all(20.w), // Increased padding
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        country.name ?? "اسم الوجهة",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 22.sp, // Larger font
                          fontWeight: FontWeight.w800, // Bolder
                          letterSpacing: 0.5,
                          shadows: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.5),
                              blurRadius: 10,
                              offset: const Offset(0, 2),
                            ),
                          ],
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
