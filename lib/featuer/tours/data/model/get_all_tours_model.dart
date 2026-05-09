class GetAllToursModel {
  String? message;
  bool? success;
  ToursDataWrapper? data;

  GetAllToursModel({this.message, this.success, this.data});

  GetAllToursModel.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    success = json['success'] ?? json['status'] == 'success' || json['status'] == true;
    
    if (json['data'] != null) {
      if (json['data'] is List) {
        data = ToursDataWrapper(tours: []);
        for (var v in (json['data'] as List)) {
          data!.tours!.add(TourItem.fromJson(v));
        }
      } else {
        data = ToursDataWrapper.fromJson(json['data']);
      }
    }
  }
}

class ToursDataWrapper {
  List<TourItem>? tours;
  Pagination? pagination;

  ToursDataWrapper({this.tours, this.pagination});

  ToursDataWrapper.fromJson(Map<String, dynamic> json) {
    final toursList = json['data'] ?? json['tours'] ?? (json is List ? json : null);
    if (toursList != null && toursList is List) {
      tours = <TourItem>[];
      for (var v in toursList) {
        tours!.add(TourItem.fromJson(v));
      }
    }
    if (json['pagination'] != null) {
      pagination = Pagination.fromJson(json['pagination']);
    }
  }
}

class Pagination {
  int? currentPage;
  int? totalPages;
  int? totalRecords;
  int? recordsPerPage;
  bool? hasNextPage;
  bool? hasPrevPage;

  Pagination({
    this.currentPage,
    this.totalPages,
    this.totalRecords,
    this.recordsPerPage,
    this.hasNextPage,
    this.hasPrevPage,
  });

  Pagination.fromJson(Map<String, dynamic> json) {
    currentPage = json['currentPage'];
    totalPages = json['totalPages'];
    totalRecords = json['totalRecords'];
    recordsPerPage = json['recordsPerPage'];
    hasNextPage = json['hasNextPage'];
    hasPrevPage = json['hasPrevPage'];
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
  String? price;
  String? originPrice;
  int? duration;

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
    this.price,
    this.originPrice,
    this.duration,
  });

  TourItem.fromJson(Map<String, dynamic> json) {
    seo = json['seo'] != null ? Seo.fromJson(json['seo']) : null;
    sId = json['_id'];
    title = json['title'];
    description = json['description'];
    descText = json['descText'];
    duration = json['duration'];
    
    // Handle complex price object {amount: 100, currency: AED}
    if (json['price'] != null) {
      if (json['price'] is Map) {
        final amt = json['price']['amount'];
        final curr = json['price']['currency'] ?? "";
        price = amt?.toString();
        originPrice = "$amt $curr";
      } else {
        price = json['price'].toString();
        originPrice = price;
      }
    }

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
    
    // If duration is provided but header is null, sync duration to header.days for backward compatibility with UI
    if (duration != null && header == null) {
      header = Header(days: duration.toString());
    }

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
    id = json['id'] ?? json['_id'];
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

  Seo.fromJson(dynamic json) {
    if (json is Map<String, dynamic>) {
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
}

class City {
  String? sId;
  String? name;

  City.fromJson(dynamic json) {
    if (json is Map<String, dynamic>) {
      sId = json['_id'];
      name = json['name'];
    } else if (json is String) {
      sId = json;
    }
  }
}

class Country {
  String? sId;
  String? name;
  String? id;

  Country.fromJson(dynamic json) {
    if (json is Map<String, dynamic>) {
      sId = json['_id'];
      name = json['name'];
      id = json['id'];
    } else if (json is String) {
      sId = json;
    }
  }
}

class Header {
  String? days;
  String? people;
  String? type;
  String? sId;

  Header({this.days, this.people, this.type, this.sId});

  Header.fromJson(dynamic json) {
    if (json is Map<String, dynamic>) {
      days = json['days'];
      people = json['people'];
      type = json['type'];
      sId = json['_id'];
    }
  }
}

class Paths {
  String? title;
  String? duration;
  String? description;
  String? descText;
  String? sId;

  Paths.fromJson(dynamic json) {
    if (json is Map<String, dynamic>) {
      title = json['title'];
      duration = json['duration'];
      description = json['description'];
      descText = json['descText'];
      sId = json['_id'];
    }
  }
}
