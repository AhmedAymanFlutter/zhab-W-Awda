class GetPackageIdModel {
  bool? success;
  String? message;
  PackageIdData? data;

  GetPackageIdModel({this.success, this.message, this.data});

  GetPackageIdModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
    data = json['data'] != null ? PackageIdData.fromJson(json['data']) : null;
  }
}

class PackageIdData {
  Pkg? pkg;
  List<Branch>? branches;
  List<RelatedPackage>? relatedPackages;

  PackageIdData({this.pkg, this.branches, this.relatedPackages});

  PackageIdData.fromJson(Map<String, dynamic> json) {
    pkg = json['pkg'] != null ? Pkg.fromJson(json['pkg']) : null;
    if (json['branches'] != null) {
      branches = <Branch>[];
      json['branches'].forEach((v) {
        branches!.add(Branch.fromJson(v));
      });
    }
    if (json['relatedPackages'] != null) {
      relatedPackages = <RelatedPackage>[];
      json['relatedPackages'].forEach((v) {
        relatedPackages!.add(RelatedPackage.fromJson(v));
      });
    }
  }
}

class Pkg {
  String? sId;
  String? name;
  String? description;
  String? descText;
  List<String>? images;
  String? imageCover; // Helper for UI if images list is used
  Country? country;
  List<City>? cities;
  PackageType? packageType;
  int? ratingsAverage;
  int? ratingsQuantity;
  String? slug;

  Pkg({
    this.sId,
    this.name,
    this.description,
    this.descText,
    this.images,
    this.country,
    this.cities,
    this.packageType,
    this.ratingsAverage,
    this.ratingsQuantity,
    this.slug,
  });

  Pkg.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    name = json['name'];
    description = json['description'];
    descText = json['descText'];
    if (json['images'] != null) {
      images = List<String>.from(json['images']);
    }
    // Logic to set imageCover from first image if available, or handle separately if needed
    if (images != null && images!.isNotEmpty) {
      imageCover = images![0];
    }

    country = json['country'] != null
        ? Country.fromJson(json['country'])
        : null;
    if (json['cities'] != null) {
      cities = <City>[];
      json['cities'].forEach((v) {
        cities!.add(City.fromJson(v));
      });
    }
    packageType = json['packageType'] != null
        ? PackageType.fromJson(json['packageType'])
        : null;
    ratingsAverage = (json['ratingsAverage'] as num?)?.toInt();
    ratingsQuantity = (json['ratingsQuantity'] as num?)?.toInt();
    slug = json['slug'];
  }
}

class Branch {
  String? sId;
  String? name;
  int? daysCount;
  int? nightsCount;
  dynamic price; // Changed from int? to handle Map/Number
  String? originPrice;
  List<String>? includes;
  List<String>? excludes;
  List<Day>? days;

  Branch({
    this.sId,
    this.name,
    this.daysCount,
    this.nightsCount,
    this.price,
    this.includes,
    this.excludes,
    this.days,
    this.originPrice,
  });

  Branch.fromJson(dynamic json) {
    if (json is Map<String, dynamic>) {
      sId = json['_id'];
      name = json['name'];
      daysCount = (json['daysCount'] as num?)?.toInt();
      nightsCount = (json['nightsCount'] as num?)?.toInt();
      // Handle complex price object {amount: 100, currency: AED}
      if (json['price'] != null) {
        if (json['price'] is Map) {
          final amt = json['price']['amount'];
          final curr = json['price']['currency'];
          price = amt?.toString();
          originPrice = "$amt $curr";
        } else {
          price = json['price'].toString();
          originPrice = price;
        }
      }
      if (json['includes'] != null) {
        includes = List<String>.from(json['includes']);
      }
      if (json['excludes'] != null) {
        excludes = List<String>.from(json['excludes']);
      }
      if (json['days'] != null) {
        days = <Day>[];
        json['days'].forEach((v) {
          days!.add(Day.fromJson(v));
        });
      }
    } else if (json is String) {
      sId = json;
    }
  }
}

class Day {
  int? dayNumber;
  String? type;
  Tour? tour;

  Day({this.dayNumber, this.type, this.tour});

  Day.fromJson(dynamic json) {
    if (json is Map<String, dynamic>) {
      dayNumber = (json['dayNumber'] as num?)?.toInt();
      type = json['type'];
      tour = json['tour'] != null ? Tour.fromJson(json['tour']) : null;
    }
  }
}

class Tour {
  String? sId;
  String? title;
  String? description;
  String? descText;
  List<String>? includes;
  List<String>? excludes;
  TourHeader? header;
  List<TourPath>? paths;
  List<String>? images;

  Tour({
    this.sId,
    this.title,
    this.description,
    this.descText,
    this.includes,
    this.excludes,
    this.header,
    this.paths,
    this.images,
  });

  Tour.fromJson(dynamic json) {
    if (json is Map<String, dynamic>) {
      sId = json['_id'];
      title = json['title'];
      description = json['description'];
      descText = json['descText'];
      if (json['includes'] != null) {
        includes = List<String>.from(json['includes']);
      }
      if (json['excludes'] != null) {
        excludes = List<String>.from(json['excludes']);
      }
      header = json['header'] != null
          ? TourHeader.fromJson(json['header'])
          : null;
      if (json['paths'] != null) {
        paths = <TourPath>[];
        json['paths'].forEach((v) {
          paths!.add(TourPath.fromJson(v));
        });
      }
      if (json['images'] != null) {
        images = List<String>.from(json['images']);
      }
    } else if (json is String) {
      sId = json;
    }
  }
}

class TourHeader {
  String? days;
  String? people;
  String? type;

  TourHeader({this.days, this.people, this.type});

  TourHeader.fromJson(dynamic json) {
    if (json is Map<String, dynamic>) {
      days = json['days'];
      people = json['people'];
      type = json['type'];
    }
  }
}

class TourPath {
  String? title;
  String? duration;
  String? description;
  String? descText;

  TourPath({this.title, this.duration, this.description, this.descText});

  TourPath.fromJson(dynamic json) {
    if (json is Map<String, dynamic>) {
      title = json['title'];
      duration = json['duration'];
      description = json['description'];
      descText = json['descText'];
    }
  }
}

class RelatedPackage {
  String? sId;
  String? name;
  String? descText;
  String? slug;
  int? ratingsAverage;

  RelatedPackage({
    this.sId,
    this.name,
    this.descText,
    this.slug,
    this.ratingsAverage,
  });

  RelatedPackage.fromJson(dynamic json) {
    if (json is Map<String, dynamic>) {
      sId = json['_id'];
      name = json['name'];
      descText = json['descText'];
      slug = json['slug'];
      ratingsAverage = (json['ratingsAverage'] as num?)?.toInt();
    } else if (json is String) {
      sId = json;
    }
  }
}

class Country {
  String? sId;
  String? name;

  Country({this.sId, this.name});

  Country.fromJson(dynamic json) {
    if (json is Map<String, dynamic>) {
      sId = json['_id'];
      name = json['name'];
    } else if (json is String) {
      sId = json;
    }
  }
}

class City {
  String? sId;
  String? name;

  City({this.sId, this.name});

  City.fromJson(dynamic json) {
    if (json is Map<String, dynamic>) {
      sId = json['_id'];
      name = json['name'];
    } else if (json is String) {
      sId = json;
    }
  }
}

class PackageType {
  String? sId;
  String? name;

  PackageType({this.sId, this.name});

  PackageType.fromJson(dynamic json) {
    if (json is Map<String, dynamic>) {
      sId = json['_id'];
      name = json['name'];
    } else if (json is String) {
      sId = json;
    }
  }
}
