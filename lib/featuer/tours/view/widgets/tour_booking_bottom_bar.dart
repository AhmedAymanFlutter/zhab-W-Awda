import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/theme/app_color.dart';
import '../../../../core/theme/app_text_style.dart';

class TourBookingBottomBar extends StatelessWidget {
  final String? price;
  final String? oldPrice;
  final VoidCallback? onQuickBookTap;
  final VoidCallback? onCheckAvailabilityTap;

  const TourBookingBottomBar({
    super.key,
    this.price,
    this.oldPrice,
    this.onQuickBookTap,
    this.onCheckAvailabilityTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 12.h),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, -5),
          ),
        ],
      ),
      child: SafeArea(
        top: false,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // Price Section
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(
                          "${price ?? '0'} ريال",
                          style: AppTextStyle.setelMessiriBlack(
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                          ).copyWith(color: AppColor.primaryBlue3),
                        ),
                        if (oldPrice != null) ...[
                          SizedBox(width: 8.w),
                          Text(
                            "$oldPrice ريال",
                            style: TextStyle(
                              fontSize: 14.sp,
                              color: Colors.grey,
                              decoration: TextDecoration.lineThrough,
                              fontFamily: 'ElMessiri',
                            ),
                          ),
                        ],
                      ],
                    ),
                    Text(
                      "(شامل ضريبة القيمة المضافة)",
                      style: TextStyle(
                        fontSize: 10.sp,
                        color: Colors.grey,
                        fontFamily: 'ElMessiri',
                      ),
                    ),
                  ],
                ),
              ],
            ),
            SizedBox(height: 12.h),
            
            // Quick Confirm Button
            InkWell(
              onTap: onQuickBookTap,
              child: Container(
                width: double.infinity,
                padding: EdgeInsets.symmetric(vertical: 10.h),
                decoration: BoxDecoration(
                  color: const Color(0xFFD4F3E1),
                  borderRadius: BorderRadius.circular(10.r),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.verified_outlined, color: Colors.green[800], size: 18.sp),
                    SizedBox(width: 8.w),
                    Text(
                      "تأكيد سريع للحجز",
                      style: TextStyle(
                        color: Colors.green[800],
                        fontSize: 14.sp,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'ElMessiri',
                      ),
                    ),
                  ],
                ),
              ),
            ),
            
            SizedBox(height: 8.h),
            
            // Availability Info
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.star_outline, color: Colors.orange, size: 14.sp),
                SizedBox(width: 4.w),
                Text(
                  "متبقي 5 أماكن فقط",
                  style: TextStyle(
                    color: Colors.orange[800],
                    fontSize: 12.sp,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'ElMessiri',
                  ),
                ),
              ],
            ),
            
            SizedBox(height: 8.h),
            
            // Check Availability Button
            ElevatedButton(
              onPressed: onCheckAvailabilityTap,
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColor.primaryBlue3,
                minimumSize: Size(double.infinity, 45.h),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.r),
                ),
                elevation: 0,
              ),
              child: Text(
                "تحقق من التوفر",
                style: AppTextStyle.setelMessiriWhite(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
