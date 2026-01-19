import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../../core/theme/app_text_style.dart';
import '../../data/model/get_package_id_model.dart';
import 'package_timeline_item.dart';

class PackageItineraryItem extends StatelessWidget {
  final Day day;

  const PackageItineraryItem({super.key, required this.day});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.only(bottom: 16.h),
      elevation: 2,
      shadowColor: Colors.black.withOpacity(0.05),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.r)),
      child: ExpansionTile(
        tilePadding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
        title: Text(
          "اليوم ${day.dayNumber}: ${day.tour?.title ?? 'يوم حر'}",
          style: AppTextStyle.setelMessiriBlack(
            fontSize: 14,
            fontWeight: FontWeight.bold,
          ),
        ),
        children: [
          if (day.tour?.paths != null)
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
              child: Column(
                children: day.tour!.paths!.asMap().entries.map((entry) {
                  int idx = entry.key;
                  var path = entry.value;
                  bool isLast = idx == day.tour!.paths!.length - 1;
                  return PackageTimelineItem(path: path, isLast: isLast);
                }).toList(),
              ),
            ),
          if (day.tour?.paths == null && day.tour?.description != null)
            Padding(
              padding: EdgeInsets.all(16.w),
              child: Text(
                day.tour!.description!,
                style: AppTextStyle.setelMessiriSecondlightGrey(
                  fontSize: 12,
                  fontWeight: FontWeight.normal,
                ).copyWith(height: 1.5),
              ),
            ),
        ],
      ),
    );
  }
}
