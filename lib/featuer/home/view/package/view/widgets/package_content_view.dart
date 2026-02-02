import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';

import '../../../../../../core/theme/app_color.dart';
import '../../../../../../core/theme/app_text_style.dart';
import 'package_feature_item.dart';
import 'package_itinerary_item.dart';
import 'reviews_section.dart';

class PackageContentView extends StatelessWidget {
  final dynamic pkg;
  final dynamic branch; // Can be null now
  final String? packageSlug;

  const PackageContentView({
    super.key,
    required this.pkg,
    this.branch,
    this.packageSlug,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 16.h),
      physics: const BouncingScrollPhysics(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (branch != null) _buildPriceSection(branch),

          if (pkg?.descText != null || pkg?.description != null)
            _buildDescriptionSection(pkg),

          if (branch?.days?.isNotEmpty ?? false) _buildItinerarySection(branch),

          if (branch?.includes?.isNotEmpty ?? false)
            _buildIncludesSection(branch),

          if (branch?.excludes?.isNotEmpty ?? false)
            _buildExcludesSection(branch),

          if (packageSlug?.isNotEmpty ?? false)
            ReviewsSection(packageSlug: packageSlug!),

          SizedBox(height: 60.h),
        ],
      ),
    );
  }

  Widget _buildPriceSection(dynamic branch) {
    return Container(
      padding: EdgeInsets.all(16.w),
      margin: EdgeInsets.only(bottom: 24.h),
      decoration: BoxDecoration(
        color: AppColor.primaryBlue.withOpacity(0.05),
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(color: AppColor.primaryBlue.withOpacity(0.1)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Price Per Person",
                style: TextStyle(
                  color: AppColor.secondaryGrey,
                  fontSize: 12.sp,
                ),
              ),
              Text(
                "${branch.price} LE",
                style: TextStyle(
                  color: AppColor.primaryBlue,
                  fontSize: 18.sp,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 6.h),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20.r),
            ),
            child: Row(
              children: [
                Icon(Icons.nights_stay, size: 14.sp, color: Colors.amber),
                SizedBox(width: 4.w),
                Text(
                  "${branch.nightsCount} Nights",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 12.sp,
                    color: AppColor.mainBlack,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDescriptionSection(dynamic pkg) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "عن الباقة",
          style: AppTextStyle.setelMessiriBlack(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(height: 8.h),
        HtmlWidget(
          pkg.description ?? pkg.descText ?? "",
          textStyle: AppTextStyle.setelMessiriSecondlightGrey(
            fontSize: 14,
            fontWeight: FontWeight.normal,
          ).copyWith(height: 1.5),
        ),
        SizedBox(height: 20.h),
      ],
    );
  }

  Widget _buildIncludesSection(dynamic branch) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "ما تشمله الباقة",
          style: AppTextStyle.setelMessiriBlack(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(height: 8.h),
        ...branch.includes!.map(
          (item) => PackageFeatureItem(text: item, isIncluded: true),
        ),
        SizedBox(height: 20.h),
      ],
    );
  }

  Widget _buildExcludesSection(dynamic branch) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "ما لا تشمله الباقة",
          style: AppTextStyle.setelMessiriBlack(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(height: 8.h),
        ...branch.excludes!.map(
          (item) => PackageFeatureItem(text: item, isIncluded: false),
        ),
        SizedBox(height: 20.h),
      ],
    );
  }

  Widget _buildItinerarySection(dynamic branch) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "برنامج الرحلة",
          style: AppTextStyle.setelMessiriBlack(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(height: 16.h),
        ...branch.days!.map((day) => PackageItineraryItem(day: day)),
        SizedBox(height: 20.h),
      ],
    );
  }
}
