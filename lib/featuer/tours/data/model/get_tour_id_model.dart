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
  String? city;
  String? country;
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
  TourPrice? price;
  TourRating? rating;
  int? duration;
  List<String>? tags;
  List<ProductOption>? productOptions;

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
    this.price,
    this.rating,
    this.duration,
    this.tags,
    this.productOptions,
  });

  TourIdData.fromJson(Map<String, dynamic> json) {
    seo = json['seo'] != null ? Seo.fromJson(json['seo']) : null;
    sId = json['_id'];
    title = json['title'];
    description = json['description'];
    descText = json['descText'];
    
    if (json['price'] != null) {
      if (json['price'] is Map<String, dynamic>) {
        price = TourPrice.fromJson(json['price']);
      } else {
        price = TourPrice(amount: (json['price'] as num?)?.toDouble());
      }
    }

    if (json['rating'] != null) {
      rating = TourRating.fromJson(json['rating']);
    }

    duration = (json['duration'] as num?)?.toInt();
    tags = json['tags'] != null ? List<String>.from(json['tags']) : [];

    // Handle dynamic types just in case
    city = json['city'] is Map ? json['city']['name'] : json['city'];
    country = json['country'] is Map ? json['country']['name'] : json['country'];

    includes = json['includes'] != null ? List<String>.from(json['includes']) : [];
    excludes = json['excludes'] != null ? List<String>.from(json['excludes']) : [];

    header = json['header'] != null ? Header.fromJson(json['header']) : null;

    if (json['paths'] != null) {
      paths = <Paths>[];
      json['paths'].forEach((v) {
        paths!.add(Paths.fromJson(v));
      });
    }

    if (json['productOptions'] != null) {
      productOptions = <ProductOption>[];
      json['productOptions'].forEach((v) {
        productOptions!.add(ProductOption.fromJson(v));
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

class TourPrice {
  double? amount;
  String? currency;

  TourPrice({this.amount, this.currency});

  TourPrice.fromJson(Map<String, dynamic> json) {
    amount = (json['amount'] as num?)?.toDouble();
    currency = json['currency'];
  }
}

class TourRating {
  double? average;
  int? count;

  TourRating({this.average, this.count});

  TourRating.fromJson(Map<String, dynamic> json) {
    average = (json['average'] as num?)?.toDouble();
    count = (json['count'] as num?)?.toInt();
  }
}

class ProductOption {
  String? optionCode;
  String? title;
  List<String>? packageDescription;
  List<String>? termsAndConditions;
  List<String>? howToUse;
  double? price;
  String? currency;
  String? id;

  ProductOption({
    this.optionCode,
    this.title,
    this.packageDescription,
    this.termsAndConditions,
    this.howToUse,
    this.price,
    this.currency,
    this.id,
  });

  ProductOption.fromJson(Map<String, dynamic> json) {
    optionCode = json['optionCode'];
    title = json['title'];
    packageDescription = json['packageDescription'] != null ? List<String>.from(json['packageDescription']) : [];
    termsAndConditions = json['termsAndConditions'] != null ? List<String>.from(json['termsAndConditions']) : [];
    howToUse = json['howToUse'] != null ? List<String>.from(json['howToUse']) : [];
    price = (json['price'] as num?)?.toDouble();
    currency = json['currency'];
    id = json['id'];
  }
}

class Seo {
  double? priority;
  String? changeFrequency;
  String? noIndex;
  String? noFollow;
  String? noArchive;
  String? noSnippet;

  Seo.fromJson(Map<String, dynamic> json) {
    priority = (json['priority'] as num?)?.toDouble();
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
