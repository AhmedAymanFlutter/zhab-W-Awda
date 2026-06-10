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
    if (json['price'] is num) {
      price = Price(amount: json['price']);
    } else if (json['price'] is Map) {
      price = Price.fromJson(json['price'] as Map<String, dynamic>);
    }
    sId = json['_id'];
    hotelId = json['hotel_id']?.toString() ?? json['hotelId']?.toString();
    hotelName = json['hotel_name'] ?? json['name'];
    hotelTranslatedName = json['hotel_translated_name'];
    addressline1 = json['addressline1'];
    zipcode = json['zipcode']?.toString();
    
    if (json['city'] is Map) {
      city = City.fromJson(json['city'] as Map<String, dynamic>);
    } else if (json['city'] is String) {
      city = City(name: json['city']);
    }

    if (json['country'] is Map) {
      country = Country.fromJson(json['country'] as Map<String, dynamic>);
    } else if (json['country'] is String) {
      country = Country(name: json['country']);
    }
    continentName = json['continent_name'];
    longitude = (json['longitude'] as num?)?.toDouble();
    latitude = (json['latitude'] as num?)?.toDouble();
    starRating = int.tryParse(json['star_rating']?.toString() ?? json['stars']?.toString() ?? '');
    numberOfReviews = int.tryParse(json['number_of_reviews']?.toString() ?? '');
    ratingAverage = num.tryParse(json['rating_average']?.toString() ?? '')?.toDouble();
    numberrooms = int.tryParse(json['numberrooms']?.toString() ?? '');
    numberfloors = int.tryParse(json['numberfloors']?.toString() ?? '');
    checkin = json['checkin'];
    checkout = json['checkout'];
    url = json['url'];
    if (json['images'] is List) {
      images = List<String>.from(json['images'].map((x) => x.toString()));
    } else if (json['images'] is Map) {
      images = <String>[];
      if (json['images']['all'] != null && json['images']['all'] is List) {
        for (var item in json['images']['all']) {
          if (item is Map && item['url'] != null) {
            images!.add(item['url'].toString());
          } else if (item is String) {
            images!.add(item);
          }
        }
      } else {
        // Fallback if it's a different map structure
        try {
          images = List<String>.from(json['images'].values.whereType<String>());
        } catch (_) {}
      }
    } else if (json['photo1'] != null) {
      images = [json['photo1'].toString()];
    }

    if (json['includes'] is List) {
      includes = <Includes>[];
      for (var v in json['includes']) {
        includes!.add(Includes.fromJson(v));
      }
    }
    description = json['description'];
    overview = json['overview'];
    seo = json['seo'] != null ? Seo.fromJson(json['seo']) : null;
    createdBy = json['createdBy'];
    
    if (json['policies'] is List) {
      policies = <Policies>[];
      for (var v in json['policies']) {
        policies!.add(Policies.fromJson(v));
      }
    }
    
    if (json['rooms'] is List) {
      rooms = <Rooms>[];
      for (var v in json['rooms']) {
        rooms!.add(Rooms.fromJson(v));
      }
    }
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    slug = json['slug'];
  }
}

class Price {
  String? currency;
  num? amount;

  Price({this.currency, this.amount});

  Price.fromJson(Map<String, dynamic> json) {
    currency = json['currency'];
    amount = json['amount'] ?? json['min'];
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
    price = int.tryParse(json['price']?.toString() ?? '');
    currency = json['currency'];
    area = int.tryParse(json['area']?.toString() ?? '');
    maxAdults = int.tryParse(json['maxAdults']?.toString() ?? '');
    sId = json['_id'];
  }
}
