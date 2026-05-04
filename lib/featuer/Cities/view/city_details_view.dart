import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/featuer/Cities/data/repo/cities_repo.dart';
import 'package:flutter_application_1/featuer/Cities/manager/cities_cubit.dart';
import 'package:flutter_application_1/featuer/Cities/manager/cities_state.dart';
import 'package:flutter_application_1/core/widgets/offer_booking_bar.dart';
import 'package:flutter_application_1/core/widgets/html_content_widget.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/theme/app_color.dart';
import '../../../../core/theme/app_text_style.dart';
import 'widgets/city_weather_card.dart';
import 'widgets/city_info_grid.dart';

class CityDetailsView extends StatelessWidget {
  final String citySlug;

  const CityDetailsView({super.key, required this.citySlug});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => CitiesCubit(CitiesRepository())..getCityDetails(citySlug),
      child: Scaffold(
        bottomNavigationBar: const OfferBookingBar(),
        backgroundColor: const Color(0xFFF8F9FB),
        body: BlocBuilder<CitiesCubit, CitiesState>(
          builder: (context, state) {
            if (state is CityDetailsLoading) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is CityDetailsError) {
              return Center(child: Text(state.message));
            } else if (state is CityDetailsSuccess) {
              final city = state.cityData.city;
              final weather = state.cityData.cityWeather;
              if (city == null) return const Center(child: Text("No Data"));

              return CustomScrollView(
                physics: const BouncingScrollPhysics(),
                slivers: [
                  // --- 1. Modern Immersive AppBar ---
                  SliverAppBar(
                    expandedHeight: 450.h,
                    pinned: true,
                    stretch: true,
                    backgroundColor: AppColor.primaryBlue,
                    leading: Container(
                      margin: EdgeInsets.all(8.w),
                      decoration: BoxDecoration(
                        color: Colors.black.withOpacity(0.2),
                        shape: BoxShape.circle,
                      ),
                      child: IconButton(
                        icon: const Icon(Icons.arrow_back_ios_new, color: Colors.white, size: 20),
                        onPressed: () => Navigator.pop(context),
                      ),
                    ),
                    flexibleSpace: FlexibleSpaceBar(
                      background: Stack(
                        fit: StackFit.expand,
                        children: [
                          CachedNetworkImage(
                            imageUrl: city.imageCover ?? "https://via.placeholder.com/800",
                            fit: BoxFit.cover,
                            placeholder: (context, url) => Container(color: Colors.grey[200]),
                            errorWidget: (context, url, error) => Container(
                              color: Colors.grey[300],
                              child: const Icon(Icons.image_not_supported_outlined, color: Colors.grey, size: 50),
                            ),
                          ),
                          DecoratedBox(
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                begin: Alignment.topCenter,
                                end: Alignment.bottomCenter,
                                colors: [
                                  Colors.black.withOpacity(0.2),
                                  Colors.transparent,
                                  Colors.black.withOpacity(0.8),
                                ],
                              ),
                            ),
                          ),
                          Positioned(
                            bottom: 40.h,
                            left: 24.w,
                            right: 24.w,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                if (city.country != null)
                                  Container(
                                    padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 6.h),
                                    decoration: BoxDecoration(
                                      color: AppColor.primaryBlue,
                                      borderRadius: BorderRadius.circular(20.r),
                                    ),
                                    child: Text(
                                      city.country!.name ?? "",
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 12.sp,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                SizedBox(height: 12.h),
                                Text(
                                  city.name ?? "اسم المدينة",
                                  style: AppTextStyle.setelMessiriBlack(
                                    fontSize: 34,
                                    fontWeight: FontWeight.bold,
                                  ).copyWith(color: Colors.white),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),

                  // --- 2. Content Sections ---
                  SliverToBoxAdapter(
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.vertical(top: Radius.circular(32.r)),
                      ),
                      child: Padding(
                        padding: EdgeInsets.all(24.w),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            if (weather != null) CityWeatherCard(weather: weather),
                            SizedBox(height: 32.h),
                            CityInfoGrid(city: city),
                            SizedBox(height: 32.h),
                            Text(
                              "اكتشف ${city.name}",
                              style: AppTextStyle.setelMessiriBlack(fontSize: 22, fontWeight: FontWeight.bold),
                            ),
                            SizedBox(height: 12.h),
                            HtmlContentWidget(
                              htmlContent: city.description ?? city.descText ?? "استكشف جمال وتاريخ هذه المدينة الرائعة.",
                              fontSize: 15.sp,
                            ),
                            SizedBox(height: 32.h),
                            if (city.images != null && city.images!.isNotEmpty) ...[
                              Text(
                                "معالم المدينة",
                                style: AppTextStyle.setelMessiriBlack(fontSize: 22, fontWeight: FontWeight.bold),
                              ),
                              SizedBox(height: 16.h),
                              SizedBox(
                                height: 180.h,
                                child: ListView.separated(
                                  scrollDirection: Axis.horizontal,
                                  physics: const BouncingScrollPhysics(),
                                  itemCount: city.images!.length,
                                  separatorBuilder: (context, index) => SizedBox(width: 12.w),
                                  itemBuilder: (context, index) {
                                    return ClipRRect(
                                      borderRadius: BorderRadius.circular(20.r),
                                      child: CachedNetworkImage(
                                        imageUrl: city.images![index],
                                        width: 280.w,
                                        fit: BoxFit.cover,
                                        errorWidget: (context, url, error) => Container(
                                          color: Colors.grey[200],
                                          child: const Icon(Icons.broken_image_outlined, color: Colors.grey),
                                        ),
                                      ),
                                    );
                                  },
                                ),
                              ),
                            ],
                            SizedBox(height: 100.h),
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
