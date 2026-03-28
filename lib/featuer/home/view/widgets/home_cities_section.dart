import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/featuer/Cities/data/model/getcitiesModel.dart';
import 'package:flutter_application_1/featuer/Cities/manager/cities_cubit.dart';
import 'package:flutter_application_1/featuer/Cities/manager/cities_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../../../../core/theme/app_text_style.dart';

class HomeCitiesSection extends StatelessWidget {
  const HomeCitiesSection({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CitiesCubit, CitiesState>(
      builder: (context, state) {
        if (state is CitiesLoading) {
          return const Center(child: CircularProgressIndicator());
        } else if (state is CitiesSuccess) {
          final cities = state.cities.take(5).toList();
          if (cities.isEmpty) return const SizedBox.shrink();

          return Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 24.h),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  "أفضل الوجهات السياحية",
                  style: AppTextStyle.setelMessiriBlack(fontSize: 24, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 8.h),
                Text(
                  "اكتشف أشهر الوجهات حول العالم، سواء كنت تبحث عن الاستجمام، المغامرة، التسوق أو التجارب الثقافية. اختر وجهتك القادمة واستعد لرحلة مليئة باللحظات المميزة.",
                  textAlign: TextAlign.center,
                  style: AppTextStyle.setelMessiriTextStyle(fontSize: 14, color: Colors.grey[600]!, fontWeight: FontWeight.normal),
                ),
                SizedBox(height: 24.h),
                _buildMasonryGrid(cities),
                SizedBox(height: 16.h),
                TextButton.icon(
                  onPressed: () {
                    // Navigate to cities view
                  },
                  icon: Icon(FontAwesomeIcons.chevronLeft, size: 14.sp, color: const Color(0xFF002868)),
                  label: Text(
                    "عرض جميع الوجهات",
                    style: AppTextStyle.setelMessiriTextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: const Color(0xFF002868),
                    ),
                  ),
                ),
              ],
            ),
          );
        } else {
          return const SizedBox.shrink();
        }
      },
    );
  }

  Widget _buildMasonryGrid(List<CityItem> cities) {
    List<CityItem> displayCities = List.from(cities);
    while (displayCities.length < 5) {
      displayCities.add(cities.first);
    }

    return SizedBox(
      height: 350.h,
      child: Row(
        children: [
          Expanded(
            flex: 2,
            child: Column(
              children: [
                Expanded(child: _buildCityCard(displayCities[0])),
                SizedBox(height: 8.h),
                Expanded(child: _buildCityCard(displayCities[1])),
              ],
            ),
          ),
          SizedBox(width: 8.w),
          Expanded(
            flex: 3,
            child: _buildCityCard(displayCities[2], isLarge: true),
          ),
          SizedBox(width: 8.w),
          Expanded(
            flex: 2,
            child: Column(
              children: [
                Expanded(child: _buildCityCard(displayCities[3])),
                SizedBox(height: 8.h),
                Expanded(child: _buildCityCard(displayCities[4])),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCityCard(CityItem city, {bool isLarge = false}) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(16.r),
      child: Stack(
        fit: StackFit.expand,
        children: [
          CachedNetworkImage(
            imageUrl: city.imageCover ?? "https://via.placeholder.com/300",
            fit: BoxFit.cover,
            placeholder: (context, url) => Container(color: Colors.grey[200]),
            errorWidget: (context, url, error) => Container(color: Colors.grey[200]),
          ),
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.bottomCenter,
                end: Alignment.topCenter,
                colors: [
                  Colors.black.withOpacity(0.7),
                  Colors.transparent,
                ],
                stops: const [0.0, 0.4],
              ),
            ),
          ),
          Positioned(
            bottom: 12.h,
            right: 12.w,
            child: Text(
              city.name ?? "هولندا",
              style: AppTextStyle.setelMessiriWhite(fontSize: isLarge ? 20 : 16, fontWeight: FontWeight.bold),
            ),
          ),
        ],
      ),
    );
  }
}
