import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import '../../../../core/theme/app_color.dart';
import '../../../../core/theme/app_text_style.dart';
import '../../../../core/router/routes.dart';
import '../data/model/book_flight_request_model.dart';

class FlightBookingSuccessView extends StatelessWidget {
  final BookFlightRequestModel bookingDetails;

  const FlightBookingSuccessView({super.key, required this.bookingDetails});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FB),
      body: SafeArea(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 24.w),
            child: Column(
              children: [
                SizedBox(height: 40.h),

                // Success Icon Section
                Container(
                  padding: EdgeInsets.all(20.w),
                  decoration: BoxDecoration(
                    color: Colors.green.withOpacity(0.1),
                    shape: BoxShape.circle,
                  ),
                  child: Container(
                    padding: EdgeInsets.all(15.w),
                    decoration: const BoxDecoration(
                      color: Colors.green,
                      shape: BoxShape.circle,
                    ),
                    child: Icon(Icons.check, color: Colors.white, size: 40.sp),
                  ),
                ),
                SizedBox(height: 24.h),

                Text(
                  "تم إرسال طلبك بنجاح!",
                  style: AppTextStyle.setelMessiriBlack(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 8.h),
                Text(
                  "سيتواصل معك فريقنا في أقرب وقت لتأكيد الحجز وتقديم أفضل العروض.",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 14.sp,
                    color: Colors.grey.shade600,
                    height: 1.5,
                  ),
                ),

                SizedBox(height: 32.h),

                // Booking Details Card
                _buildInfoCard(
                  title: "تفاصيل الرحلة",
                  icon: Icons.flight_takeoff,
                  children: [
                    _buildInfoRow("من", bookingDetails.fromCity),
                    _buildInfoRow("إلى", bookingDetails.toCity),
                    _buildInfoRow(
                      "تاريخ المغادرة",
                      _formatDate(bookingDetails.departureDate),
                    ),
                    if (bookingDetails.departureDate !=
                        bookingDetails.returnDate)
                      _buildInfoRow(
                        "تاريخ العودة",
                        _formatDate(bookingDetails.returnDate),
                      ),
                    _buildInfoRow(
                      "عدد المسافرين",
                      "${bookingDetails.passengers}",
                    ),
                  ],
                ),

                SizedBox(height: 16.h),

                // Customer Info Card
                _buildInfoCard(
                  title: "معلومات التواصل",
                  icon: Icons.person_outline,
                  children: [
                    _buildInfoRow("الاسم", bookingDetails.name),
                    _buildInfoRow("رقم الجوال", bookingDetails.phone),
                    _buildInfoRow("البريد الإلكتروني", bookingDetails.email),
                  ],
                ),

                SizedBox(height: 40.h),

                // Back to Home Button
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.pushNamedAndRemoveUntil(
                        context,
                        Routes.layout,
                        (route) => false,
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColor.primaryBlue,
                      padding: EdgeInsets.symmetric(vertical: 16.h),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16.r),
                      ),
                      elevation: 0,
                    ),
                    child: Text(
                      "العودة للرئيسية",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16.sp,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 20.h),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildInfoCard({
    required String title,
    required IconData icon,
    required List<Widget> children,
  }) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.03),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.all(16.w),
            child: Row(
              children: [
                Icon(icon, color: AppColor.primaryBlue, size: 20.sp),
                SizedBox(width: 8.w),
                Text(
                  title,
                  style: AppTextStyle.setelMessiriBlack(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
          const Divider(height: 1),
          Padding(
            padding: EdgeInsets.all(16.w),
            child: Column(children: children),
          ),
        ],
      ),
    );
  }

  Widget _buildInfoRow(String label, String value) {
    return Padding(
      padding: EdgeInsets.only(bottom: 12.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: TextStyle(
              fontSize: 14.sp,
              color: Colors.grey.shade600,
              fontWeight: FontWeight.w500,
            ),
          ),
          Text(
            value,
            style: TextStyle(
              fontSize: 14.sp,
              color: Colors.black,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }

  String _formatDate(String? dateStr) {
    if (dateStr == null) return "N/A";
    try {
      final date = DateTime.parse(dateStr);
      return DateFormat('yyyy-MM-dd').format(date);
    } catch (e) {
      return dateStr;
    }
  }
}
