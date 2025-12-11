// lib/features/flight_booking/view/book_flight_view.dart

import 'package:flutter/material.dart';
import 'package:flutter_application_1/featuer/flightBooking/manager/book_flight_cubit.dart';
import 'package:flutter_application_1/featuer/flightBooking/manager/book_flight_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import '../../../../core/theme/app_color.dart';
import '../data/repo/flight_booking_repository.dart';

class BookFlightView extends StatelessWidget {
  const BookFlightView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => BookFlightCubit(FlightBookingRepository()),
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: AppColor.primaryBlue, // Dark Blue from screenshot
          title: Text(
            "نموذج الحجز",
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 18.sp,
            ),
          ),
          centerTitle: true,
          leading: const BackButton(color: Colors.white),
        ),
        body: BlocConsumer<BookFlightCubit, BookFlightState>(
          listener: (context, state) {
            if (state is BookFlightSuccess) {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text("تم إرسال طلب الحجز بنجاح ✅"),
                  backgroundColor: Colors.green,
                ),
              );
              Navigator.pop(context);
            } else if (state is BookFlightError) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(state.message),
                  backgroundColor: Colors.red,
                ),
              );
            }
          },
          builder: (context, state) {
            final cubit = context.read<BookFlightCubit>();

            return SingleChildScrollView(
              padding: EdgeInsets.all(16.w),
              child: Form(
                key: cubit.formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // --- 1. Personal Information Section ---
                    _buildSectionTitle("المعلومات الشخصية"),
                    SizedBox(height: 16.h),

                    _buildLabel("الاسم الكامل"),
                    _buildTextField(
                      controller: cubit.nameController,
                      hint: "أدخل اسمك الكامل",
                      icon: Icons.person_outline,
                    ),

                    SizedBox(height: 16.h),
                    _buildLabel("البريد الإلكتروني"),
                    _buildTextField(
                      controller: cubit.emailController,
                      hint: "example@email.com",
                      icon: Icons.email_outlined,
                      inputType: TextInputType.emailAddress,
                    ),

                    SizedBox(height: 16.h),
                    _buildLabel("رقم الهاتف"),
                    _buildTextField(
                      controller: cubit.phoneController,
                      hint: "+20 123 456 7890",
                      icon: Icons.phone_outlined,
                      inputType: TextInputType.phone,
                    ),

                    SizedBox(height: 16.h),
                    _buildLabel("عدد المسافرين"),
                    _buildTextField(
                      controller: cubit.passengersController,
                      hint: "1",
                      inputType: TextInputType.number,
                    ),

                    SizedBox(height: 32.h),
                    const Divider(thickness: 1),
                    SizedBox(height: 16.h),

                    // --- 2. Flight Information Section ---
                    _buildSectionTitle("معلومات الرحلة"),
                    SizedBox(height: 16.h),

                    _buildLabel("مدينة المغادرة"),
                    _buildTextField(
                      controller: cubit.fromCityController,
                      hint: "مثال: القاهرة",
                    ),

                    SizedBox(height: 16.h),
                    _buildLabel("مدينة الوصول"),
                    _buildTextField(
                      controller: cubit.toCityController,
                      hint: "مثال: دبي",
                    ),

                    SizedBox(height: 16.h),
                    _buildLabel("تاريخ المغادرة"),
                    _buildDatePickerField(
                      context,
                      hint: "اختر التاريخ",
                      selectedDate: cubit.departureDate,
                      onDateSelected: (date) {
                        cubit.departureDate = date;
                        // Force rebuild to show selected date text
                        (context as Element).markNeedsBuild();
                      },
                    ),

                    SizedBox(height: 16.h),
                    _buildLabel("تاريخ العودة"),
                    _buildDatePickerField(
                      context,
                      hint: "اختر التاريخ",
                      selectedDate: cubit.returnDate,
                      onDateSelected: (date) {
                        cubit.returnDate = date;
                        (context as Element).markNeedsBuild();
                      },
                    ),

                    SizedBox(height: 40.h),

                    // --- Confirm Button ---
                    SizedBox(
                      width: double.infinity,
                      height: 50.h,
                      child: ElevatedButton(
                        onPressed: state is BookFlightLoading
                            ? null
                            : () {
                                cubit.submitBooking();
                              },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColor
                              .primaryBlue, // Match screenshot header color
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12.r),
                          ),
                        ),
                        child: state is BookFlightLoading
                            ? const CircularProgressIndicator(
                                color: Colors.white,
                              )
                            : Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  const Icon(
                                    Icons.check_circle_outline,
                                    color: Colors.white,
                                  ),
                                  SizedBox(width: 8.w),
                                  Text(
                                    "تأكيد الحجز",
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16.sp,
                                    ),
                                  ),
                                ],
                              ),
                      ),
                    ),
                    SizedBox(height: 20.h),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  // --- Helper Widgets to Match Design ---

  Widget _buildSectionTitle(String title) {
    return Align(
      alignment: Alignment.centerRight,
      child: Text(
        title,
        style: TextStyle(
          fontSize: 18.sp,
          fontWeight: FontWeight.bold,
          color: AppColor.primaryBlue,
        ),
      ),
    );
  }

  Widget _buildLabel(String label) {
    return Padding(
      padding: EdgeInsets.only(bottom: 8.h),
      child: Align(
        alignment: Alignment.centerRight,
        child: Text(
          label,
          style: TextStyle(
            fontSize: 14.sp,
            fontWeight: FontWeight.w600,
            color: Colors.black87,
          ),
        ),
      ),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String hint,
    IconData? icon,
    TextInputType inputType = TextInputType.text,
  }) {
    return TextFormField(
      controller: controller,
      keyboardType: inputType,
      textAlign: TextAlign.right, // Because Arabic
      decoration: InputDecoration(
        hintText: hint,
        hintStyle: TextStyle(color: Colors.grey, fontSize: 12.sp),
        prefixIcon: icon != null ? Icon(icon, color: Colors.grey) : null,
        filled: true,
        fillColor: Colors.white,
        contentPadding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 14.h),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12.r),
          borderSide: BorderSide(color: Colors.grey.shade300),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12.r),
          borderSide: BorderSide(color: Colors.grey.shade300),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12.r),
          borderSide: const BorderSide(color: AppColor.primaryBlue),
        ),
      ),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return "هذا الحقل مطلوب";
        }
        return null;
      },
    );
  }

  Widget _buildDatePickerField(
    BuildContext context, {
    required String hint,
    required DateTime? selectedDate,
    required Function(DateTime) onDateSelected,
  }) {
    return InkWell(
      onTap: () async {
        final DateTime? picked = await showDatePicker(
          context: context,
          initialDate: DateTime.now(),
          firstDate: DateTime.now(),
          lastDate: DateTime(2030),
        );
        if (picked != null) {
          onDateSelected(picked);
        }
      },
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 14.h),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12.r),
          border: Border.all(color: Colors.grey.shade300),
        ),
        child: Row(
          children: [
            Icon(Icons.calendar_today, color: Colors.grey, size: 20.sp),
            const Spacer(),
            Text(
              selectedDate != null
                  ? DateFormat('yyyy-MM-dd').format(selectedDate)
                  : hint,
              style: TextStyle(
                color: selectedDate != null ? Colors.black : Colors.grey,
                fontSize: 14.sp,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
