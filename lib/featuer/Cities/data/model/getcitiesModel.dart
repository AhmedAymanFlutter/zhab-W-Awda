class GetCitiesModel {
  String? status;
  int? results;
  CitiesDataWrapper? data;

  GetCitiesModel({this.status, this.results, this.data});

  GetCitiesModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    results = (json['results'] as num?)?.toInt();
    data = json['data'] != null
        ? CitiesDataWrapper.fromJson(json['data'])
        : null;
  }
}

class CitiesDataWrapper {
  List<CityItem>? cities;

  CitiesDataWrapper({this.cities});

  CitiesDataWrapper.fromJson(Map<String, dynamic> json) {
    final citiesList = json['data'] ?? json['cities'];
    if (citiesList != null && citiesList is List) {
      cities = <CityItem>[];
      for (var v in citiesList) {
        cities!.add(CityItem.fromJson(v));
      }
    }
  }
}

class CityItem {
  Seo? seo;
  List<dynamic>? relatedCities;
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

  CityItem({
    this.seo,
    this.relatedCities,
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

  CityItem.fromJson(Map<String, dynamic> json) {
    seo = json['seo'] != null ? Seo.fromJson(json['seo']) : null;
    if (json['relatedCities'] != null) {
      relatedCities = List<dynamic>.from(json['relatedCities']);
    }
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
