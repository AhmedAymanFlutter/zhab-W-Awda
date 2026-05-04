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
  List<dynamic>? packages; 
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

class Seo {
  String? metaTitle;
  String? metaDescription;
  String? keywords;
  double? priority;
  String? changeFrequency;
  String? noIndex;
  String? noFollow;
  String? noArchive;
  String? noSnippet;

  Seo.fromJson(Map<String, dynamic> json) {
    metaTitle = json['metaTitle'];
    metaDescription = json['metaDescription'];
    keywords = json['keywords'];
    priority = (json['priority'] as num?)?.toDouble();
    changeFrequency = json['changeFrequency'];
    noIndex = json['noIndex'];
    noFollow = json['noFollow'];
    noArchive = json['noArchive'];
    noSnippet = json['noSnippet'];
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
  double? temp;
  double? feelsLike;
  int? humidity;
  String? description;
  String? icon;
  String? cityName;
  dynamic cod;

  CityWeather.fromJson(Map<String, dynamic> json) {
    if (json['main'] != null) {
      temp = (json['main']['temp'] as num?)?.toDouble();
      feelsLike = (json['main']['feels_like'] as num?)?.toDouble();
      humidity = (json['main']['humidity'] as num?)?.toInt();
    }
    if (json['weather'] != null && (json['weather'] as List).isNotEmpty) {
      description = json['weather'][0]['description'];
      icon = json['weather'][0]['icon'];
    }
    cityName = json['name'];
    cod = json['cod'];
  }
}
