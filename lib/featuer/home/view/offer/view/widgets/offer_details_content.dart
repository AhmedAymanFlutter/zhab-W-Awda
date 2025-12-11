import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../../core/theme/app_color.dart';
import '../../data/model/get_all_offers_model.dart';

class OfferDetailsContent extends StatelessWidget {
  final OfferItem offer;

  const OfferDetailsContent({super.key, required this.offer});

  @override
  Widget build(BuildContext context) {
    return Container(
      transform: Matrix4.translationValues(0, -20, 0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(30.r),
          topRight: Radius.circular(30.r),
        ),
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 25.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // العنوان والتقييم
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Text(
                    offer.name ?? "تفاصيل العرض",
                    style: TextStyle(
                      fontSize: 22.sp,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                      height: 1.2,
                    ),
                  ),
                ),
                _buildRatingBadge(),
              ],
            ),

            SizedBox(height: 15.h),

            // السعر
            _buildPriceSection(),

            SizedBox(height: 25.h),

            // المميزات (Icons)
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _buildInfoChip(Icons.access_time_filled, "5 أيام"),
                _buildInfoChip(Icons.location_on, "القاهرة"),
                _buildInfoChip(Icons.people, "شامل الأفراد"),
              ],
            ),

            SizedBox(height: 25.h),
            Divider(color: Colors.grey.withOpacity(0.2)),
            SizedBox(height: 15.h),

            // الوصف
            Text(
              "عن الرحلة",
              style: TextStyle(
                fontSize: 18.sp,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
            ),
            SizedBox(height: 10.h),
            Text(
              offer.description ?? "لا يوجد وصف متاح لهذا العرض حالياً.",
              style: TextStyle(
                fontSize: 14.sp,
                color: Colors.grey[600],
                height: 1.6,
              ),
            ),
            SizedBox(height: 80.h), // مساحة إضافية عشان السكرول
          ],
        ),
      ),
    );
  }

  // --- Helper Widgets Internal ---

  Widget _buildRatingBadge() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
      decoration: BoxDecoration(
        color: Colors.amber.withOpacity(0.2),
        borderRadius: BorderRadius.circular(8.r),
      ),
      child: Row(
        children: [
          Icon(Icons.star, color: Colors.amber, size: 16.sp),
          SizedBox(width: 4.w),
          Text(
            "4.8",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 12.sp,
              color: Colors.amber[800],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPriceSection() {
    return Row(
      children: [
        Text(
          "${offer.price} ج.م",
          style: TextStyle(
            fontSize: 24.sp,
            fontWeight: FontWeight.bold,
            color: AppColor.primaryBlue,
          ),
        ),
        SizedBox(width: 10.w),
        if (offer.oldPrice != null) ...[
          Text(
            "${offer.oldPrice} ج.م",
            style: TextStyle(
              fontSize: 16.sp,
              decoration: TextDecoration.lineThrough,
              color: Colors.grey,
            ),
          ),
          SizedBox(width: 10.w),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
            decoration: BoxDecoration(
              color: Colors.red.withOpacity(0.1),
              borderRadius: BorderRadius.circular(8.r),
            ),
            child: Text(
              "عرض خاص",
              style: TextStyle(
                color: Colors.red,
                fontSize: 10.sp,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ],
    );
  }

  Widget _buildInfoChip(IconData icon, String label) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
      decoration: BoxDecoration(
        color: AppColor.primaryBlue.withOpacity(0.05),
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(color: AppColor.primaryBlue.withOpacity(0.1)),
      ),
      child: Row(
        children: [
          Icon(icon, color: AppColor.primaryBlue, size: 18.sp),
          SizedBox(width: 6.w),
          Text(
            label,
            style: TextStyle(
              fontSize: 12.sp,
              fontWeight: FontWeight.w600,
              color: AppColor.primaryBlue,
            ),
          ),
        ],
      ),
    );
  }
}
