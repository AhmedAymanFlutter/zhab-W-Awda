class GetCountriesModel {
  String? status;
  int? results;
  CountriesDataWrapper? data;

  GetCountriesModel({this.status, this.results, this.data});

  GetCountriesModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    results = (json['results'] as num?)?.toInt();
    data = json['data'] != null
        ? CountriesDataWrapper.fromJson(json['data'])
        : null;
  }
}

class CountriesDataWrapper {
  List<CountryItem>? countries;

  CountriesDataWrapper({this.countries});

  CountriesDataWrapper.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      countries = <CountryItem>[];
      json['data'].forEach((v) {
        countries!.add(CountryItem.fromJson(v));
      });
    }
  }
}

class CountryItem {
  String? sId;
  String? name;
  String? code;
  String? continent;
  String? currency;
  String? language;
  String? description;
  String? descText;
  List<String>? favTime;
  List<String>? favMonth;
  bool? isActive;
  List<String>? images;
  String? slug;
  String? createdBy;
  String? createdAt;
  String? updatedAt;
  String? alt;
  String? id;
  String? imageCover;
  String? updatedBy;

  CountryItem({
    this.sId,
    this.name,
    this.code,
    this.continent,
    this.currency,
    this.language,
    this.description,
    this.descText,
    this.favTime,
    this.favMonth,
    this.isActive,
    this.images,
    this.slug,
    this.createdBy,
    this.createdAt,
    this.updatedAt,
    this.alt,
    this.id,
    this.imageCover,
    this.updatedBy,
  });

  CountryItem.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    name = json['name'];
    code = json['code'];
    continent = json['continent'];
    currency = json['currency'];
    language = json['language'];
    description = json['description'];
    descText = json['descText'];

    // Safety check for Lists
    favTime = json['favTime'] != null ? List<String>.from(json['favTime']) : [];
    favMonth = json['favMonth'] != null
        ? List<String>.from(json['favMonth'])
        : [];
    images = json['images'] != null ? List<String>.from(json['images']) : [];

    isActive = json['isActive'];
    slug = json['slug'];
    createdBy = json['createdBy'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    alt = json['alt'];
    id = json['id'];
    imageCover = json['imageCover'];
    updatedBy = json['updatedBy'];
  }
}

// --- Sub Classes ---
