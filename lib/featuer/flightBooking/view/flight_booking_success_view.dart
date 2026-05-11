import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import '../../../../core/theme/app_color.dart';
import '../../../../core/router/routes.dart';
import '../../../../core/widgets/custom_button.dart';
import '../data/model/book_flight_request_model.dart';
import 'widgets/success_view_widgets.dart';

class FlightBookingSuccessView extends StatelessWidget {
  final BookFlightRequestModel bookingDetails;

  const FlightBookingSuccessView({super.key, required this.bookingDetails});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.primaryWhite,
      body: SafeArea(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 24.w),
            child: Column(
              children: [
                const BookingSuccessHeader(
                  title: "تم إرسال طلبك بنجاح!",
                  subtitle: "سيتواصل معك فريقنا في أقرب وقت لتأكيد الحجز وتقديم أفضل العروض.",
                ),

                SizedBox(height: 32.h),

                // Booking Details Card
                SuccessInfoCard(
                  title: "تفاصيل الرحلة",
                  icon: Icons.flight_takeoff,
                  children: [
                    SuccessInfoRow(label: "من", value: bookingDetails.fromCity),
                    SuccessInfoRow(label: "إلى", value: bookingDetails.toCity),
                    SuccessInfoRow(
                      label: "تاريخ المغادرة",
                      value: _formatDate(bookingDetails.departureDate),
                    ),
                    if (bookingDetails.departureDate != bookingDetails.returnDate)
                      SuccessInfoRow(
                        label: "تاريخ العودة",
                        value: _formatDate(bookingDetails.returnDate),
                      ),
                    SuccessInfoRow(
                      label: "عدد المسافرين",
                      value: "${bookingDetails.passengers}",
                    ),
                  ],
                ),

                // Customer Info Card
                SuccessInfoCard(
                  title: "معلومات التواصل",
                  icon: Icons.person_outline,
                  children: [
                    SuccessInfoRow(label: "الاسم", value: bookingDetails.name),
                    SuccessInfoRow(label: "رقم الجوال", value: bookingDetails.phone),
                    SuccessInfoRow(label: "البريد الإلكتروني", value: bookingDetails.email),
                  ],
                ),

                SizedBox(height: 24.h),

                // Back to Home Button
                CustomButton(
                  text: "العودة للرئيسية",
                  width: double.infinity,
                  onPressed: () {
                    Navigator.pushNamedAndRemoveUntil(
                      context,
                      Routes.layout,
                      (route) => false,
                    );
                  },
                ),
                SizedBox(height: 20.h),
              ],
            ),
          ),
        ),
      ),
    );
  }

  String _formatDate(String? dateStr) {
    if (dateStr == null || dateStr.isEmpty) return "N/A";
    try {
      final date = DateTime.parse(dateStr);
      return DateFormat('yyyy-MM-dd').format(date);
    } catch (e) {
      return dateStr;
    }
  }
}
