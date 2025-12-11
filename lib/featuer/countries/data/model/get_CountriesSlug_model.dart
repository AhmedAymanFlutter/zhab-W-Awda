class GetCountryDetailsModel {
  bool? success;
  String? message;
  CountryDetailsData? data;

  GetCountryDetailsModel({this.success, this.message, this.data});

  GetCountryDetailsModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
    data = json['data'] != null
        ? CountryDetailsData.fromJson(json['data'])
        : null;
  }
}

class CountryDetailsData {
  Seo? seo;
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
  String? imageCover;
  String? alt;
  String? createdAt;
  String? updatedAt;
  String? slug;
  int? iV;
  String? id;

  CountryDetailsData({
    this.seo,
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
    this.imageCover,
    this.alt,
    this.createdAt,
    this.updatedAt,
    this.slug,
    this.iV,
    this.id,
  });

  CountryDetailsData.fromJson(Map<String, dynamic> json) {
    seo = json['seo'] != null ? Seo.fromJson(json['seo']) : null;
    sId = json['_id'];
    name = json['name'];
    code = json['code'];
    continent = json['continent'];
    currency = json['currency'];
    language = json['language'];
    description = json['description'];
    descText = json['descText'];

    favTime = json['favTime'] != null ? List<String>.from(json['favTime']) : [];
    favMonth = json['favMonth'] != null
        ? List<String>.from(json['favMonth'])
        : [];

    isActive = json['isActive'];

    if (json['images'] != null) {
      images = List<String>.from(
        json['images'].where((i) => i != null).map((i) => i.toString()),
      );
    }

    imageCover = json['imageCover'];
    alt = json['alt'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    slug = json['slug'];
    iV = json['__v'];
    id = json['id'];
  }
}

// --- Sub Classes ---

class Seo {
  String? changeFrequency;
  String? noIndex;
  String? noFollow;
  String? noArchive;
  String? noSnippet;
  String? metaTitle;
  String? metaDescription;
  String? keywords;

  Seo.fromJson(Map<String, dynamic> json) {
    changeFrequency = json['changeFrequency'];
    noIndex = json['noIndex'];
    noFollow = json['noFollow'];
    noArchive = json['noArchive'];
    noSnippet = json['noSnippet'];
    metaTitle = json['metaTitle'];
    metaDescription = json['metaDescription'];
    keywords = json['keywords'];
  }
}
