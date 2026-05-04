class GetPackageDetailsModel {
  bool? success;
  String? message;
  PackageDetailsData? data;

  GetPackageDetailsModel({this.success, this.message, this.data});

  GetPackageDetailsModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
    data = json['data'] != null ? PackageDetailsData.fromJson(json['data']) : null;
  }
}

class PackageDetailsData {
  PackagePkg? pkg;
  List<PackageBranch>? branches;
  List<dynamic>? relatedPackages;

  PackageDetailsData({this.pkg, this.branches, this.relatedPackages});

  PackageDetailsData.fromJson(Map<String, dynamic> json) {
    pkg = json['pkg'] != null ? PackagePkg.fromJson(json['pkg']) : null;
    if (json['branches'] != null) {
      branches = <PackageBranch>[];
      json['branches'].forEach((v) {
        branches!.add(PackageBranch.fromJson(v));
      });
    }
    relatedPackages = json['relatedPackages'];
  }
}

class PackagePkg {
  String? sId;
  String? name;
  PackageType? packageType;
  Country? country;
  List<City>? cities;
  String? imageCover;
  List<String>? images;
  String? description;
  double? ratingsAverage;
  int? ratingsQuantity;
  String? slug;

  PackagePkg({
    this.sId,
    this.name,
    this.packageType,
    this.country,
    this.cities,
    this.imageCover,
    this.images,
    this.description,
    this.ratingsAverage,
    this.ratingsQuantity,
    this.slug,
  });

  PackagePkg.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    name = json['name'];
    packageType = json['packageType'] != null ? PackageType.fromJson(json['packageType']) : null;
    country = json['country'] != null ? Country.fromJson(json['country']) : null;
    if (json['cities'] != null) {
      cities = <City>[];
      json['cities'].forEach((v) {
        cities!.add(City.fromJson(v));
      });
    }
    imageCover = json['imageCover'];
    images = json['images']?.cast<String>().toList();
    description = json['description'];
    ratingsAverage = (json['ratingsAverage'] as num?)?.toDouble();
    ratingsQuantity = (json['ratingsQuantity'] as num?)?.toInt();
    slug = json['slug'];
  }
}

class PackageBranch {
  String? sId;
  String? name;
  int? daysCount;
  int? nightsCount;
  num? price;
  List<String>? includes;
  List<String>? excludes;
  List<PackageDay>? days;
  String? slug;
  List<City>? cities;

  PackageBranch({
    this.sId,
    this.name,
    this.daysCount,
    this.nightsCount,
    this.price,
    this.includes,
    this.excludes,
    this.days,
    this.slug,
    this.cities,
  });

  PackageBranch.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    name = json['name'];
    daysCount = json['daysCount'];
    nightsCount = json['nightsCount'];
    price = json['price'];
    includes = json['includes']?.cast<String>().toList();
    excludes = json['excludes']?.cast<String>().toList();
    if (json['days'] != null) {
      days = <PackageDay>[];
      json['days'].forEach((v) {
        days!.add(PackageDay.fromJson(v));
      });
    }
    slug = json['slug'];
    if (json['cities'] != null) {
      cities = <City>[];
      json['cities'].forEach((v) {
        cities!.add(City.fromJson(v));
      });
    }
  }
}

class PackageDay {
  int? dayNumber;
  String? type;
  String? customTitle;
  String? customDescription;
  City? city;
  Tour? tour;

  PackageDay({this.dayNumber, this.type, this.city, this.tour, this.customTitle, this.customDescription});

  PackageDay.fromJson(Map<String, dynamic> json) {
    dayNumber = json['dayNumber'];
    type = json['type'];
    customTitle = json['customTitle'];
    customDescription = json['customDescription'];
    city = json['city'] != null ? City.fromJson(json['city']) : null;
    tour = json['tour'] != null ? Tour.fromJson(json['tour']) : null;
  }
}

class PackageType {
  String? sId;
  String? name;

  PackageType.fromJson(Map<String, dynamic> json) {
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

class City {
  String? sId;
  String? name;
  String? descText;
  String? imageCover;
  String? slug;

  City.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    name = json['name'];
    descText = json['descText'];
    imageCover = json['imageCover'];
    slug = json['slug'];
  }
}

class Tour {
  String? sId;
  String? description;
  String? imageCover;
  String? slug;

  Tour.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    description = json['description'];
    imageCover = json['imageCover'];
    slug = json['slug'];
  }
}
