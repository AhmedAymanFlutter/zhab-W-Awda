class GetAllToursModel {
  String? status;
  int? results;
  ToursDataWrapper? data;

  GetAllToursModel({this.status, this.results, this.data});

  GetAllToursModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    results = json['results'];
    data = json['data'] != null
        ? ToursDataWrapper.fromJson(json['data'])
        : null;
  }
}

class ToursDataWrapper {
  List<TourItem>? tours;

  ToursDataWrapper({this.tours});

  ToursDataWrapper.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      tours = <TourItem>[];
      json['data'].forEach((v) {
        tours!.add(TourItem.fromJson(v));
      });
    }
  }
}

class TourItem {
  Seo? seo;
  String? sId;
  String? title;
  String? description;
  String? descText;
  City? city;
  Country? country;
  List<String>? includes;
  List<String>? excludes;
  Header? header;
  List<Paths>? paths;
  String? imageCover;
  List<String>? images;
  String? slug;
  String? createdBy;
  String? createdAt;
  String? updatedAt;
  String? updatedBy;
  String? id;
  String? alt;

  TourItem({
    this.seo,
    this.sId,
    this.title,
    this.description,
    this.descText,
    this.city,
    this.country,
    this.includes,
    this.excludes,
    this.header,
    this.paths,
    this.imageCover,
    this.images,
    this.slug,
    this.createdBy,
    this.createdAt,
    this.updatedAt,
    this.updatedBy,
    this.id,
    this.alt,
  });

  TourItem.fromJson(Map<String, dynamic> json) {
    seo = json['seo'] != null ? Seo.fromJson(json['seo']) : null;
    sId = json['_id'];
    title = json['title'];
    description = json['description'];
    descText = json['descText'];
    city = json['city'] != null ? City.fromJson(json['city']) : null;
    country = json['country'] != null
        ? Country.fromJson(json['country'])
        : null;

    includes = json['includes'] != null
        ? List<String>.from(json['includes'])
        : [];
    excludes = json['excludes'] != null
        ? List<String>.from(json['excludes'])
        : [];

    header = json['header'] != null ? Header.fromJson(json['header']) : null;
    if (json['paths'] != null) {
      paths = <Paths>[];
      json['paths'].forEach((v) {
        paths!.add(Paths.fromJson(v));
      });
    }
    imageCover = json['imageCover'];
    images = json['images'] != null ? List<String>.from(json['images']) : [];
    slug = json['slug'];
    createdBy = json['createdBy'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    updatedBy = json['updatedBy'];
    id = json['id'];
    alt = json['alt'];
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
  String? keywords;
  String? slugUrl;
  String? metaDescription;
  String? ogTitle;
  String? ogImage;
  String? ogDescription;

  Seo.fromJson(Map<String, dynamic> json) {
    changeFrequency = json['changeFrequency'];
    noIndex = json['noIndex'];
    noFollow = json['noFollow'];
    noArchive = json['noArchive'];
    noSnippet = json['noSnippet'];
    metaTitle = json['metaTitle'];
    keywords = json['keywords'];
    slugUrl = json['slugUrl'];
    metaDescription = json['metaDescription'];
    ogTitle = json['ogTitle'];
    ogImage = json['ogImage'];
    ogDescription = json['ogDescription'];
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

class Header {
  String? days;
  String? people;
  String? type;
  String? sId;

  Header.fromJson(Map<String, dynamic> json) {
    days = json['days'];
    people = json['people'];
    type = json['type'];
    sId = json['_id'];
  }
}

class Paths {
  String? title;
  String? duration;
  String? description;
  String? descText;
  String? sId;

  Paths.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    duration = json['duration'];
    description = json['description'];
    descText = json['descText'];
    sId = json['_id'];
  }
}
