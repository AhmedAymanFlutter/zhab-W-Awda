// lib/features/flight_booking/data/models/book_flight_request_model.dart

class BookFlightRequestModel {
  final String name;
  final String email;
  final String phone;
  final String fromCity;
  final String toCity;
  final String departureDate;
  final String returnDate;
  final int passengers;

  BookFlightRequestModel({
    required this.name,
    required this.email,
    required this.phone,
    required this.fromCity,
    required this.toCity,
    required this.departureDate,
    required this.returnDate,
    required this.passengers,
  });

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'email': email,
      'phone': phone,
      'fromCity': fromCity,
      'toCity': toCity,
      'departureDate': departureDate,
      'returnDate': returnDate,
      'passengers': passengers,
    };
  }
}
