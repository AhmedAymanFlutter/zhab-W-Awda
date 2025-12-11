class GetCityDetailsModel {
  bool? success;
  String? message;
  CityDetailsData? data;

  GetCityDetailsModel({this.success, this.message, this.data});

  GetCityDetailsModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
    data = json['data'] != null ? CityDetailsData.fromJson(json['data']) : null;
  }
}

class CityDetailsData {
  CityObj? city;
  List<dynamic>? packages; // Changed to dynamic for safety
  CityWeather? cityWeather;

  CityDetailsData({this.city, this.packages, this.cityWeather});

  CityDetailsData.fromJson(Map<String, dynamic> json) {
    city = json['city'] != null ? CityObj.fromJson(json['city']) : null;
    if (json['packages'] != null) {
      packages = [];
      json['packages'].forEach((v) {
        packages!.add(v);
      });
    }
    cityWeather = json['cityWeather'] != null
        ? CityWeather.fromJson(json['cityWeather'])
        : null;
  }
}

class CityObj {
  Seo? seo;
  String? sId;
  String? name;
  Country? country;
  String? description;
  String? descText;
  List<String>? favTime;
  List<String>? favMonth;
  List<String>? images;
  String? slug;
  String? alt;
  String? imageCover;

  CityObj({
    this.seo,
    this.sId,
    this.name,
    this.country,
    this.description,
    this.descText,
    this.favTime,
    this.favMonth,
    this.images,
    this.slug,
    this.alt,
    this.imageCover,
  });

  CityObj.fromJson(Map<String, dynamic> json) {
    seo = json['seo'] != null ? Seo.fromJson(json['seo']) : null;
    sId = json['_id'];
    name = json['name'];
    country = json['country'] != null
        ? Country.fromJson(json['country'])
        : null;
    description = json['description'];
    descText = json['descText'];
    favTime = json['favTime'] != null ? List<String>.from(json['favTime']) : [];
    favMonth = json['favMonth'] != null
        ? List<String>.from(json['favMonth'])
        : [];
    images = json['images'] != null ? List<String>.from(json['images']) : [];
    slug = json['slug'];
    alt = json['alt'];
    imageCover = json['imageCover'];
  }
}

// --- Sub Classes ---

class Seo {
  String? metaTitle;
  String? metaDescription;

  Seo.fromJson(Map<String, dynamic> json) {
    metaTitle = json['metaTitle'];
    metaDescription = json['metaDescription'];
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

class CityWeather {
  dynamic cod; // Could be String or Int
  String? message;

  CityWeather.fromJson(Map<String, dynamic> json) {
    cod = json['cod'];
    message = json['message'];
  }
}
