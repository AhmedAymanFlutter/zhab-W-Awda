// lib/features/flight_booking/logic/book_flight_cubit.dart

import 'package:flutter/material.dart';
import 'package:flutter_application_1/featuer/flightBooking/data/model/book_flight_request_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../data/repo/flight_booking_repository.dart';
import 'book_flight_state.dart';

class BookFlightCubit extends Cubit<BookFlightState> {
  final FlightBookingRepository _repository;

  BookFlightCubit(this._repository) : super(BookFlightInitial());

  // Text Controllers
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController fromCityController = TextEditingController();
  final TextEditingController toCityController = TextEditingController();
  final TextEditingController passengersController = TextEditingController(
    text: '1',
  );

  // Date Variables
  DateTime? departureDate;
  DateTime? returnDate;

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  bool isRoundTrip = true;

  void changeTripType(bool roundTrip) {
    isRoundTrip = roundTrip;
    emit(BookFlightTripTypeChanged());
  }

  Future<void> submitBooking() async {
    if (!formKey.currentState!.validate()) return;
    if (departureDate == null || (isRoundTrip && returnDate == null)) {
      emit(BookFlightError("يرجى تحديد تواريخ السفر" + (isRoundTrip ? " والعودة" : "")));
      return;
    }

    emit(BookFlightLoading());

    try {
      final requestModel = BookFlightRequestModel(
        name: nameController.text,
        email: emailController.text,
        phone: phoneController.text,
        fromCity: fromCityController.text,
        toCity: toCityController.text,
        // Formatting to ISO 8601 string as requested (e.g., 2025-12-19T15:51)
        departureDate: departureDate!.toIso8601String(),
        returnDate: isRoundTrip && returnDate != null ? returnDate!.toIso8601String() : departureDate!.toIso8601String(), // Or another logic for one way flight
        passengers: int.parse(passengersController.text),
      );

      await _repository.bookFlight(requestModel);
      emit(BookFlightSuccess());
    } catch (e) {
      emit(BookFlightError(e.toString()));
    }
  }
}
