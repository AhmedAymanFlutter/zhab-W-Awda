import 'package:flutter/material.dart';
import 'package:flutter_application_1/core/theme/app_text_style.dart';
import 'package:flutter_application_1/featuer/bookings/data/model/booking_details_model.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:pretty_qr_code/pretty_qr_code.dart';

class BookingHotelDetailsSection extends StatelessWidget {
  final HotelDetail hotel;

  const BookingHotelDetailsSection({super.key, required this.hotel});

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
          Text(
            "تفاصيل الفندق",
            style: AppTextStyle.setelMessiriTextStyle(
              fontSize: 14,
              color: const Color(0xFF667085),
              fontWeight: FontWeight.normal,
            ),
          ),
          SizedBox(height: 12.h),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    hotel.title ?? "",
                    style: AppTextStyle.setelMessiriBlack(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    hotel.roomType ?? "",
                    style: AppTextStyle.setelMessiriTextStyle(
                      fontSize: 14,
                      color: const Color(0xFF12B76A),
                      fontWeight: FontWeight.normal,
                    ),
                  ),
                ],
              ),
              SizedBox(width: 12.w),
              ClipRRect(
                borderRadius: BorderRadius.circular(8.r),
                child: Container(
                  width: 50.w,
                  height: 50.h,
                  color: Colors.grey[200],
                  child: const Icon(Icons.hotel, color: Colors.grey),
                ),
              ),
            ],
          ),
          SizedBox(height: 24.h),
          Row(
            children: [
              Expanded(
                child: _buildInfoItem(
                  label: "مغادرة",
                  value: _formatDate(hotel.departureDate),
                  subValue: "من 12:00 ظهراً",
                ),
              ),
              Container(width: 1, height: 40.h, color: Colors.grey[200]),
              Expanded(
                child: _buildInfoItem(
                  label: "وصول",
                  value: _formatDate(hotel.arrivalDate),
                  subValue: "من 12:00 ظهراً",
                ),
              ),
            ],
          ),
          SizedBox(height: 24.h),
          Row(
            children: [
              Expanded(
                child: _buildInfoItem(
                  label: "عدد الليالي",
                  value: "${hotel.daysCount} أيام، ${hotel.nightsCount} ليالٍ",
                ),
              ),
              Container(width: 1, height: 40.h, color: Colors.grey[200]),
              Expanded(
                child: _buildInfoItem(
                  label: "الضيوف",
                  value:
                      "${hotel.roomsCount} غرفة، 2 بالغين", // Hardcoded 2 adults as per design or logic
                ),
              ),
            ],
          ),
          SizedBox(height: 32.h),
          Center(
            child: SizedBox(
              width: 120.w,
              height: 120.w,
              child: PrettyQrView.data(
                data: hotel.title ?? "Zhab W Auda Booking",
                decoration: const PrettyQrDecoration(
                  shape: PrettyQrSmoothSymbol(color: Color(0xFF00276C)),
                ),
              ),
            ),
          ),
          SizedBox(height: 8.h),
          Center(
            child: Text(
              "2 3456 78 901234",
              style: TextStyle(
                fontSize: 14.sp,
                letterSpacing: 2,
                color: Colors.black,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInfoItem({
    required String label,
    required String value,
    String? subValue,
  }) {
    return Column(
      children: [
        Text(
          label,
          style: AppTextStyle.setelMessiriTextStyle(
            fontSize: 12,
            color: const Color(0xFF667085),
            fontWeight: FontWeight.normal,
          ),
        ),
        SizedBox(height: 4.h),
        Text(
          value,
          style: AppTextStyle.setelMessiriBlack(
            fontSize: 14,
            fontWeight: FontWeight.bold,
          ),
        ),
        if (subValue != null)
          Text(
            subValue,
            style: AppTextStyle.setelMessiriTextStyle(
              fontSize: 12,
              color: const Color(0xFF667085),
              fontWeight: FontWeight.normal,
            ),
          ),
      ],
    );
  }

  String _formatDate(String? dateStr) {
    if (dateStr == null) return "";
    try {
      final date = DateTime.parse(dateStr);
      return DateFormat('d مايو yyyy', 'ar').format(date);
    } catch (e) {
      return "";
    }
  }
}
