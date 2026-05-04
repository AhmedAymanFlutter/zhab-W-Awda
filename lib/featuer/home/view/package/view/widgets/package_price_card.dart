import 'package:flutter/material.dart';
import 'package:flutter_application_1/featuer/home/view/package/data/model/get_package_id_model.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../../core/theme/app_color.dart';

class PackagePriceCard extends StatelessWidget {
  final Branch branch;

  const PackagePriceCard({super.key, required this.branch});

  @override
  Widget build(BuildContext context) {
    final String displayPrice =
        branch.originPrice != null &&
            branch.originPrice!.isNotEmpty &&
            branch.originPrice != "null"
        ? branch.originPrice!
        : "${branch.price ?? '0'} LE";

    return Container(
      padding: EdgeInsets.all(20.w),
      margin: EdgeInsets.only(bottom: 24.h),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 20,
            offset: const Offset(0, 8),
          ),
        ],
        border: Border.all(color: Colors.grey.shade100),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "السعر للشخص الواحد",
                  style: TextStyle(
                    color: Colors.grey.shade600,
                    fontSize: 13.sp,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                SizedBox(height: 6.h),
                Text(
                  displayPrice,
                  style: TextStyle(
                    color: AppColor.primaryBlue,
                    fontSize: 24.sp,
                    fontWeight: FontWeight.w900,
                  ),
                ),
              ],
            ),
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 10.h),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [AppColor.primaryBlue, AppColor.primaryBlue.withOpacity(0.8)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(16.r),
              boxShadow: [
                BoxShadow(
                  color: AppColor.primaryBlue.withOpacity(0.2),
                  blurRadius: 8,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  Icons.nights_stay_rounded,
                  size: 16.sp,
                  color: Colors.white,
                ),
                SizedBox(width: 8.w),
                Text(
                  "${branch.nightsCount ?? 0} ليالي",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 14.sp,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
