class GetHotelDetailsModel {
  bool? success;
  String? message;
  HotelDetailsData? data;

  GetHotelDetailsModel({this.success, this.message, this.data});

  GetHotelDetailsModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
    data = json['data'] != null ? HotelDetailsData.fromJson(json['data']) : null;
  }
}

class HotelDetailsData {
  Hotel? hotel;
  List<Hotel>? similarHotels;

  HotelDetailsData({this.hotel, this.similarHotels});

  HotelDetailsData.fromJson(Map<String, dynamic> json) {
    hotel = json['hotel'] != null ? Hotel.fromJson(json['hotel']) : null;
    if (json['similarHotels'] != null) {
      similarHotels = <Hotel>[];
      json['similarHotels'].forEach((v) {
        similarHotels!.add(Hotel.fromJson(v));
      });
    }
  }
}

class Hotel {
  Price? price;
  String? sId;
  String? hotelId;
  String? hotelName;
  String? hotelTranslatedName;
  String? addressline1;
  String? zipcode;
  City? city;
  Country? country;
  String? continentName;
  double? longitude;
  double? latitude;
  int? starRating;
  int? numberOfReviews;
  double? ratingAverage;
  int? numberrooms;
  int? numberfloors;
  String? checkin;
  String? checkout;
  String? url;
  List<String>? images;
  List<Includes>? includes;
  String? description;
  String? overview;
  Seo? seo;
  String? createdBy;
  List<Policies>? policies;
  List<Rooms>? rooms;
  String? createdAt;
  String? updatedAt;
  String? slug;

  Hotel({
    this.price,
    this.sId,
    this.hotelId,
    this.hotelName,
    this.hotelTranslatedName,
    this.addressline1,
    this.zipcode,
    this.city,
    this.country,
    this.continentName,
    this.longitude,
    this.latitude,
    this.starRating,
    this.numberOfReviews,
    this.ratingAverage,
    this.numberrooms,
    this.numberfloors,
    this.checkin,
    this.checkout,
    this.url,
    this.images,
    this.includes,
    this.description,
    this.overview,
    this.seo,
    this.createdBy,
    this.policies,
    this.rooms,
    this.createdAt,
    this.updatedAt,
    this.slug,
  });

  Hotel.fromJson(Map<String, dynamic> json) {
    price = json['price'] != null ? Price.fromJson(json['price']) : null;
    sId = json['_id'];
    hotelId = json['hotel_id'];
    hotelName = json['hotel_name'];
    hotelTranslatedName = json['hotel_translated_name'];
    addressline1 = json['addressline1'];
    zipcode = json['zipcode'];
    city = json['city'] != null ? City.fromJson(json['city']) : null;
    country = json['country'] != null ? Country.fromJson(json['country']) : null;
    continentName = json['continent_name'];
    longitude = (json['longitude'] as num?)?.toDouble();
    latitude = (json['latitude'] as num?)?.toDouble();
    starRating = json['star_rating'];
    numberOfReviews = json['number_of_reviews'];
    ratingAverage = (json['rating_average'] as num?)?.toDouble();
    numberrooms = json['numberrooms'];
    numberfloors = json['numberfloors'];
    checkin = json['checkin'];
    checkout = json['checkout'];
    url = json['url'];
    images = json['images']?.cast<String>();
    if (json['includes'] != null) {
      includes = <Includes>[];
      json['includes'].forEach((v) {
        includes!.add(Includes.fromJson(v));
      });
    }
    description = json['description'];
    overview = json['overview'];
    seo = json['seo'] != null ? Seo.fromJson(json['seo']) : null;
    createdBy = json['createdBy'];
    if (json['policies'] != null) {
      policies = <Policies>[];
      json['policies'].forEach((v) {
        policies!.add(Policies.fromJson(v));
      });
    }
    if (json['rooms'] != null) {
      rooms = <Rooms>[];
      json['rooms'].forEach((v) {
        rooms!.add(Rooms.fromJson(v));
      });
    }
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    slug = json['slug'];
  }
}

class Price {
  String? currency;
  int? amount;

  Price({this.currency, this.amount});

  Price.fromJson(Map<String, dynamic> json) {
    currency = json['currency'];
    amount = json['amount'];
  }
}

class City {
  String? sId;
  String? name;

  City({this.sId, this.name});

  City.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    name = json['name'];
  }
}

class Country {
  String? sId;
  String? name;
  String? id;

  Country({this.sId, this.name, this.id});

  Country.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    name = json['name'];
    id = json['id'];
  }
}

class Includes {
  String? icon;
  String? title;
  String? sId;

  Includes({this.icon, this.title, this.sId});

  Includes.fromJson(Map<String, dynamic> json) {
    icon = json['icon'];
    title = json['title'];
    sId = json['_id'];
  }
}

class Seo {
  double? priority;
  String? changeFrequency;
  String? noIndex;
  String? noFollow;
  String? noArchive;
  String? noSnippet;

  Seo({
    this.priority,
    this.changeFrequency,
    this.noIndex,
    this.noFollow,
    this.noArchive,
    this.noSnippet,
  });

  Seo.fromJson(Map<String, dynamic> json) {
    priority = (json['priority'] as num?)?.toDouble();
    changeFrequency = json['changeFrequency'];
    noIndex = json['noIndex'];
    noFollow = json['noFollow'];
    noArchive = json['noArchive'];
    noSnippet = json['noSnippet'];
  }
}

class Policies {
  String? title;
  String? description;
  String? icon;
  String? sId;

  Policies({this.title, this.description, this.icon, this.sId});

  Policies.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    description = json['description'];
    icon = json['icon'];
    sId = json['_id'];
  }
}

class Rooms {
  String? title;
  String? description;
  String? image;
  int? price;
  String? currency;
  int? area;
  int? maxAdults;
  String? sId;

  Rooms({
    this.title,
    this.description,
    this.image,
    this.price,
    this.currency,
    this.area,
    this.maxAdults,
    this.sId,
  });

  Rooms.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    description = json['description'];
    image = json['image'];
    price = json['price'];
    currency = json['currency'];
    area = json['area'];
    maxAdults = json['maxAdults'];
    sId = json['_id'];
  }
}
