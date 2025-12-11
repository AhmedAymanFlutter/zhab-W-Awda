class GetTourIdModel {
  String? status;
  TourIdData? data;

  GetTourIdModel({this.status, this.data});

  GetTourIdModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    // Handle nested 'data' key issue
    if (json['data'] != null) {
      if (json['data']['data'] != null) {
        data = TourIdData.fromJson(json['data']['data']);
      } else {
        data = TourIdData.fromJson(json['data']);
      }
    }
  }
}

class TourIdData {
  Seo? seo;
  String? sId;
  String? title;
  String? description;
  String? descText;
  String? city; // String in this endpoint
  String? country; // String in this endpoint
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
  int? iV;
  String? updatedBy;
  String? id;

  TourIdData({
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
    this.iV,
    this.updatedBy,
    this.id,
  });

  TourIdData.fromJson(Map<String, dynamic> json) {
    seo = json['seo'] != null ? Seo.fromJson(json['seo']) : null;
    sId = json['_id'];
    title = json['title'];
    description = json['description'];
    descText = json['descText'];

    // Handle dynamic types just in case (sometimes API returns Object, sometimes String)
    city = json['city'] is Map ? json['city']['name'] : json['city'];
    country = json['country'] is Map
        ? json['country']['name']
        : json['country'];

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
    if (json['images'] != null) {
      images = List<String>.from(
        json['images'].where((i) => i != null).map((i) => i.toString()),
      );
    }

    slug = json['slug'];
    createdBy = json['createdBy'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    iV = json['__v'];
    updatedBy = json['updatedBy'];
    id = json['id'];
  }
}

// --- Sub Classes (Reused or Defined locally) ---

class Seo {
  String? changeFrequency;
  String? noIndex;
  String? noFollow;
  String? noArchive;
  String? noSnippet;

  Seo.fromJson(Map<String, dynamic> json) {
    changeFrequency = json['changeFrequency'];
    noIndex = json['noIndex'];
    noFollow = json['noFollow'];
    noArchive = json['noArchive'];
    noSnippet = json['noSnippet'];
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
