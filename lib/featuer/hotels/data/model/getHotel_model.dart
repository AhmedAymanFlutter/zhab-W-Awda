class GetHotelModel {
  bool? success;
  int? count;
  List<HotelItem>? data;

  GetHotelModel({this.success, this.count, this.data});

  GetHotelModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    count = (json['count'] as num?)?.toInt();
    if (json['data'] != null) {
      data = <HotelItem>[];
      json['data'].forEach((v) {
        data!.add(HotelItem.fromJson(v));
      });
    }
  }
}

class HotelItem {
  num? price;
  String? sId;
  String? hotelId;
  String? name;
  Country? country;
  City? city;
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

  // New fields from API
  String? addressline1;
  String? translatedName;
  String? cityTranslated;
  String? url;

  HotelItem({
    this.price,
    this.sId,
    this.hotelId,
    this.name,
    this.translatedName,
    this.cityTranslated,
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
  });

  HotelItem.fromJson(Map<String, dynamic> json) {
    try {
      price = json['price'];
      sId = json['_id'];
      hotelId = json['hotel_id']?.toString();

      // Handle naming mismatch
      name = json['hotel_name'] ?? json['name'];
      translatedName = json['hotel_translated_name'];

      // Handle country: API returns string, model wants object?
      // Parsing simple string into Country object for compatibility
      if (json['country'] is String) {
        country = Country(name: json['country']);
      } else if (json['country'] != null) {
        country = Country.fromJson(json['country']);
      }

      // Handle city: API returns string
      if (json['city'] is String) {
        city = City(name: json['city']);
      } else if (json['city'] != null) {
        city = City.fromJson(json['city']);
      }
      cityTranslated = json['city_translated'];

      // Handle rating
      if (json['star_rating'] != null) {
        rating = json['star_rating'].toString();
      } else {
        rating = json['rating']?.toString();
      }

      category = json['category'];
      description = json['description'] ?? json['addressline1']; // Fallback
      descText = json['descText'];
      isActive = json['isActive'];
      phone = json['phone'];
      email = json['email'];
      website = json['website'];
      url = json['url'];

      // Handle images or photo1
      if (json['photo1'] != null) {
        images = [json['photo1']];
        imageCover = json['photo1'];
      } else if (json['images'] != null) {
        images = List<String>.from(json['images'].map((x) => x.toString()));
        if (images!.isNotEmpty) imageCover = images![0];
      }

      // specific image cover field
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
      print("❌ Error parsing HotelItem: $e");
      print("❌ Stack trace: $stack");
      print("❌ JSON Data Causing Error: $json");
      rethrow;
    }
  }
}

class Price {
  String? min;
  String? max;

  Price({this.min, this.max});

  Price.fromJson(Map<String, dynamic> json) {
    min = json['min']?.toString();
    max = json['max']?.toString();
  }
}

class Country {
  String? sId;
  String? name;
  String? id;

  Country({this.sId, this.name, this.id});

  Country.fromJson(dynamic json) {
    if (json is Map<String, dynamic>) {
      sId = json['_id'];
      name = json['name'];
      id = json['id'];
    } else if (json is String) {
      sId = json;
    }
  }
}

class City {
  String? sId;
  String? name;

  City({this.sId, this.name});

  City.fromJson(dynamic json) {
    if (json is Map<String, dynamic>) {
      sId = json['_id'];
      name = json['name'];
    } else if (json is String) {
      sId = json;
    }
  }
}
