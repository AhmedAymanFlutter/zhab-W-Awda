import 'getHotel_model.dart';

class GetHotelIdModel {
  String? status;
  HotelIdData? data;
  List<HotelItem>? relatedHotels;

  GetHotelIdModel({this.status, this.data, this.relatedHotels});

  GetHotelIdModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    // التعامل مع مشكلة المفتاح 'data' المتداخل إذا كان موجودًا
    if (json['data'] != null) {
      if (json['data'] is Map && json['data']['data'] != null) {
        data = HotelIdData.fromJson(json['data']['data']);
      } else if (json['data'] is Map) {
        data = HotelIdData.fromJson(json['data']);
      }
    }

    // Parse related hotels
    if (json['relatedHotels'] != null) {
      relatedHotels = <HotelItem>[];
      json['relatedHotels'].forEach((v) {
        relatedHotels!.add(HotelItem.fromJson(v));
      });
    }
  }
}

class HotelIdData {
  num? price;
  String? sId;
  String? hotelId;
  String? name;
  String? country;
  String? city;
  String? rating;
  String? category;
  String? description;
  String? descText;
  bool? isActive;
  String? phone;
  String? email;
  String? website;
  List<String>? images;
  String? slug;
  String? createdBy;
  String? createdAt;
  String? updatedAt;
  String? alt;
  String? updatedBy;
  String? imageCover;

  // New fields
  String? addressline1;
  String? checkIn;
  String? checkOut;
  String? zipcode;
  String? state;
  double? latitude;
  double? longitude;
  num? numberOfReviews;
  num? ratingAverage;
  String? url;

  HotelIdData({
    this.price,
    this.sId,
    this.hotelId,
    this.name,
    this.country,
    this.city,
    this.rating,
    this.category,
    this.description,
    this.descText,
    this.isActive,
    this.phone,
    this.email,
    this.website,
    this.images,
    this.slug,
    this.createdBy,
    this.createdAt,
    this.updatedAt,
    this.alt,
    this.updatedBy,
    this.imageCover,
    this.addressline1,
    this.checkIn,
    this.checkOut,
    this.zipcode,
    this.state,
    this.latitude,
    this.longitude,
    this.numberOfReviews,
    this.ratingAverage,
    this.url,
  });

  HotelIdData.fromJson(Map<String, dynamic> json) {
    try {
      price = json['price'];
      sId = json['_id'];
      hotelId = json['hotel_id']?.toString();
      name = json['hotel_name'] ?? json['name'];

      // Handle country - API returns string
      if (json['country'] is Map) {
        country = json['country']['name'];
      } else {
        country = json['country'];
      }

      // Handle city - API returns string
      if (json['city'] is Map) {
        city = json['city']['name'];
      } else {
        city = json['city'];
      }

      // Handle rating
      if (json['star_rating'] != null) {
        rating = json['star_rating'].toString();
      } else {
        rating = json['rating']?.toString();
      }

      category = json['category'];
      description =
          json['overview'] ?? json['description'] ?? json['addressline1'];
      descText = json['descText'];
      isActive = json['isActive'];
      phone = json['phone'];
      email = json['email'];
      website = json['website'];

      // New fields from API response
      addressline1 = json['addressline1'];
      checkIn = json['checkIn'];
      checkOut = json['checkOut'];
      zipcode = json['zipcode'];
      state = json['state'];
      latitude = (json['latitude'] as num?)?.toDouble();
      longitude = (json['longitude'] as num?)?.toDouble();
      numberOfReviews = json['number_of_reviews'];
      ratingAverage = json['rating_average'];
      url = json['url'];

      // Handle images or photo1
      if (json['photo1'] != null) {
        images = [json['photo1']];
        imageCover = json['photo1'];
      } else if (json['images'] != null) {
        images = List<String>.from(
          json['images'].where((i) => i != null).map((i) => i.toString()),
        );
        if (images!.isNotEmpty) imageCover = images![0];
      }

      if (json['imageCover'] != null) {
        imageCover = json['imageCover'];
      }

      slug = json['slug'];
      createdBy = json['createdBy'];
      createdAt = json['createdAt'];
      updatedAt = json['updatedAt'];
      alt = json['alt'];
      updatedBy = json['updatedBy'];
    } catch (e, stack) {
      print("❌ Error parsing HotelIdData: $e");
      print("❌ Stack trace: $stack");
      print("❌ JSON Data Causing Error: $json");
      rethrow;
    }
  }
}

class Price {
  String? min;
  String? max;

  Price.fromJson(Map<String, dynamic> json) {
    min = json['min']?.toString();
    max = json['max']?.toString();
  }
}
