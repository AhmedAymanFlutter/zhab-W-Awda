import 'package:flutter/material.dart';
import 'package:flutter_application_1/featuer/home/view/package/data/model/package_details_model.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../../core/theme/app_color.dart';
import '../../../../../../core/theme/app_text_style.dart';

class PackageContentView extends StatelessWidget {
  final PackagePkg? pkg;
  final PackageBranch? branch;

  const PackageContentView({
    super.key,
    this.pkg,
    this.branch,
  });

  @override
  Widget build(BuildContext context) {
    if (branch == null) return const SizedBox();

    return Container(
      width: 343.w,
      margin: EdgeInsets.symmetric(horizontal: 16.w),
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(13.r),
        border: Border.all(color: const Color(0x121A1A1A), width: 1),
        boxShadow: [
          BoxShadow(
            color: const Color(0x0D000000),
            blurRadius: 4.r,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // 1. Overview
          _buildSectionTitle("نظرة عامة عن الباقة"),
          SizedBox(height: 8.h),
          Text(
            pkg?.description ?? "استمتع بتجربة مميزة مع هذه الباقة السياحية المصممة بعناية.",
            textAlign: TextAlign.right,
            style: AppTextStyle.setelMessiriSecondlightGrey(
              fontSize: 14,
              fontWeight: FontWeight.normal,
            ).copyWith(height: 1.6),
          ),
          SizedBox(height: 32.h),

          // 2. Trip Program (Timeline)
          _buildSectionTitle("برنامج الرحلة"),
          SizedBox(height: 16.h),
          if (branch?.days != null)
            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: branch!.days!.length,
              itemBuilder: (context, index) => _buildTimelineItem(branch!.days![index], index == branch!.days!.length - 1),
            ),
          SizedBox(height: 32.h),

          // 3. Inclusions
          _buildSectionTitle("ما تشمله الباقة"),
          SizedBox(height: 12.h),
          ...?branch?.includes?.map((item) => _buildCheckItem(item, true)),
          SizedBox(height: 32.h),

          // 4. Exclusions
          _buildSectionTitle("ما لا تشمله الباقة"),
          SizedBox(height: 12.h),
          ...?branch?.excludes?.map((item) => _buildCheckItem(item, false)),
          SizedBox(height: 32.h),

          // 5. Destinations
          _buildSectionTitle("الوجهات المشمولة"),
          SizedBox(height: 16.h),
          _buildDestinationsList(),
        ],
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Text(
      title,
      style: AppTextStyle.setelMessiriBlack(
        fontSize: 18,
        fontWeight: FontWeight.bold,
      ),
    );
  }

  Widget _buildTimelineItem(PackageDay day, bool isLast) {
    return IntrinsicHeight(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Column(
            children: [
              Container(
                width: 12.w,
                height: 12.w,
                decoration: const BoxDecoration(
                  color: AppColor.primaryBlue3,
                  shape: BoxShape.circle,
                ),
              ),
              if (!isLast)
                Expanded(
                  child: Container(
                    width: 2,
                    color: AppColor.primaryBlue3.withOpacity(0.2),
                  ),
                ),
            ],
          ),
          SizedBox(width: 16.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "يوم ${day.dayNumber}",
                  style: TextStyle(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.bold,
                    color: AppColor.primaryBlue3,
                    fontFamily: 'ElMessiri',
                  ),
                ),
                SizedBox(height: 4.h),
                Text(
                  day.customTitle ?? day.tour?.description ?? "",
                  textAlign: TextAlign.right,
                  style: TextStyle(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                    fontFamily: 'ElMessiri',
                  ),
                ),
                SizedBox(height: 4.h),
                Text(
                  day.customDescription ?? day.tour?.description ?? "",
                  textAlign: TextAlign.right,
                  style: TextStyle(
                    fontSize: 12.sp,
                    color: Colors.grey[600],
                    height: 1.5,
                    fontFamily: 'ElMessiri',
                  ),
                ),
                SizedBox(height: 24.h),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCheckItem(String text, bool isIncluded) {
    return Padding(
      padding: EdgeInsets.only(bottom: 8.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Text(
            text,
            style: AppTextStyle.setelMessiriSecondlightGrey(
              fontSize: 13,
              fontWeight: FontWeight.normal,
            ),
          ),
          SizedBox(width: 8.w),
          Icon(
            isIncluded ? Icons.check_circle_outline : Icons.cancel_outlined,
            size: 18.sp,
            color: isIncluded ? Colors.green : Colors.red,
          ),
        ],
      ),
    );
  }

  Widget _buildDestinationsList() {
    final cities = branch?.cities ?? [];
    if (cities.isEmpty) return const SizedBox();

    return SizedBox(
      height: 150.h,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        reverse: true,
        itemCount: cities.length,
        separatorBuilder: (_, __) => SizedBox(width: 12.w),
        itemBuilder: (context, index) {
          final city = cities[index];
          return Container(
            width: 200.w,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16.r),
              image: DecorationImage(
                image: NetworkImage(city.imageCover ?? ""),
                fit: BoxFit.cover,
              ),
            ),
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16.r),
                gradient: LinearGradient(
                  begin: Alignment.bottomCenter,
                  end: Alignment.topCenter,
                  colors: [Colors.black.withOpacity(0.6), Colors.transparent],
                ),
              ),
              padding: EdgeInsets.all(12.w),
              alignment: Alignment.bottomRight,
              child: Text(
                city.name ?? "",
                style: AppTextStyle.setelMessiriWhite(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
