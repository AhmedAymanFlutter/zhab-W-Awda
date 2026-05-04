import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/featuer/home/view/package/data/model/package_details_model.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../../core/theme/app_color.dart';
import '../../../../../../core/theme/app_text_style.dart';

class PackageItinerarySection extends StatelessWidget {
  final List<PackageDay>? days;

  const PackageItinerarySection({super.key, this.days});

  @override
  Widget build(BuildContext context) {
    if (days == null || days!.isEmpty) return const SizedBox.shrink();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "برنامج الرحلة",
          style: AppTextStyle.setelMessiriBlack(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(height: 24.h),
        ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: days!.length,
          itemBuilder: (context, index) {
            return _buildTimelineItem(
              context,
              days![index],
              index == days!.length - 1,
            );
          },
        ),
      ],
    );
  }

  Widget _buildTimelineItem(BuildContext context, PackageDay day, bool isLast) {
    return IntrinsicHeight(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Timeline indicator
          Column(
            children: [
              Container(
                width: 12.w,
                height: 12.w,
                decoration: const BoxDecoration(
                  color: AppColor.primaryBlue,
                  shape: BoxShape.circle,
                ),
              ),
              if (!isLast)
                Expanded(
                  child: Container(
                    width: 2.w,
                    color: AppColor.primaryBlue.withOpacity(0.3),
                  ),
                ),
            ],
          ),
          SizedBox(width: 16.w),
          // Content
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "يوم ${day.dayNumber}",
                  style: AppTextStyle.setelMessiriBlack(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ).copyWith(color: AppColor.primaryBlue),
                ),
                SizedBox(height: 8.h),
                Text(
                  _getTitle(day),
                  style: AppTextStyle.setelMessiriBlack(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 4.h),
                Text(
                  _getDescription(day),
                  style: TextStyle(
                    fontSize: 14.sp,
                    color: Colors.grey[700],
                    height: 1.5,
                  ),
                ),
                if (day.tour?.imageCover != null) ...[
                  SizedBox(height: 12.h),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(12.r),
                    child: CachedNetworkImage(
                      imageUrl: day.tour!.imageCover!,
                      height: 150.h,
                      width: double.infinity,
                      fit: BoxFit.cover,
                      placeholder: (context, url) => Container(
                        color: Colors.grey[200],
                        child: const Center(child: CircularProgressIndicator()),
                      ),
                      errorWidget: (context, url, error) => Container(
                        color: Colors.grey[200],
                        child: Icon(Icons.image_not_supported, color: Colors.grey[400]),
                      ),
                    ),
                  ),
                ],
                SizedBox(height: 24.h),
              ],
            ),
          ),
        ],
      ),
    );
  }

  String _getTitle(PackageDay day) {
    if (day.type == "TOUR" && day.tour != null) {
      return day.tour?.description?.split('\n').first ?? "جولة سياحية";
    }
    return day.customTitle ?? "يوم حر";
  }

  String _getDescription(PackageDay day) {
    if (day.type == "TOUR" && day.tour != null) {
      return day.tour?.description ?? "";
    }
    return day.customDescription ?? "استمتع بيومك الخاص في المدينة.";
  }
}
