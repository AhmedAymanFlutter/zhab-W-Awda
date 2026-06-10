class MyBookingsModel {
  bool? success;
  String? message;
  List<BookingItem>? data;
  Pagination? pagination;

  MyBookingsModel({this.success, this.message, this.data, this.pagination});

  MyBookingsModel.fromJson(dynamic json) {
    if (json is Map<String, dynamic>) {
      success = json['success'] == true || json['success'] == 'true';
      message = json['message']?.toString();
      if (json['data'] != null) {
        data = <BookingItem>[];
        if (json['data'] is List) {
          json['data'].forEach((v) {
            if (v is Map<String, dynamic>) {
              data!.add(BookingItem.fromJson(v));
            }
          });
        }
      }
      pagination = json['pagination'] != null && json['pagination'] is Map<String, dynamic>
          ? Pagination.fromJson(json['pagination'])
          : null;
    } else if (json is List) {
      success = true;
      message = 'Success';
      data = <BookingItem>[];
      for (var v in json) {
        if (v is Map<String, dynamic>) {
          data!.add(BookingItem.fromJson(v));
        }
      }
    }
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
    id = json['id']?.toString() ?? json['_id']?.toString();
    startDate = json['startDate']?.toString();
    endDate = json['endDate']?.toString();
    imageCover = json['imageCover']?.toString();
    if (json['adultsCount'] != null) {
      adultsCount = int.tryParse(json['adultsCount'].toString());
    }
    description = json['description']?.toString();
    city = json['city']?.toString();
    country = json['country']?.toString();
    // Mock values for UI fields if not in JSON
    bookingNumber = json['bookingNumber']?.toString() ?? "TR2458";
    status = json['status']?.toString() ?? "تم التأكيد";
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
