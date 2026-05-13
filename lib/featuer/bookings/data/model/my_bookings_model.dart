class MyBookingsModel {
  bool? success;
  String? message;
  List<BookingItem>? data;
  Pagination? pagination;

  MyBookingsModel({this.success, this.message, this.data, this.pagination});

  MyBookingsModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
    if (json['data'] != null) {
      data = <BookingItem>[];
      json['data'].forEach((v) {
        data!.add(BookingItem.fromJson(v));
      });
    }
    pagination = json['pagination'] != null
        ? Pagination.fromJson(json['pagination'])
        : null;
  }
}

class BookingItem {
  String? id;
  String? startDate;
  String? endDate;
  String? imageCover;
  int? adultsCount;
  String? description;
  String? city;
  String? country;
  String? bookingNumber; // Added for UI "رقم الحجز"
  String? status; // Added for UI "تم التأكيد"

  BookingItem({
    this.id,
    this.startDate,
    this.endDate,
    this.imageCover,
    this.adultsCount,
    this.description,
    this.city,
    this.country,
    this.bookingNumber,
    this.status,
  });

  BookingItem.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    startDate = json['startDate'];
    endDate = json['endDate'];
    imageCover = json['imageCover'];
    adultsCount = json['adultsCount'];
    description = json['description'];
    city = json['city'];
    country = json['country'];
    // Mock values for UI fields if not in JSON
    bookingNumber = json['bookingNumber'] ?? "TR2458";
    status = json['status'] ?? "تم التأكيد";
  }
}

class Pagination {
  int? currentPage;
  int? totalPages;
  int? totalRecords;
  int? recordsPerPage;
  bool? hasNextPage;
  bool? hasPrevPage;

  Pagination({
    this.currentPage,
    this.totalPages,
    this.totalRecords,
    this.recordsPerPage,
    this.hasNextPage,
    this.hasPrevPage,
  });

  Pagination.fromJson(Map<String, dynamic> json) {
    currentPage = json['currentPage'];
    totalPages = json['totalPages'];
    totalRecords = json['totalRecords'];
    recordsPerPage = json['recordsPerPage'];
    hasNextPage = json['hasNextPage'];
    hasPrevPage = json['hasPrevPage'];
  }
}
