import 'package:flutter/material.dart';
import 'package:flutter_application_1/featuer/tours/data/model/get_tour_id_model.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/theme/app_color.dart';

class TourPackageCard extends StatelessWidget {
  final ProductOption option;

  const TourPackageCard({super.key, required this.option});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 290.w,
      height: 242.h,
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16.r),
        boxShadow: const [
          BoxShadow(
            color: Color(0x1F000000),
            blurRadius: 7,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header Icons
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Icon(Icons.info_outline, size: 20.sp, color: Colors.grey[400]),
              Icon(Icons.inventory_2_outlined, size: 24.sp, color: AppColor.primaryBlue),
            ],
          ),
          SizedBox(height: 16.h),
          
          // Title
          Text(
            option.title ?? "رحلة ساحرة",
            textAlign: TextAlign.right,
            style: TextStyle(
              fontSize: 18.sp,
              fontWeight: FontWeight.bold,
              color: const Color(0xFF1A1A1A),
            ),
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
          
          SizedBox(height: 8.h),
          
          // Description
          Expanded(
            child: Text(
              option.packageDescription?.isNotEmpty == true 
                  ? option.packageDescription!.first 
                  : "تجول في شوارع فلورنسا واستمتع بالفن والثقافة.",
              textAlign: TextAlign.right,
              style: TextStyle(
                fontSize: 13.sp,
                color: Colors.grey[600],
                height: 1.5,
              ),
              maxLines: 3,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          
          // Price Pill
          Align(
            alignment: Alignment.bottomLeft,
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
              decoration: BoxDecoration(
                color: const Color(0xFFE8EEF5),
                borderRadius: BorderRadius.circular(20.r),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    " ريال",
                    style: TextStyle(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.bold,
                      color: AppColor.primaryBlue,
                    ),
                  ),
                  Text(
                    "${option.price?.toInt() ?? 2500}",
                    style: TextStyle(
                      fontSize: 18.sp,
                      fontWeight: FontWeight.bold,
                      color: AppColor.primaryBlue,
                    ),
                  ),
                ],
              ),
            ),
          ),
          
          SizedBox(height: 4.h),
          Align(
            alignment: Alignment.bottomRight,
            child: Text(
              "(شامل ضريبة القيمة المضافة)",
              style: TextStyle(
                fontSize: 10.sp,
                color: Colors.grey[400],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
