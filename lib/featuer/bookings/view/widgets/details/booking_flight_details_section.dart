import 'package:flutter/material.dart';
import 'package:flutter_application_1/core/utils/date_formatter.dart';
import 'package:flutter_application_1/featuer/bookings/data/model/booking_details_model.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'components/booking_location_item.dart';

class BookingFlightDetailsSection extends StatelessWidget {
  final FlightDetail flight;

  const BookingFlightDetailsSection({super.key, required this.flight});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 343.w,
      height: 136.h,
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
      child: Row(
        children: [
          // TO
          Expanded(
            child: BookingLocationItem(
              label: "إلى",
              city: flight.to?.city ?? "",
              country: flight.to?.country ?? "",
              airport: flight.to?.airport ?? "",
              formattedDateTime: DateFormatter.formatArabicDateTime(
                flight.to?.date,
              ),
              isLeft: true,
            ),
          ),

          // Icon
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 8.w),
            child: SvgPicture.asset(
              'assets/icon/Union.svg',
              width: 24.w,
              height: 24.h,
              colorFilter: const ColorFilter.mode(
                Color(0xFF98A2B3),
                BlendMode.srcIn,
              ),
            ),
          ),

          // FROM
          Expanded(
            child: BookingLocationItem(
              label: "من",
              city: flight.from?.city ?? "",
              country: flight.from?.country ?? "",
              airport: flight.from?.airport ?? "",
              formattedDateTime: DateFormatter.formatArabicDateTime(
                flight.from?.date,
              ),
              isLeft: false,
            ),
          ),
        ],
      ),
    );
  }
}
