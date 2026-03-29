import 'package:flutter/material.dart';
import 'package:flutter_application_1/featuer/flightBooking/manager/book_flight_cubit.dart';
import 'package:flutter_application_1/featuer/flightBooking/manager/book_flight_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/widgets/main_app_header.dart';
import '../data/repo/flight_booking_repository.dart';
import '../../../../featuer/layout/view/widgets/custom_drawer.dart';
import 'widgets/flight_header_section.dart';
import 'widgets/flight_search_form.dart';

class BookFlightView extends StatelessWidget {
  const BookFlightView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => BookFlightCubit(FlightBookingRepository()),
      child: Scaffold(
        backgroundColor: const Color(0xFFF4F6F9),
        extendBodyBehindAppBar: true,
        drawer: const CustomDrawer(),
        body: BlocListener<BookFlightCubit, BookFlightState>(
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
          child: SafeArea(
            bottom: false,
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Column(
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: 20.w,
                      vertical: 10.h,
                    ),
                    child: MainAppHeader(
                      title: "ذهاب وعودة",
                    ),
                  ),
                  const FlightHeaderSection(),
                  SizedBox(height: 10.h),
                  const FlightSearchForm(),
                  SizedBox(height: 50.h),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
