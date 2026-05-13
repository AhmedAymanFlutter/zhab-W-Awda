import 'package:flutter/material.dart';
import 'package:flutter_application_1/core/theme/app_text_style.dart';
import 'package:flutter_application_1/featuer/bookings/data/model/booking_details_model.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class BookingItineraryTimeline extends StatelessWidget {
  final List<DayDetail> days;

  const BookingItineraryTimeline({super.key, required this.days});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16.r),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Text(
                "برنامج الرحلة",
                style: AppTextStyle.setelMessiriBlack(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(width: 8.w),
              Container(
                padding: EdgeInsets.all(6.w),
                decoration: BoxDecoration(
                  color: const Color(0xFFE6F7FF),
                  borderRadius: BorderRadius.circular(8.r),
                ),
                child: const Icon(Icons.map_outlined, color: Color(0xFF1890FF)),
              ),
            ],
          ),
          SizedBox(height: 20.h),
          ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: days.length,
            itemBuilder: (context, index) {
              final day = days[index];
              return _buildTimelineItem(day, index == days.length - 1);
            },
          ),
        ],
      ),
    );
  }

  Widget _buildTimelineItem(DayDetail day, bool isLast) {
    return IntrinsicHeight(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Timeline indicator (Left side in LTR, Right side in RTL - we use Row with crossEnd)
          Expanded(
            child: Padding(
              padding: EdgeInsets.only(bottom: 20.h),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    "يوم ${day.dayNumber}",
                    style: AppTextStyle.setelMessiriTextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: const Color(0xFF00276C),
                    ),
                  ),
                  SizedBox(height: 4.h),
                  Text(
                    day.customTitle ??
                        day.tour?.descText ??
                        day.city?.name ??
                        "",
                    style: AppTextStyle.setelMessiriBlack(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 4.h),
                  Text(
                    day.customDescription ??
                        day.tour?.description ??
                        day.city?.descText ??
                        "",
                    textAlign: TextAlign.right,
                    style: AppTextStyle.setelMessiriTextStyle(
                      fontSize: 13,
                      color: const Color(0xFF667085),
                      fontWeight: FontWeight.normal,
                    ).copyWith(height: 1.4),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(width: 16.w),
          Column(
            children: [
              Container(
                width: 12.w,
                height: 12.w,
                decoration: const BoxDecoration(
                  color: Color(0xFF00276C),
                  shape: BoxShape.circle,
                ),
              ),
              if (!isLast)
                Expanded(
                  child: Container(width: 2.w, color: Colors.grey[300]),
                ),
            ],
          ),
        ],
      ),
    );
  }
}
