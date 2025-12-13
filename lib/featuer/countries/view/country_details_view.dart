import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/featuer/countries/manager/countries_cubit.dart';
import 'package:flutter_application_1/featuer/countries/manager/countries_state.dart';
import 'package:flutter_application_1/core/widgets/offer_booking_bar.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/theme/app_color.dart';
import '../data/repo/countries_repository.dart';

class CountryDetailsView extends StatelessWidget {
  final String countrySlug; // Using slug as per API

  const CountryDetailsView({super.key, required this.countrySlug});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          CountriesCubit(CountriesRepository())..getCountryDetails(countrySlug),
      child: Scaffold(
        bottomNavigationBar: OfferBookingBar(),
        backgroundColor: Colors.white,
        body: BlocBuilder<CountriesCubit, CountriesState>(
          buildWhen: (previous, current) =>
              current is CountryDetailsLoading ||
              current is CountryDetailsSuccess ||
              current is CountryDetailsError,
          builder: (context, state) {
            if (state is CountryDetailsLoading) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is CountryDetailsError) {
              return Center(child: Text(state.message));
            } else if (state is CountryDetailsSuccess) {
              final country = state.country;

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
                                    country.imageCover ??
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

                  // --- 2. Details Content ---
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
                              country.name ?? "اسم الدولة",
                              style: TextStyle(
                                fontSize: 24.sp,
                                fontWeight: FontWeight.bold,
                                color: Colors.black87,
                              ),
                            ),
                            SizedBox(height: 20.h),

                            // Key Info Grid
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                _buildInfoItem(
                                  Icons.public,
                                  "القارة",
                                  country.continent ?? "-",
                                ),
                                _buildInfoItem(
                                  Icons.language,
                                  "اللغة",
                                  country.language ?? "-",
                                ),
                                _buildInfoItem(
                                  Icons.attach_money,
                                  "العملة",
                                  country.currency ?? "-",
                                ),
                              ],
                            ),

                            SizedBox(height: 25.h),
                            Divider(color: Colors.grey.withOpacity(0.2)),
                            SizedBox(height: 15.h),

                            // Description
                            Text(
                              "عن الدولة",
                              style: TextStyle(
                                fontSize: 18.sp,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(height: 10.h),
                            Text(
                              country.description ??
                                  country.descText ??
                                  "لا يوجد وصف متاح.",
                              style: TextStyle(
                                fontSize: 14.sp,
                                color: Colors.grey[600],
                                height: 1.6,
                              ),
                            ),
                            SizedBox(height: 20.h),

                            // Best Time to Visit (if available)
                            if (country.favTime != null &&
                                country.favTime!.isNotEmpty) ...[
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
                                children: country.favTime!
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

  Widget _buildInfoItem(IconData icon, String title, String value) {
    return Column(
      children: [
        Container(
          padding: EdgeInsets.all(10.w),
          decoration: BoxDecoration(
            color: AppColor.primaryBlue.withOpacity(0.1),
            shape: BoxShape.circle,
          ),
          child: Icon(icon, color: AppColor.primaryBlue, size: 20.sp),
        ),
        SizedBox(height: 8.h),
        Text(
          title,
          style: TextStyle(fontSize: 12.sp, color: Colors.grey),
        ),
        Text(
          value,
          style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.bold),
        ),
      ],
    );
  }
}
