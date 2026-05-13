class BookingDetailsModel {
  bool? success;
  String? message;
  BookingDetailsData? data;

  BookingDetailsModel({this.success, this.message, this.data});

  BookingDetailsModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
    data = json['data'] != null ? BookingDetailsData.fromJson(json['data']) : null;
  }
}

class BookingDetailsData {
  BookingDetail? booking;

  BookingDetailsData({this.booking});

  BookingDetailsData.fromJson(Map<String, dynamic> json) {
    booking = json['booking'] != null ? BookingDetail.fromJson(json['booking']) : null;
  }
}

class BookingDetail {
  String? id;
  String? startDate;
  String? endDate;
  int? pointsEarned;
  HotelDetail? hotel;
  FlightDetail? flight;
  UserDetail? user;
  PackageDetail? package;

  BookingDetail({
    this.id,
    this.startDate,
    this.endDate,
    this.pointsEarned,
    this.hotel,
    this.flight,
    this.user,
    this.package,
  });

  BookingDetail.fromJson(Map<String, dynamic> json) {
    id = json['_id'];
    startDate = json['startDate'];
    endDate = json['endDate'];
    pointsEarned = json['pointsEarned'];
    hotel = json['hotel'] != null ? HotelDetail.fromJson(json['hotel']) : null;
    flight = json['flight'] != null ? FlightDetail.fromJson(json['flight']) : null;
    user = json['user'] != null ? UserDetail.fromJson(json['user']) : null;
    package = json['package'] != null ? PackageDetail.fromJson(json['package']) : null;
  }
}

class HotelDetail {
  String? title;
  String? roomType;
  String? arrivalDate;
  String? departureDate;
  int? roomsCount;
  int? daysCount;
  int? nightsCount;
  bool? isOurHotel;

  HotelDetail({
    this.title,
    this.roomType,
    this.arrivalDate,
    this.departureDate,
    this.roomsCount,
    this.daysCount,
    this.nightsCount,
    this.isOurHotel,
  });

  HotelDetail.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    roomType = json['roomType'];
    arrivalDate = json['arrivalDate'];
    departureDate = json['departureDate'];
    roomsCount = json['roomsCount'];
    daysCount = json['daysCount'];
    nightsCount = json['nightsCount'];
    isOurHotel = json['isOurHotel'];
  }
}

class FlightDetail {
  LocationDetail? from;
  LocationDetail? to;
  bool? isOurFlight;

  FlightDetail({this.from, this.to, this.isOurFlight});

  FlightDetail.fromJson(Map<String, dynamic> json) {
    from = json['from'] != null ? LocationDetail.fromJson(json['from']) : null;
    to = json['to'] != null ? LocationDetail.fromJson(json['to']) : null;
    isOurFlight = json['isOurFlight'];
  }
}

class LocationDetail {
  String? country;
  String? city;
  String? airport;
  String? date;

  LocationDetail({this.country, this.city, this.airport, this.date});

  LocationDetail.fromJson(Map<String, dynamic> json) {
    country = json['country'];
    city = json['city'];
    airport = json['airport'];
    date = json['date'];
  }
}

class UserDetail {
  String? id;
  String? name;
  String? countryCode;
  String? phone;

  UserDetail({this.id, this.name, this.countryCode, this.phone});

  UserDetail.fromJson(Map<String, dynamic> json) {
    id = json['_id'];
    name = json['name'];
    countryCode = json['countryCode'];
    phone = json['phone'];
  }
}

class PackageDetail {
  String? name;
  String? imageCover;
  List<String>? includes;
  List<String>? excludes;
  List<DayDetail>? days;
  List<CityDetail>? cities;
  PackageTypeDetail? packageType;

  PackageDetail({
    this.name,
    this.imageCover,
    this.includes,
    this.excludes,
    this.days,
    this.cities,
    this.packageType,
  });

  PackageDetail.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    imageCover = json['imageCover'];
    includes = json['includes']?.cast<String>();
    excludes = json['excludes']?.cast<String>();
    if (json['days'] != null) {
      days = <DayDetail>[];
      json['days'].forEach((v) {
        days!.add(DayDetail.fromJson(v));
      });
    }
    if (json['cities'] != null) {
      cities = <CityDetail>[];
      json['cities'].forEach((v) {
        cities!.add(CityDetail.fromJson(v));
      });
    }
    packageType = json['packageType'] != null
        ? PackageTypeDetail.fromJson(json['packageType'])
        : null;
  }
}

class DayDetail {
  int? dayNumber;
  String? type;
  String? customTitle;
  String? customDescription;
  CityDetail? city;
  TourDetail? tour;

  DayDetail({
    this.dayNumber,
    this.type,
    this.customTitle,
    this.customDescription,
    this.city,
    this.tour,
  });

  DayDetail.fromJson(Map<String, dynamic> json) {
    dayNumber = json['dayNumber'];
    type = json['type'];
    customTitle = json['customTitle'];
    customDescription = json['customDescription'];
    city = json['city'] != null ? CityDetail.fromJson(json['city']) : null;
    tour = json['tour'] != null ? TourDetail.fromJson(json['tour']) : null;
  }
}

class CityDetail {
  String? id;
  String? name;
  String? descText;
  String? imageCover;
  String? slug;

  CityDetail({this.id, this.name, this.descText, this.imageCover, this.slug});

  CityDetail.fromJson(Map<String, dynamic> json) {
    id = json['_id'];
    name = json['name'];
    descText = json['descText'];
    imageCover = json['imageCover'];
    slug = json['slug'];
  }
}

class TourDetail {
  String? id;
  String? description;
  String? descText;
  String? imageCover;
  String? slug;

  TourDetail({this.id, this.description, this.descText, this.imageCover, this.slug});

  TourDetail.fromJson(Map<String, dynamic> json) {
    id = json['_id'];
    description = json['description'];
    descText = json['descText'];
    imageCover = json['imageCover'];
    slug = json['slug'];
  }
}

class PackageTypeDetail {
  String? id;
  String? name;
  String? slug;

  PackageTypeDetail({this.id, this.name, this.slug});

  PackageTypeDetail.fromJson(Map<String, dynamic> json) {
    id = json['_id'];
    name = json['name'];
    slug = json['slug'];
  }
}
