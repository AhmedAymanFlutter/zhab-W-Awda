class GetAllPackagesModel {
  String? status;
  int? results;
  PackagesDataWrapper? data;

  GetAllPackagesModel({this.status, this.results, this.data});

  GetAllPackagesModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    results = (json['results'] as num?)?.toInt();
    data = json['data'] != null
        ? PackagesDataWrapper.fromJson(json['data'])
        : null;
  }
}

class PackagesDataWrapper {
  List<PackageItem>? packages;

  PackagesDataWrapper({this.packages});

  PackagesDataWrapper.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      packages = <PackageItem>[];
      json['data'].forEach((v) {
        packages!.add(PackageItem.fromJson(v));
      });
    }
  }
}

class PackageItem {
  Seo? seo;
  String? sId;
  String? name;
  String? price;
  String? rate;
  Header? header;
  PackageType? packageType;
  List<Itinerary>? itinerary;
  List<String>? includes;
  List<String>? excludes;
  Country? country;
  List<String>? cities;
  List<String>? images;
  String? description;
  String? descText;
  String? createdBy;
  String? createdAt;
  String? updatedAt;
  String? slug;
  String? alt;
  String? imageCover;
  String? updatedBy;
  String? city;

  PackageItem({
    this.seo,
    this.sId,
    this.name,
    this.price,
    this.rate,
    this.header,
    this.packageType,
    this.itinerary,
    this.includes,
    this.excludes,
    this.country,
    this.cities,
    this.images,
    this.description,
    this.descText,
    this.createdBy,
    this.createdAt,
    this.updatedAt,
    this.slug,
    this.alt,
    this.imageCover,
    this.updatedBy,
    this.city,
  });

  PackageItem.fromJson(Map<String, dynamic> json) {
    seo = json['seo'] != null ? Seo.fromJson(json['seo']) : null;
    sId = json['_id'];
    name = json['name'];
    price = json['price'];
    rate = json['rate']?.toString(); // Ensure it's a string even if int comes
    header = json['header'] != null ? Header.fromJson(json['header']) : null;
    packageType = json['packageType'] != null
        ? PackageType.fromJson(json['packageType'])
        : null;
    if (json['itinerary'] != null) {
      itinerary = <Itinerary>[];
      json['itinerary'].forEach((v) {
        itinerary!.add(Itinerary.fromJson(v));
      });
    }
    // Handle List<String> safely
    includes = json['includes'] != null
        ? List<String>.from(json['includes'])
        : [];
    excludes = json['excludes'] != null
        ? List<String>.from(json['excludes'])
        : [];

    country = json['country'] != null
        ? Country.fromJson(json['country'])
        : null;

    cities = json['cities'] != null ? List<String>.from(json['cities']) : [];
    images = json['images'] != null ? List<String>.from(json['images']) : [];

    description = json['description'];
    descText = json['descText'];
    createdBy = json['createdBy'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    slug = json['slug'];
    alt = json['alt'];
    imageCover = json['imageCover'];
    updatedBy = json['updatedBy'];
    city = json['city'];
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
  int? priority;
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
    priority = (json['priority'] as num?)?.toInt();
    ogTitle = json['ogTitle'];
    ogImage = json['ogImage'];
    ogDescription = json['ogDescription'];
  }
}

class Header {
  String? dayNumber;
  String? nights;
  String? location;
  String? sId;

  Header.fromJson(Map<String, dynamic> json) {
    dayNumber = json['dayNumber'];
    nights = json['nights'];
    location = json['location'];
    sId = json['_id'];
  }
}

class PackageType {
  String? sId;
  String? name;
  String? slug;

  PackageType.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    name = json['name'];
    slug = json['slug'];
  }
}

class Itinerary {
  String? day;
  String? title;
  String? description;
  String? sId;

  Itinerary.fromJson(Map<String, dynamic> json) {
    day = json['day'];
    title = json['title'];
    description = json['description'];
    sId = json['_id'];
  }
}

class Country {
  String? sId;
  String? name;
  String? slug;
  String? id;

  Country.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    name = json['name'];
    slug = json['slug'];
    id = json['id'];
  }
}
