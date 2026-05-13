import 'package:flutter/material.dart';
import 'package:flutter_application_1/core/theme/app_text_style.dart';
import 'package:flutter_application_1/featuer/bookings/data/model/booking_details_model.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';

class BookingFlightDetailsSection extends StatelessWidget {
  final FlightDetail flight;

  const BookingFlightDetailsSection({super.key, required this.flight});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16.r),
      ),
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: _buildLocationItem(
                  label: "إلى",
                  country: flight.to?.country ?? "",
                  city: flight.to?.city ?? "",
                  airport: flight.to?.airport ?? "",
                  date: flight.to?.date,
                  isLeft: true,
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.w),
                child: Icon(
                  Icons.flight_takeoff,
                  color: const Color(0xFF667085),
                  size: 24.sp,
                ),
              ),
              Expanded(
                child: _buildLocationItem(
                  label: "من",
                  country: flight.from?.country ?? "",
                  city: flight.from?.city ?? "",
                  airport: flight.from?.airport ?? "",
                  date: flight.from?.date,
                  isLeft: false,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildLocationItem({
    required String label,
    required String country,
    required String city,
    required String airport,
    String? date,
    required bool isLeft,
  }) {
    return Column(
      crossAxisAlignment: isLeft
          ? CrossAxisAlignment.start
          : CrossAxisAlignment.end,
      children: [
        Text(
          label,
          style: AppTextStyle.setelMessiriTextStyle(
            fontSize: 14,
            color: const Color(0xFF98A2B3),
            fontWeight: FontWeight.normal,
          ),
        ),
        SizedBox(height: 4.h),
        Text(
          "$city، $country",
          style: AppTextStyle.setelMessiriBlack(
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(height: 4.h),
        Text(
          airport,
          textAlign: isLeft ? TextAlign.left : TextAlign.right,
          style: AppTextStyle.setelMessiriTextStyle(
            fontSize: 12,
            color: const Color(0xFF667085),
            fontWeight: FontWeight.normal,
          ),
        ),
        SizedBox(height: 4.h),
        Text(
          _formatDateTime(date),
          style: AppTextStyle.setelMessiriTextStyle(
            fontSize: 12,
            color: const Color(0xFF667085),
            fontWeight: FontWeight.normal,
          ),
        ),
      ],
    );
  }

  String _formatDateTime(String? dateStr) {
    if (dateStr == null) return "";
    try {
      final date = DateTime.parse(dateStr);
      // Format: 15 مايو، 9:30 ص
      final dayMonth = DateFormat('d MMMM', 'ar').format(date);
      final time = DateFormat('h:mm a', 'ar').format(date);
      return "$dayMonth، $time";
    } catch (e) {
      return "";
    }
  }
}
