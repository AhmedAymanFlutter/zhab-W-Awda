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
    final countriesList = json['data'] ?? json['countries'];
    if (countriesList != null && countriesList is List) {
      countries = <CountryItem>[];
      for (var v in countriesList) {
        countries!.add(CountryItem.fromJson(v));
      }
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
  bool? isTrending;
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
    this.isTrending,
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
    isTrending = json['isTrending'] ?? false;

    // Safety check for Lists
    if (json['favTime'] is List) {
      favTime = (json['favTime'] as List).map((e) => e.toString()).toList();
    } else {
      favTime = [];
    }

    if (json['favMonth'] is List) {
      favMonth = (json['favMonth'] as List).map((e) => e.toString()).toList();
    } else {
      favMonth = [];
    }

    if (json['images'] is List) {
      images = [];
      for (var img in json['images']) {
        if (img is String) {
          images!.add(img);
        } else if (img is Map && img['url'] != null) {
          images!.add(img['url'].toString());
        }
      }
    } else if (json['images'] is Map) {
      images = [];
      var imgMap = json['images'] as Map;
      if (imgMap['all'] is List) {
        for (var img in imgMap['all']) {
          if (img is String) {
            images!.add(img);
          } else if (img is Map && img['url'] != null) {
            images!.add(img['url'].toString());
          }
        }
      }
    } else {
      images = [];
    }

    isActive = json['isActive'];
    slug = json['slug'];
    createdBy = json['createdBy'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    alt = json['alt'];
    id = json['id'];
    
    // imageCover can be a String or a Map
    if (json['imageCover'] is String) {
      imageCover = json['imageCover'];
    } else if (json['imageCover'] is Map) {
      imageCover = json['imageCover']['url']?.toString();
    }
    
    if ((imageCover == null || imageCover!.isEmpty) && images != null && images!.isNotEmpty) {
      imageCover = images!.first;
    }
    updatedBy = json['updatedBy'];
  }
}

// --- Sub Classes ---
