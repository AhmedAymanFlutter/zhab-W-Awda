import 'package:flutter/material.dart';
import 'package:flutter_application_1/core/router/routes.dart';
import 'package:flutter_application_1/featuer/bookings/data/model/my_bookings_model.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'booking_card_components/booking_card_header.dart';
import 'booking_card_components/booking_card_content.dart';
import 'booking_card_components/booking_card_actions.dart';

class BookingCard extends StatelessWidget {
  final BookingItem booking;

  const BookingCard({super.key, required this.booking});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 343.w,
      height: 201.h,
      padding: EdgeInsets.only(
        top: 10.h,
        right: 10.w,
        bottom: 12.h,
        left: 10.w,
      ),
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
          // 1. Header
          BookingCardHeader(
            status: booking.status ?? "تم التأكيد",
            bookingNumber: booking.bookingNumber ?? "",
          ),

          SizedBox(height: 4.h),

          // 2. Content
          Expanded(
            child: BookingCardContent(
              description:
                  booking.description ?? "رحلة متكاملة لاستكشاف الوجهات",
              city: booking.city ?? "",
              country: booking.country ?? "",
              startDate: booking.startDate,
              endDate: booking.endDate,
              adultsCount: booking.adultsCount ?? 0,
              imageCover: booking.imageCover ?? "",
            ),
          ),

          SizedBox(height: 8.h),

          // 3. Actions
          BookingCardActions(
            onDetailsTap: () {
              Navigator.pushNamed(
                context,
                Routes.bookingDetailsView,
                arguments: booking.id,
              );
            },
            onReceiptTap: () {},
          ),
        ],
      ),
    );
  }
}
