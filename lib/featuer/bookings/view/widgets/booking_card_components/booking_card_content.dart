import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../core/theme/app_color.dart';
import '../../../../../core/theme/app_text_style.dart';
import 'package:intl/intl.dart';

class BookingCardContent extends StatelessWidget {
  final String description;
  final String city;
  final String country;
  final String? startDate;
  final String? endDate;
  final int adultsCount;
  final String imageCover;

  const BookingCardContent({
    super.key,
    required this.description,
    required this.city,
    required this.country,
    this.startDate,
    this.endDate,
    required this.adultsCount,
    required this.imageCover,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Info Column
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                description,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                textAlign: TextAlign.right,
                style: AppTextStyle.setelMessiriBlack(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 4.h),
              Text(
                "$city، $country",
                style: AppTextStyle.setelMessiriBlack(
                  fontSize: 12,
                  fontWeight: FontWeight.normal,
                ).copyWith(color: AppColor.primaryBlue3),
              ),
              const Spacer(),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text(
                    _formatDateRange(startDate, endDate),
                    style: TextStyle(
                      fontSize: 12.sp,
                      color: const Color(0xFF667085),
                    ),
                  ),
                  SizedBox(width: 4.w),
                  Icon(
                    Icons.calendar_today_outlined,
                    size: 14.sp,
                    color: const Color(0xFF667085),
                  ),
                  SizedBox(width: 12.w),
                  Text(
                    "$adultsCount أشخاص",
                    style: TextStyle(
                      fontSize: 12.sp,
                      color: const Color(0xFF667085),
                    ),
                  ),
                  SizedBox(width: 4.w),
                  Icon(
                    Icons.people_outline,
                    size: 14.sp,
                    color: const Color(0xFF667085),
                  ),
                ],
              ),
            ],
          ),
        ),
        SizedBox(width: 12.w),
        // Image
        Container(
          width: 109.w,
          height: 90.h,

          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8.r),
            image: DecorationImage(
              image: CachedNetworkImageProvider(imageCover),

              fit: BoxFit.cover,
            ),
          ),
        ),
      ],
    );
  }

  String _formatDateRange(String? start, String? end) {
    if (start == null || end == null) return "";
    try {
      final startDate = DateTime.parse(start);
      final endDate = DateTime.parse(end);
      return "${startDate.day} - ${endDate.day} ${DateFormat('MMMM yyyy', 'ar').format(endDate)}";
    } catch (e) {
      return "";
    }
  }
}
