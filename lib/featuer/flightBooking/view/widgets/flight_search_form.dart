import 'package:flutter/material.dart';
import 'package:flutter_application_1/featuer/flightBooking/manager/book_flight_cubit.dart';
import 'package:flutter_application_1/featuer/flightBooking/manager/book_flight_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart' as intl;
import 'package:flutter_svg/flutter_svg.dart';
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

        return Column(
          children: [
            Center(
              child: Text(
                "خطط لرحلتك معنا",
                style: TextStyle(
                  fontSize: 20.sp,
                  fontWeight: FontWeight.w900,
                  color: Colors.black,
                  fontFamily: 'ElMessiri',
                ),
              ),
            ),
            SizedBox(height: 8.h),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 24.w),
              child: Text(
                "شاركنا وجهتك وتواريخ السفر، وسيتواصل معك فريقنا لتأكيد الحجز وتقديم أفضل العروض المتاحة.",
                style: TextStyle(
                  fontSize: 12.sp,
                  color: Colors.grey.shade700,
                  height: 1.5,
                  fontWeight: FontWeight.w500,
                  fontFamily: 'ElMessiri',
                ),
                textAlign: TextAlign.center,
              ),
            ),
            SizedBox(height: 24.h),

            // Toggle - sits slightly above the card, aligned to the right (start in RTL)
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.w),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start, // Right side in RTL
                textDirection: TextDirection.rtl,
                children: [
                  Container(
                    width: 230.w,
                    height: 44.h,
                    decoration: BoxDecoration(
                      color: const Color(0xFFEAE9EB),
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(16.r),
                        topRight: Radius.circular(16.r),
                      ),
                    ),
                    child: Row(
                      textDirection: TextDirection.rtl,
                      children: [
                        Expanded(
                          child: GestureDetector(
                            onTap: () => cubit.changeTripType(true),
                            child: Container(
                              height: 44.h,
                              decoration: BoxDecoration(
                                color: cubit.isRoundTrip
                                    ? const Color(0xFF00276C)
                                    : Colors.transparent,
                                borderRadius: BorderRadius.only(
                                  topRight: Radius.circular(16.r),
                                ),
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(
                                    Icons.swap_horizontal_circle_outlined,
                                    color: cubit.isRoundTrip
                                        ? Colors.white
                                        : Colors.black,
                                    size: 18.sp,
                                  ),
                                  SizedBox(width: 4.w),
                                  Text(
                                    "ذهاب وعودة",
                                    style: TextStyle(
                                      fontSize: 13.sp,
                                      fontWeight: FontWeight.bold,
                                      color: cubit.isRoundTrip
                                          ? Colors.white
                                          : Colors.black,
                                      fontFamily: 'ElMessiri',
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
                              height: 44.h,
                              decoration: BoxDecoration(
                                color: !cubit.isRoundTrip
                                    ? const Color(0xFF00276C)
                                    : Colors.transparent,
                                borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(16.r),
                                ),
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(
                                    Icons.arrow_circle_left_outlined,
                                    color: !cubit.isRoundTrip
                                        ? Colors.white
                                        : Colors.black,
                                    size: 18.sp,
                                  ),
                                  SizedBox(width: 4.w),
                                  Text(
                                    "ذهاب فقط",
                                    style: TextStyle(
                                      fontSize: 13.sp,
                                      fontWeight: FontWeight.bold,
                                      color: !cubit.isRoundTrip
                                          ? Colors.white
                                          : Colors.black,
                                      fontFamily: 'ElMessiri',
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
                ],
              ),
            ),

            // Main Form Card
            Container(
              width: 344.w,
              constraints: BoxConstraints(minHeight: 348.h),
              margin: EdgeInsets.symmetric(horizontal: 16.w),
              padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 16.h),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20.r),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.08),
                    blurRadius: 20,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: Form(
                key: cubit.formKey,
                child: SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    mainAxisSize: MainAxisSize.min,
                    textDirection: TextDirection.rtl,
                    children: [
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
                              trailing: Icon(
                                Icons.keyboard_arrow_down,
                                color: Colors.grey,
                                size: 18.sp,
                              ),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 4.w),
                            child: Container(
                              padding: EdgeInsets.all(6.w),
                              margin: EdgeInsets.only(top: 24.h),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(8.r),
                                border: Border.all(color: Colors.grey.shade200),
                              ),
                              child: Icon(
                                Icons.swap_horiz,
                                color: Colors.black87,
                                size: 18.sp,
                              ),
                            ),
                          ),
                          Expanded(
                            child: CustomFlightInput(
                              label: "الوصول الي",
                              labelIcon: Icons.location_on_outlined,
                              hint: "نقطة الوصول",
                              controller: cubit.toCityController,
                              trailing: Icon(
                                Icons.keyboard_arrow_down,
                                color: Colors.grey,
                                size: 18.sp,
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 10.h),

                      // Dates
                      Row(
                        textDirection: TextDirection.rtl,
                        children: [
                          Expanded(
                            child: StatefulBuilder(
                              builder: (context, setState) => CustomFlightInput(
                                label: "اختر التاريخ",
                                labelIcon: Icons.calendar_today_outlined,
                                hint: cubit.departureDate != null
                                    ? intl.DateFormat(
                                        'mm-dd-yyyy',
                                      ).format(cubit.departureDate!)
                                    : "mm-dd-yyyy",
                                readOnly: true,
                                trailing: Icon(
                                  Icons.calendar_month_outlined,
                                  color: Colors.grey,
                                  size: 18.sp,
                                ),
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
                          SizedBox(width: 12.w),
                          Expanded(
                            child: StatefulBuilder(
                              builder: (context, setState) => CustomFlightInput(
                                label: "تاريخ العودة",
                                labelIcon: Icons.calendar_month_outlined,
                                hint: !cubit.isRoundTrip
                                    ? "لا يوجد"
                                    : cubit.returnDate != null
                                    ? intl.DateFormat(
                                        'mm-dd-yyyy',
                                      ).format(cubit.returnDate!)
                                    : "mm-dd-yyyy",
                                readOnly: true,
                                trailing: Icon(
                                  Icons.calendar_month_outlined,
                                  color: Colors.grey,
                                  size: 18.sp,
                                ),
                                onTap: cubit.isRoundTrip
                                    ? () async {
                                        final date = await showDatePicker(
                                          context: context,
                                          initialDate:
                                              cubit.departureDate ??
                                              DateTime.now(),
                                          firstDate:
                                              cubit.departureDate ??
                                              DateTime.now(),
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
                      SizedBox(height: 10.h),

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
                              trailing: Icon(
                                Icons.keyboard_arrow_down,
                                color: Colors.grey,
                                size: 18.sp,
                              ),
                            ),
                          ),
                          SizedBox(width: 12.w),
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
                      SizedBox(height: 20.h),

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
                                          if (cubit
                                              .nameController
                                              .text
                                              .isEmpty) {
                                            cubit.nameController.text =
                                                "Guest User";
                                          }
                                          if (cubit
                                              .emailController
                                              .text
                                              .isEmpty) {
                                            cubit.emailController.text =
                                                "guest@test.com";
                                          }
                                          cubit.submitBooking();
                                        },
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: const Color(0xFF00276C),
                                    padding: EdgeInsets.symmetric(
                                      vertical: 12.h,
                                    ),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(30.r),
                                    ),
                                    elevation: 0,
                                  ),
                                  child: submitState is BookFlightLoading
                                      ? SizedBox(
                                          height: 20.h,
                                          width: 20.h,
                                          child:
                                              const CircularProgressIndicator(
                                                color: Colors.white,
                                                strokeWidth: 2,
                                              ),
                                        )
                                      : Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            SvgPicture.asset(
                                              'assets/icon/sent.svg',
                                              height: 20.sp,
                                              width: 20.sp,
                                              colorFilter:
                                                  const ColorFilter.mode(
                                                    Colors.white,
                                                    BlendMode.srcIn,
                                                  ),
                                            ),
                                            SizedBox(width: 8.w),
                                            Text(
                                              "تأكيد الطلب",
                                              style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 14.sp,
                                                fontWeight: FontWeight.bold,
                                                fontFamily: 'ElMessiri',
                                              ),
                                            ),
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
                                // Launch WhatsApp
                              },
                              style: OutlinedButton.styleFrom(
                                padding: EdgeInsets.symmetric(vertical: 12.h),
                                side: BorderSide(color: Colors.grey.shade300),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(30.r),
                                ),
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  SvgPicture.asset(
                                    'assets/icon/whatsapp.svg',
                                    height: 20.sp,
                                    width: 20.sp,
                                  ),
                                  SizedBox(width: 8.w),
                                  Text(
                                    "تواصل واتساب",
                                    style: TextStyle(
                                      color: Colors.black87,
                                      fontSize: 14.sp,
                                      fontWeight: FontWeight.bold,
                                      fontFamily: 'ElMessiri',
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
