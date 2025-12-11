import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/featuer/Cities/data/repo/cities_repo.dart';
import 'package:flutter_application_1/featuer/Cities/manager/cities_cubit.dart';
import 'package:flutter_application_1/featuer/Cities/manager/cities_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/theme/app_color.dart';

class CityDetailsView extends StatelessWidget {
  final String citySlug;

  const CityDetailsView({super.key, required this.citySlug});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          CitiesCubit(CitiesRepository())..getCityDetails(citySlug),
      child: Scaffold(
        backgroundColor: Colors.white,
        body: BlocBuilder<CitiesCubit, CitiesState>(
          buildWhen: (previous, current) =>
              current is CityDetailsLoading ||
              current is CityDetailsSuccess ||
              current is CityDetailsError,
          builder: (context, state) {
            if (state is CityDetailsLoading) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is CityDetailsError) {
              return Center(child: Text(state.message));
            } else if (state is CityDetailsSuccess) {
              final city = state.cityData.city;
              if (city == null) return const Center(child: Text("No Data"));

              return CustomScrollView(
                slivers: [
                  // --- 1. AppBar Image ---
                  SliverAppBar(
                    expandedHeight: 500.h,
                    pinned: true,
                    stretch: true,
                    backgroundColor: Colors.transparent,
                    leading: Container(
                      margin: EdgeInsets.all(8.w),
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.3),
                        shape: BoxShape.circle,
                      ),
                      child: IconButton(
                        icon: const Icon(Icons.arrow_back, color: Colors.white),
                        onPressed: () => Navigator.pop(context),
                      ),
                    ),
                    flexibleSpace: FlexibleSpaceBar(
                      stretchModes: const [
                        StretchMode.zoomBackground,
                        StretchMode.blurBackground,
                      ],
                      background: Padding(
                        padding: EdgeInsets.only(
                          left: 12.w,
                          top: 20.h,
                          right: 12.w,
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.all(Radius.circular(30.r)),
                          child: Stack(
                            fit: StackFit.expand,
                            children: [
                              CachedNetworkImage(
                                imageUrl:
                                    city.imageCover ??
                                    "https://via.placeholder.com/300",
                                fit: BoxFit.cover,
                                placeholder: (context, url) => const Center(
                                  child: CircularProgressIndicator(),
                                ),
                                errorWidget: (context, url, error) =>
                                    const Icon(Icons.error),
                              ),
                              Container(
                                decoration: BoxDecoration(
                                  gradient: LinearGradient(
                                    begin: Alignment.topCenter,
                                    end: Alignment.bottomCenter,
                                    colors: [
                                      Colors.transparent,
                                      Colors.black.withOpacity(0.7),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),

                  // --- 2. Content ---
                  SliverToBoxAdapter(
                    child: Container(
                      transform: Matrix4.translationValues(0, -20, 0),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(30.r),
                          topRight: Radius.circular(30.r),
                        ),
                      ),
                      child: Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: 20.w,
                          vertical: 25.h,
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // Title
                            Text(
                              city.name ?? "اسم المدينة",
                              style: TextStyle(
                                fontSize: 24.sp,
                                fontWeight: FontWeight.bold,
                                color: Colors.black87,
                              ),
                            ),
                            SizedBox(height: 8.h),

                            // Country Name
                            if (city.country != null)
                              Row(
                                children: [
                                  Icon(
                                    Icons.location_on,
                                    color: AppColor.primaryBlue,
                                    size: 16.sp,
                                  ),
                                  SizedBox(width: 4.w),
                                  Text(
                                    city.country!.name ?? "",
                                    style: TextStyle(
                                      color: Colors.grey[600],
                                      fontSize: 14.sp,
                                    ),
                                  ),
                                ],
                              ),

                            SizedBox(height: 25.h),
                            Divider(color: Colors.grey.withOpacity(0.2)),
                            SizedBox(height: 15.h),

                            // Description
                            Text(
                              "عن المدينة",
                              style: TextStyle(
                                fontSize: 18.sp,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(height: 10.h),
                            Text(
                              city.description ??
                                  city.descText ??
                                  "لا يوجد وصف متاح.",
                              style: TextStyle(
                                fontSize: 14.sp,
                                color: Colors.grey[600],
                                height: 1.6,
                              ),
                            ),

                            SizedBox(height: 20.h),

                            // Best time to visit
                            if (city.favTime != null &&
                                city.favTime!.isNotEmpty) ...[
                              Text(
                                "أفضل وقت للزيارة",
                                style: TextStyle(
                                  fontSize: 18.sp,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              SizedBox(height: 10.h),
                              Wrap(
                                spacing: 8.w,
                                runSpacing: 8.h,
                                children: city.favTime!
                                    .map(
                                      (time) => Chip(
                                        label: Text(time),
                                        backgroundColor: AppColor.primaryBlue
                                            .withOpacity(0.1),
                                        labelStyle: TextStyle(
                                          color: AppColor.primaryBlue,
                                        ),
                                      ),
                                    )
                                    .toList(),
                              ),
                            ],

                            SizedBox(height: 50.h),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              );
            }
            return const SizedBox();
          },
        ),
      ),
    );
  }
}
