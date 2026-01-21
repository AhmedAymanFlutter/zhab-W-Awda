class GetHotelModel {
  String? status;
  int? results;
  HotelDataWrapper? data;

  GetHotelModel({this.status, this.results, this.data});

  GetHotelModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    results = (json['results'] as num?)?.toInt();
    data = json['data'] != null
        ? HotelDataWrapper.fromJson(json['data'])
        : null;
  }
}

class HotelDataWrapper {
  List<HotelItem>? hotels;

  HotelDataWrapper({this.hotels});

  HotelDataWrapper.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      hotels = <HotelItem>[];
      json['data'].forEach((v) {
        hotels!.add(HotelItem.fromJson(v));
      });
    }
  }
}

class HotelItem {
  Price? price;

  String? sId;
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

  HotelItem({
    this.price,

    this.sId,
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
  });

  HotelItem.fromJson(Map<String, dynamic> json) {
    price = json['price'] != null ? Price.fromJson(json['price']) : null;

    sId = json['_id'];
    name = json['name'];
    country = json['country'] != null
        ? Country.fromJson(json['country'])
        : null;
    city = json['city'] != null ? City.fromJson(json['city']) : null;
    rating = json['rating']?.toString(); // Ensure string conversion
    category = json['category'];
    description = json['description'];
    descText = json['descText'];
    isActive = json['isActive'];
    phone = json['phone'];
    email = json['email'];
    website = json['website'];
    if (json['images'] != null) {
      images = List<String>.from(json['images'].map((x) => x.toString()));
    }
    slug = json['slug'];
    createdBy = json['createdBy'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    alt = json['alt'];
    updatedBy = json['updatedBy'];
    imageCover = json['imageCover'];
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

  Country.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    name = json['name'];
    id = json['id'];
  }
}

class City {
  String? sId;
  String? name;

  City.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    name = json['name'];
  }
}
