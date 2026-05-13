import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../../core/theme/app_color.dart';

class PackageHeaderImage extends StatelessWidget {
  final String? imageUrl;
  final num? rating;

  const PackageHeaderImage({
    super.key,
    this.imageUrl,
    this.rating,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 343.w,
      height: 200.h,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(24.r),
        image: DecorationImage(
          image: NetworkImage(imageUrl ?? ""),
          fit: BoxFit.cover,
        ),
      ),
      alignment: Alignment.topRight,
      padding: EdgeInsets.all(16.w),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 6.h),
        decoration: BoxDecoration(
          color: AppColor.primaryBlue3,
          borderRadius: BorderRadius.circular(20.r),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.star, color: Colors.amber, size: 14.sp),
            SizedBox(width: 4.w),
            Text(
              "${rating ?? 0}",
              style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }
}
