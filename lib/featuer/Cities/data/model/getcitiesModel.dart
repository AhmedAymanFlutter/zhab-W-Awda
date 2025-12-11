class GetCitiesModel {
  String? status;
  int? results;
  CitiesDataWrapper? data;

  GetCitiesModel({this.status, this.results, this.data});

  GetCitiesModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    results = json['results'];
    data = json['data'] != null
        ? CitiesDataWrapper.fromJson(json['data'])
        : null;
  }
}

class CitiesDataWrapper {
  List<CityItem>? cities;

  CitiesDataWrapper({this.cities});

  CitiesDataWrapper.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      cities = <CityItem>[];
      json['data'].forEach((v) {
        cities!.add(CityItem.fromJson(v));
      });
    }
  }
}

class CityItem {
  Coordinates? coordinates;
  Seo? seo;
  List<dynamic>? relatedCities; // Changed to dynamic to be safe
  String? sId;
  String? name;
  Country? country;
  String? description;
  String? descText;
  List<String>? favTime;
  List<String>? favMonth;
  List<String>? images;
  String? slug;
  String? createdBy;
  String? createdAt;
  String? updatedAt;
  String? alt;
  String? imageCover;
  String? updatedBy;

  CityItem({
    this.coordinates,
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
    this.createdBy,
    this.createdAt,
    this.updatedAt,
    this.alt,
    this.imageCover,
    this.updatedBy,
  });

  CityItem.fromJson(Map<String, dynamic> json) {
    coordinates = json['coordinates'] != null
        ? Coordinates.fromJson(json['coordinates'])
        : null;
    seo = json['seo'] != null ? Seo.fromJson(json['seo']) : null;
    if (json['relatedCities'] != null) {
      relatedCities = [];
      json['relatedCities'].forEach((v) {
        relatedCities!.add(v);
      });
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
    createdBy = json['createdBy'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    alt = json['alt'];
    imageCover = json['imageCover'];
    updatedBy = json['updatedBy'];
  }
}

// --- Sub Classes ---

class Coordinates {
  String? lat;
  String? lng;

  Coordinates.fromJson(Map<String, dynamic> json) {
    lat = json['lat'];
    lng = json['lng'];
  }
}

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
