import 'package:flutter/material.dart';
import 'package:flutter_application_1/featuer/home/view/package/data/model/package_details_model.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package_overview_section.dart';
import 'package_itinerary_section.dart';
import 'package_inclusions_exclusions_section.dart';
import 'package_destinations_section.dart';

class PackageContentView extends StatelessWidget {
  final PackagePkg? pkg;
  final PackageBranch? branch;

  const PackageContentView({
    super.key,
    required this.pkg,
    required this.branch,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      padding: EdgeInsets.all(24.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // 1. Overview
          PackageOverviewSection(description: pkg?.description),
          SizedBox(height: 32.h),

          // 2. Itinerary (Program)
          PackageItinerarySection(days: branch?.days),
          SizedBox(height: 32.h),

          // 3. Inclusions & Exclusions
          PackageInclusionsExclusionsSection(
            inclusions: branch?.includes,
            exclusions: branch?.excludes,
          ),
          SizedBox(height: 32.h),

          // 4. Destinations
          PackageDestinationsSection(cities: branch?.cities ?? pkg?.cities),

          SizedBox(height: 100.h), // Space for bottom panel
        ],
      ),
    );
  }
}
