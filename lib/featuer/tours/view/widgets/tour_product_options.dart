import 'package:flutter/material.dart';
import 'package:flutter_application_1/featuer/tours/data/model/get_tour_id_model.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/theme/app_color.dart';
import '../../../../core/theme/app_text_style.dart';

class TourProductOptions extends StatelessWidget {
  final List<ProductOption> options;

  const TourProductOptions({super.key, required this.options});

  @override
  Widget build(BuildContext context) {
    if (options.isEmpty) return const SizedBox.shrink();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "خيارات الجولة",
          style: AppTextStyle.setelMessiriBlack(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(height: 16.h),
        ...options.map((option) => _buildOptionCard(option)),
      ],
    );
  }

  Widget _buildOptionCard(ProductOption option) {
    return Container(
      margin: EdgeInsets.only(bottom: 16.h),
      padding: EdgeInsets.all(20.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20.r),
        border: Border.all(color: Colors.grey[200]!),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.02),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                option.title ?? "خيار جولة",
                style: TextStyle(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.bold,
                  color: AppColor.primaryBlue,
                ),
              ),
              if (option.price != null && option.price! > 0)
                Text(
                  "${option.price} ${option.currency ?? 'AED'}",
                  style: TextStyle(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.bold,
                    color: Colors.green[700],
                  ),
                ),
            ],
          ),
          SizedBox(height: 12.h),
          if (option.packageDescription != null)
            ...option.packageDescription!.map((desc) => _buildInfoLine(desc)),

          if (option.termsAndConditions?.isNotEmpty == true) ...[
            SizedBox(height: 12.h),
            Text(
              "الشروط والأحكام",
              style: TextStyle(
                fontSize: 14.sp,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
            ),
            SizedBox(height: 4.h),
            ...option.termsAndConditions!.map(
              (term) => _buildInfoLine(term, isSmall: true),
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildInfoLine(String text, {bool isSmall = false}) {
    return Padding(
      padding: EdgeInsets.only(bottom: 4.h),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(
            Icons.check_circle_outline_rounded,
            size: isSmall ? 14.sp : 16.sp,
            color: Colors.green[600],
          ),
          SizedBox(width: 8.w),
          Expanded(
            child: Text(
              text,
              style: TextStyle(
                fontSize: isSmall ? 12.sp : 13.sp,
                color: isSmall ? Colors.grey[600] : Colors.grey[800],
                height: 1.4,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
