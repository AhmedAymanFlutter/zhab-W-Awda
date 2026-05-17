import 'package:flutter/material.dart';
import 'package:flutter_application_1/core/theme/app_text_style.dart';
import 'package:flutter_application_1/core/utils/date_formatter.dart';
import 'package:flutter_application_1/featuer/bookings/data/model/booking_details_model.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'components/booking_info_item.dart';
import 'components/booking_barcode_widget.dart';

class BookingHotelDetailsSection extends StatelessWidget {
  final HotelDetail hotel;

  const BookingHotelDetailsSection({super.key, required this.hotel});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 343.w,
      padding: EdgeInsets.all(12.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        mainAxisSize: MainAxisSize.min,
        children: [
          // Header
          Text(
            "تفاصيل الفندق",
            style: AppTextStyle.setelMessiriTextStyle(
              fontSize: 12,
              color: const Color(0xFF98A2B3),
              fontWeight: FontWeight.normal,
            ),
          ),
          SizedBox(height: 8.h),

          // Hotel Name & Image
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      hotel.title ?? "",
                      textAlign: TextAlign.right,
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
              ),
              SizedBox(width: 12.w),
              ClipRRect(
                borderRadius: BorderRadius.circular(8.r),
                child: Container(
                  width: 50.w,
                  height: 50.h,
                  color: Colors.grey[200],
                  child: hotel.isOurHotel == true
                      ? const Icon(Icons.hotel, color: Colors.grey)
                      : Image.asset(
                          'assets/photo/hotel_placeholder.webp',
                          fit: BoxFit.cover,
                          errorBuilder: (context, error, stackTrace) =>
                              const Icon(Icons.hotel, color: Colors.grey),
                        ),
                ),
              ),
            ],
          ),

          SizedBox(height: 16.h),

          // Row 1: Arrival & Departure
          Row(
            children: [
              Expanded(
                child: BookingInfoItem(
                  label: "مغادرة",
                  value: DateFormatter.formatArabicDate(hotel.departureDate),
                  subValue: "من 12:00 ظهراً",
                ),
              ),
              Container(width: 1, height: 36.h, color: const Color(0xFFF2F4F7)),
              Expanded(
                child: BookingInfoItem(
                  label: "وصول",
                  value: DateFormatter.formatArabicDate(hotel.arrivalDate),
                  subValue: "من 12:00 ظهراً",
                ),
              ),
            ],
          ),

          SizedBox(height: 16.h),

          // Row 2: Guests & Nights
          Row(
            children: [
              Expanded(
                child: BookingInfoItem(
                  label: "عدد الليالي",
                  value: "${hotel.daysCount ?? 0} أيام، ${hotel.nightsCount ?? 0} ليالٍ",
                ),
              ),
              Container(width: 1, height: 36.h, color: const Color(0xFFF2F4F7)),
              Expanded(
                child: BookingInfoItem(
                  label: "الضيوف",
                  value: "${hotel.roomsCount ?? 1} غرفة، 2 بالغين",
                ),
              ),
            ],
          ),

          SizedBox(height: 16.h),

          // Divider
          const Divider(color: Color(0xFFF2F4F7), thickness: 1),

          SizedBox(height: 12.h),

          // Barcode Section
          const BookingBarcodeWidget(
            barcodeData: "2345678901234",
            displayCode: "2 3456 78 901234",
          ),
        ],
      ),
    );
  }
}
