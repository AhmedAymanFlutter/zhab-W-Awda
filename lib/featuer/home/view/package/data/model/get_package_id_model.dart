// lib/features/packages/data/models/get_package_id_model.dart

class GetPackageIdModel {
  String? status;
  PackageIdData? data;

  GetPackageIdModel({this.status, this.data});

  GetPackageIdModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    // Handle nested 'data' key issue if present
    if (json['data'] != null) {
      if (json['data']['data'] != null) {
        data = PackageIdData.fromJson(json['data']['data']);
      } else {
        data = PackageIdData.fromJson(json['data']);
      }
    }
  }
}

class PackageIdData {
  Seo? seo;
  String? sId;
  String? name;
  String? price;
  String? rate;
  Header? header;
  String? packageType;
  List<Itinerary>? itinerary;
  List<String>? includes;
  List<String>? excludes;
  String? country;
  List<String>? cities;
  List<String>? images; // Changed from List<Null> to List<String>
  String? description;
  String? descText;
  String? createdBy;
  String? createdAt;
  String? updatedAt;
  String? slug;
  String? alt;
  int? iV;
  String? imageCover; // Added imageCover manually as it's common

  PackageIdData({
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
    this.iV,
    this.imageCover,
  });

  PackageIdData.fromJson(Map<String, dynamic> json) {
    seo = json['seo'] != null ? Seo.fromJson(json['seo']) : null;
    sId = json['_id'];
    name = json['name'];
    price = json['price'];
    rate = json['rate']?.toString();
    header = json['header'] != null ? Header.fromJson(json['header']) : null;
    packageType = json['packageType'];
    if (json['itinerary'] != null) {
      itinerary = <Itinerary>[];
      json['itinerary'].forEach((v) {
        itinerary!.add(Itinerary.fromJson(v));
      });
    }
    includes = json['includes'] != null
        ? List<String>.from(json['includes'])
        : [];
    excludes = json['excludes'] != null
        ? List<String>.from(json['excludes'])
        : [];
    country = json['country'];
    cities = json['cities'] != null ? List<String>.from(json['cities']) : [];

    // Safety check for images
    if (json['images'] != null) {
      images = List<String>.from(
        json['images'].where((i) => i != null).map((i) => i.toString()),
      );
    }

    description = json['description'];
    descText = json['descText'];
    createdBy = json['createdBy'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    slug = json['slug'];
    alt = json['alt'];
    iV = json['__v'];
    imageCover = json['imageCover'];
  }
}

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
