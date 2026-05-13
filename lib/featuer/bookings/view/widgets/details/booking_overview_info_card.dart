import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/core/theme/app_text_style.dart';
import 'package:flutter_application_1/featuer/bookings/data/model/booking_details_model.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';

class BookingOverviewInfoCard extends StatelessWidget {
  final BookingDetail booking;

  const BookingOverviewInfoCard({super.key, required this.booking});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(12.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      booking.package?.name ?? "",
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      textAlign: TextAlign.right,
                      style: AppTextStyle.setelMessiriBlack(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 4.h),
                    Text(
                      "رقم الحجز: #${booking.id?.substring(0, 8).toUpperCase()}",
                      style: AppTextStyle.setelMessiriTextStyle(
                        fontSize: 14,
                        color: const Color(0xFF667085),
                        fontWeight: FontWeight.normal,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(width: 12.w),
              ClipRRect(
                borderRadius: BorderRadius.circular(12.r),
                child: CachedNetworkImage(
                  imageUrl: booking.package?.imageCover ?? "",
                  width: 60.w,
                  height: 60.h,
                  fit: BoxFit.cover,
                  placeholder: (context, url) =>
                      Container(color: Colors.grey[200]),
                  errorWidget: (context, url, error) => const Icon(Icons.error),
                ),
              ),
            ],
          ),

          Divider(height: 24.h, color: Colors.grey[200]),

          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Text(
                _formatDateRange(booking.startDate, booking.endDate),
                style: AppTextStyle.setelMessiriTextStyle(
                  fontSize: 14,
                  color: const Color(0xFF667085),
                  fontWeight: FontWeight.normal,
                ),
              ),
              SizedBox(width: 8.w),
              Icon(
                Icons.calendar_today_outlined,
                size: 16.sp,
                color: const Color(0xFF667085),
              ),

              SizedBox(width: 16.w),

              Text(
                "3 أشخاص، 0 طفل", // This would ideally come from the API if available
                style: AppTextStyle.setelMessiriTextStyle(
                  fontSize: 14,
                  color: const Color(0xFF667085),
                  fontWeight: FontWeight.normal,
                ),
              ),
              SizedBox(width: 8.w),
              Icon(
                Icons.people_outline,
                size: 16.sp,
                color: const Color(0xFF667085),
              ),
            ],
          ),
        ],
      ),
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
