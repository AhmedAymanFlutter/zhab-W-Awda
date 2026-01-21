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
  List<City>? cities; // Changed from List<String>
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
  String?
  city; // Keeping this flexible, might be removed or unused, but let's check parsing

  PackageItem({
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
    sId = json['_id'];
    name = json['name'];
    price = json['price']?.toString();
    rate = json['rate']?.toString();
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

    if (json['includes'] != null) {
      includes = (json['includes'] as List).map((e) => e.toString()).toList();
    } else {
      includes = [];
    }

    if (json['excludes'] != null) {
      excludes = (json['excludes'] as List).map((e) => e.toString()).toList();
    } else {
      excludes = [];
    }

    country = json['country'] != null
        ? Country.fromJson(json['country'])
        : null;

    // Parse cities as Objects
    if (json['cities'] != null) {
      cities = <City>[];
      json['cities'].forEach((v) {
        if (v is Map<String, dynamic>) {
          cities!.add(City.fromJson(v));
        } else if (v is String) {
          // Handle case where it might be string IDs or names
          cities!.add(City(name: v));
        }
      });
    } else {
      cities = [];
    }

    images = json['images'] != null ? List<String>.from(json['images']) : [];

    description = json['description'];
    descText = json['descText'];
    createdBy = json['createdBy'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    updatedBy = json['updatedBy'];
    slug = json['slug'];
    alt = json['alt'];
    imageCover = json['imageCover'];

    // Safe handling for city field which might be object or string or null
    // If city is an object with name, extract name. If string, use it.
    if (json['city'] != null) {
      if (json['city'] is Map) {
        city = json['city']['name']?.toString();
      } else {
        city = json['city'].toString();
      }
    } else {
      // Fallback: use first city from list if available
      if (cities != null && cities!.isNotEmpty) {
        city = cities![0].name;
      }
    }
  }
}

// ... existing sub classes ...

class City {
  String? sId;
  String? name;

  City({this.sId, this.name});

  City.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    name = json['name'];
  }
}

// --- Sub Classes ---

class Header {
  String? dayNumber;
  String? nights;
  String? location;
  String? sId;

  Header.fromJson(Map<String, dynamic> json) {
    dayNumber = json['dayNumber']?.toString();
    nights = json['nights']?.toString();
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
