import 'package:flutter/material.dart';
import 'package:flutter_application_1/core/theme/app_color.dart';
import 'package:flutter_application_1/featuer/flightBooking/manager/book_flight_cubit.dart';
import 'package:flutter_application_1/featuer/flightBooking/manager/book_flight_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart' as intl;
import 'custom_flight_input.dart';

class FlightSearchForm extends StatelessWidget {
  const FlightSearchForm({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BookFlightCubit, BookFlightState>(
      buildWhen: (previous, current) =>
          current is BookFlightTripTypeChanged || current is BookFlightInitial,
      builder: (context, state) {
        final cubit = context.read<BookFlightCubit>();

        return Container(
          margin: EdgeInsets.symmetric(horizontal: 16.w),
          padding: EdgeInsets.all(20.w),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20.r),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.05),
                blurRadius: 15,
                spreadRadius: 5,
                offset: const Offset(0, 5),
              )
            ],
          ),
          child: Form(
            key: cubit.formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              textDirection: TextDirection.rtl,
              children: [
                Center(
                  child: Text(
                    "خطط لرحلتك معنا",
                    style: TextStyle(
                      fontSize: 20.sp,
                      fontWeight: FontWeight.w900,
                      color: Colors.black,
                    ),
                  ),
                ),
                SizedBox(height: 8.h),
                Center(
                  child: Text(
                    "شاركنا وجهتك وتواريخ السفر، وسيتواصل معك فريقنا لتأكيد الحجز وتقديم أفضل العروض المتاحة.",
                    style: TextStyle(
                      fontSize: 12.sp,
                      color: Colors.grey.shade700,
                      height: 1.5,
                      fontWeight: FontWeight.w500,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
                SizedBox(height: 24.h),

                // Toggle
                Container(
                  decoration: BoxDecoration(
                    color: Colors.grey.shade100,
                    borderRadius: BorderRadius.circular(12.r),
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        child: GestureDetector(
                          onTap: () => cubit.changeTripType(true),
                          child: Container(
                            padding: EdgeInsets.symmetric(vertical: 12.h),
                            decoration: BoxDecoration(
                              color: cubit.isRoundTrip
                                  ? AppColor.primaryBlue
                                  : Colors.transparent,
                              borderRadius: BorderRadius.circular(12.r),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.swap_horiz,
                                  color: cubit.isRoundTrip
                                      ? Colors.white
                                      : Colors.black87,
                                  size: 20.sp,
                                ),
                                SizedBox(width: 8.w),
                                Text(
                                  "ذهاب وعودة",
                                  style: TextStyle(
                                    fontSize: 14.sp,
                                    fontWeight: FontWeight.bold,
                                    color: cubit.isRoundTrip
                                        ? Colors.white
                                        : Colors.black87,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        child: GestureDetector(
                          onTap: () => cubit.changeTripType(false),
                          child: Container(
                            padding: EdgeInsets.symmetric(vertical: 12.h),
                            decoration: BoxDecoration(
                              color: !cubit.isRoundTrip
                                  ? AppColor.primaryBlue
                                  : Colors.transparent,
                              borderRadius: BorderRadius.circular(12.r),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.arrow_back,
                                  color: !cubit.isRoundTrip
                                      ? Colors.white
                                      : Colors.black87,
                                  size: 20.sp,
                                ),
                                SizedBox(width: 8.w),
                                Text(
                                  "ذهاب فقط",
                                  style: TextStyle(
                                    fontSize: 14.sp,
                                    fontWeight: FontWeight.bold,
                                    color: !cubit.isRoundTrip
                                        ? Colors.white
                                        : Colors.black87,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 24.h),

                // Cities
                Row(
                  textDirection: TextDirection.rtl,
                  children: [
                    Expanded(
                      child: CustomFlightInput(
                        label: "المغادرة من",
                        labelIcon: Icons.location_on_outlined,
                        hint: "نقطة المغادرة",
                        controller: cubit.fromCityController,
                        trailing: Icon(Icons.keyboard_arrow_down,
                            color: Colors.grey, size: 20.sp),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 8.w),
                      child: Container(
                        padding: EdgeInsets.all(8.w),
                        margin: EdgeInsets.only(top: 24.h), // Align with inputs
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(8.r),
                          border: Border.all(color: Colors.grey.shade300),
                        ),
                        child: Icon(Icons.swap_horiz,
                            color: Colors.black87, size: 20.sp),
                      ),
                    ),
                    Expanded(
                      child: CustomFlightInput(
                        label: "الوصول الي",
                        labelIcon: Icons.location_on_outlined,
                        hint: "نقطة الوصول",
                        controller: cubit.toCityController,
                        trailing: Icon(Icons.keyboard_arrow_down,
                            color: Colors.grey, size: 20.sp),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 16.h),

                // Dates
                Row(
                  textDirection: TextDirection.rtl,
                  children: [
                    Expanded(
                      child: StatefulBuilder(
                        builder: (context, setState) => CustomFlightInput(
                          label: "اختر التاريخ",
                          labelIcon: Icons.date_range_outlined,
                          hint: cubit.departureDate != null
                              ? intl.DateFormat('MM-dd-yyyy')
                                  .format(cubit.departureDate!)
                              : "mm-dd-yyyy",
                          readOnly: true,
                          trailing: Icon(Icons.calendar_month_outlined,
                              color: Colors.grey, size: 20.sp),
                          onTap: () async {
                            final date = await showDatePicker(
                              context: context,
                              initialDate: DateTime.now(),
                              firstDate: DateTime.now(),
                              lastDate: DateTime(2030),
                            );
                            if (date != null) {
                              cubit.departureDate = date;
                              setState(() {});
                            }
                          },
                        ),
                      ),
                    ),
                    SizedBox(width: 16.w),
                    Expanded(
                      child: StatefulBuilder(
                        builder: (context, setState) => CustomFlightInput(
                          label: "تاريخ العودة",
                          labelIcon: Icons.date_range_outlined,
                          hint: !cubit.isRoundTrip
                              ? "لا يوجد"
                              : cubit.returnDate != null
                                  ? intl.DateFormat('MM-dd-yyyy')
                                      .format(cubit.returnDate!)
                                  : "mm-dd-yyyy",
                          readOnly: true,
                          trailing: Icon(Icons.calendar_month_outlined,
                              color: Colors.grey, size: 20.sp),
                          onTap: cubit.isRoundTrip
                              ? () async {
                                  final date = await showDatePicker(
                                    context: context,
                                    initialDate: cubit.departureDate ?? DateTime.now(),
                                    firstDate: cubit.departureDate ?? DateTime.now(),
                                    lastDate: DateTime(2030),
                                  );
                                  if (date != null) {
                                    cubit.returnDate = date;
                                    setState(() {});
                                  }
                                }
                              : null,
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 16.h),

                // Passengers & Phone
                Row(
                  textDirection: TextDirection.rtl,
                  children: [
                    Expanded(
                      child: CustomFlightInput(
                        label: "المسافرون",
                        labelIcon: Icons.people_outline,
                        hint: "1 بالغ",
                        controller: cubit.passengersController,
                        trailing: Icon(Icons.keyboard_arrow_down,
                            color: Colors.grey, size: 20.sp),
                      ),
                    ),
                    SizedBox(width: 16.w),
                    Expanded(
                      child: CustomFlightInput(
                        label: "رقم الجوال",
                        labelIcon: Icons.phone_outlined,
                        hint: "رقم الهاتف",
                        controller: cubit.phoneController,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 24.h),

                // Hidden fields for Name and Email just to satisfy the old API constraint, 
                // ideally this API should be updated or user profile data used.
                // Assuming we fill them with placeholder if empty
                Visibility(
                  visible: false,
                  maintainState: true,
                  child: Column(
                    children: [
                      TextFormField(controller: cubit.nameController),
                      TextFormField(controller: cubit.emailController),
                    ],
                  ),
                ),

                // Action Buttons
                Row(
                  textDirection: TextDirection.rtl,
                  children: [
                    Expanded(
                      child: BlocBuilder<BookFlightCubit, BookFlightState>(
                        builder: (context, submitState) {
                          return ElevatedButton(
                            onPressed: submitState is BookFlightLoading
                                ? null
                                : () {
                                    if (cubit.nameController.text.isEmpty) {
                                      cubit.nameController.text = "Guest User";
                                    }
                                    if (cubit.emailController.text.isEmpty) {
                                      cubit.emailController.text =
                                          "guest@test.com";
                                    }
                                    cubit.submitBooking();
                                  },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: AppColor.primaryBlue,
                              padding: EdgeInsets.symmetric(vertical: 14.h),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12.r),
                              ),
                            ),
                            child: submitState is BookFlightLoading
                                ? SizedBox(
                                    height: 20.h,
                                    width: 20.h,
                                    child: const CircularProgressIndicator(
                                        color: Colors.white, strokeWidth: 2),
                                  )
                                : Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        "تأكيد الطلب",
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 14.sp,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      SizedBox(width: 8.w),
                                      Icon(Icons.send_outlined,
                                          color: Colors.white, size: 18.sp),
                                    ],
                                  ),
                          );
                        },
                      ),
                    ),
                    SizedBox(width: 12.w),
                    Expanded(
                      child: OutlinedButton(
                        onPressed: () {
                          // TODO: Launch WhatsApp URL
                          ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(content: Text("سيتم فتح واتساب...")));
                        },
                        style: OutlinedButton.styleFrom(
                          padding: EdgeInsets.symmetric(vertical: 14.h),
                          side: BorderSide(color: Colors.grey.shade300),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12.r),
                          ),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "تواصل واتساب",
                              style: TextStyle(
                                color: Colors.black87,
                                fontSize: 14.sp,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(width: 8.w),
                            Icon(Icons.message_outlined, // Fallback icon instead of FontAwesome whatsapp
                                color: Colors.green,
                                size: 18.sp),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
