import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../../core/theme/app_color.dart';
import '../../../../../../core/theme/app_text_style.dart';
import '../../data/model/get_all_offers_model.dart';

class OfferDetailsContent extends StatelessWidget {
  final OfferItem offer;

  const OfferDetailsContent({super.key, required this.offer});

  @override
  Widget build(BuildContext context) {
    return Container(
      transform: Matrix4.translationValues(0, -30, 0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(30.r)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            offset: const Offset(0, -5),
            blurRadius: 20,
          ),
        ],
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 60.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // --- Header Section (Title & Rating) ---
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Text(
                    offer.name ?? "تفاصيل العرض",
                    style: AppTextStyle.setelMessiriBlack(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ).copyWith(height: 1.3),
                  ),
                ),
                SizedBox(width: 12.w),
                _buildRatingBadge(),
              ],
            ),

            SizedBox(height: 8.h),

            // Location (if available in name or description, placeholder for now)
            Row(
              children: [
                Icon(Icons.location_on, color: Colors.grey, size: 16.sp),
                SizedBox(width: 4.w),
                Text(
                  "القاهرة، مصر", // Placeholder or dynamic if available
                  style: AppTextStyle.setelMessiriSecondlightGrey(
                    fontSize: 14,
                    fontWeight: FontWeight.normal,
                  ),
                ),
              ],
            ),

            SizedBox(height: 24.h),

            // --- Features Chips ---
            Container(
              padding: EdgeInsets.all(16.r),
              decoration: BoxDecoration(
                color: const Color(0xFFF8F9FA),
                borderRadius: BorderRadius.circular(16.r),
                border: Border.all(color: Colors.grey.withOpacity(0.1)),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  _buildFeatureItem(Icons.access_time_filled, "5 أيام"),
                  _buildVerticalDivider(),
                  _buildFeatureItem(Icons.people, "أفراد"),
                  _buildVerticalDivider(),
                  _buildFeatureItem(Icons.star, "4.8"),
                ],
              ),
            ),

            SizedBox(height: 24.h),

            // --- Price Section ---
            _buildPriceSection(),

            SizedBox(height: 24.h),
            Divider(color: Colors.grey.withOpacity(0.1), thickness: 1),
            SizedBox(height: 24.h),

            // --- Description ---
            Text(
              "تفاصيل العرض",
              style: AppTextStyle.setelMessiriBlack(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 12.h),
            Text(
              offer.description ?? "لا يوجد وصف متاح لهذا العرض حالياً.",
              style: AppTextStyle.setelMessirisecondaryGery(
                fontSize: 15,
                fontWeight: FontWeight.normal,
              ).copyWith(height: 1.8),
            ),

            SizedBox(height: 100.h), // Bottom padding for scrolling
          ],
        ),
      ),
    );
  }

  // --- Helper Widgets ---

  Widget _buildRatingBadge() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 6.h),
      decoration: BoxDecoration(
        color: const Color(0xFFFFF8E1), // Light Amber
        borderRadius: BorderRadius.circular(12.r),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(Icons.star_rounded, color: Colors.amber, size: 18.sp),
          SizedBox(width: 4.w),
          Text(
            "4.8",
            style: AppTextStyle.setelMessiriTextStyle(
              fontSize: 14,
              fontWeight: FontWeight.bold,
              color: Colors.amber[800]!,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFeatureItem(IconData icon, String label) {
    return Column(
      children: [
        Icon(icon, color: AppColor.primaryBlue, size: 24.sp),
        SizedBox(height: 6.h),
        Text(
          label,
          style: AppTextStyle.setelMessiriBlack(
            fontSize: 12,
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    );
  }

  Widget _buildVerticalDivider() {
    return Container(
      height: 30.h,
      width: 1,
      color: Colors.grey.withOpacity(0.2),
    );
  }

  Widget _buildPriceSection() {
    return Container(
      padding: EdgeInsets.all(16.r),
      decoration: BoxDecoration(
        color: AppColor.primaryBlue.withOpacity(0.05),
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(color: AppColor.primaryBlue.withOpacity(0.1)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            "السعر الإجمالي",
            style: AppTextStyle.setelMessiriBlack(
              fontSize: 16,
              fontWeight: FontWeight.normal,
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                offer.originPrice ?? "${offer.price} ج.م",
                style: AppTextStyle.setelMessiriDeepPurple(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              if (offer.oldPrice != null)
                Text(
                  offer.oldPrice!.contains('{') ? "0" : offer.oldPrice!, // Safety check
                  style: TextStyle(
                    fontSize: 14.sp,
                    decoration: TextDecoration.lineThrough,
                    color: Colors.grey,
                    fontFamily: 'elMessiri', // Ensure font consistency
                  ),
                ),
            ],
          ),
        ],
      ),
    );
  }
}
