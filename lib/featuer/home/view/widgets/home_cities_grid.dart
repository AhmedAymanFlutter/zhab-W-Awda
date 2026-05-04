import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_application_1/featuer/Cities/data/model/getcitiesModel.dart';
import 'home_city_grid_card.dart';

class HomeCitiesGrid extends StatelessWidget {
  final List<CityItem> cities;

  const HomeCitiesGrid({super.key, required this.cities});

  @override
  Widget build(BuildContext context) {
    List<CityItem> displayCities = List.from(cities);
    while (displayCities.length < 5 && displayCities.isNotEmpty) {
      displayCities.add(displayCities.first);
    }
    if (displayCities.isEmpty) return const SizedBox.shrink();

    return SizedBox(
      height: 380.h,
      child: Row(
        children: [
          Expanded(
            flex: 2,
            child: Column(
              children: [
                Expanded(child: HomeCityGridCard(city: displayCities[0])),
                SizedBox(height: 10.h),
                Expanded(child: HomeCityGridCard(city: displayCities[1])),
              ],
            ),
          ),
          SizedBox(width: 10.w),
          Expanded(
            flex: 3,
            child: HomeCityGridCard(city: displayCities[2], isLarge: true),
          ),
          SizedBox(width: 10.w),
          Expanded(
            flex: 2,
            child: Column(
              children: [
                Expanded(child: HomeCityGridCard(city: displayCities[3])),
                SizedBox(height: 10.h),
                Expanded(child: HomeCityGridCard(city: displayCities[4])),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
