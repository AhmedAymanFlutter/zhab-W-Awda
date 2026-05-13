import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../core/theme/app_text_style.dart';

class BookingCardHeader extends StatelessWidget {
  final String status;
  final String bookingNumber;

  const BookingCardHeader({
    super.key,
    required this.status,
    required this.bookingNumber,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Container(
          padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 4.h),
          decoration: BoxDecoration(
            color: const Color(0xFFE7F4EE),
            borderRadius: BorderRadius.circular(8.r),
          ),
          child: Text(
            status,
            style: TextStyle(
              color: const Color(0xFF0D9488),
              fontSize: 12.sp,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        Text(
          "رقم الحجز: #$bookingNumber",
          style: AppTextStyle.setelMessiriBlack(
            fontSize: 14,
            fontWeight: FontWeight.normal,
          ).copyWith(color: const Color(0xFF1D2939)),
        ),
      ],
    );
  }
}
