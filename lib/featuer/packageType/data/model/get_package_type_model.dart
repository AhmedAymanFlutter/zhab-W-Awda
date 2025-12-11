class GetPackageTypeModel {
  String? status;
  int? results;
  PackageTypesDataWrapper? data;

  GetPackageTypeModel({this.status, this.results, this.data});

  GetPackageTypeModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    results = json['results'];
    data = json['data'] != null
        ? PackageTypesDataWrapper.fromJson(json['data'])
        : null;
  }
}

class PackageTypesDataWrapper {
  List<PackageTypeItem>? packageTypes;

  PackageTypesDataWrapper({this.packageTypes});

  PackageTypesDataWrapper.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      packageTypes = <PackageTypeItem>[];
      json['data'].forEach((v) {
        packageTypes!.add(PackageTypeItem.fromJson(v));
      });
    }
  }
}

class PackageTypeItem {
  Seo? seo;
  String? sId;
  String? name;
  String? description;
  String? descText;
  String? imageCover;
  bool? isActive;
  String? slug;
  String? createdBy;
  String? createdAt;
  String? updatedAt;
  String? alt;
  String? updatedBy;

  PackageTypeItem({
    this.seo,
    this.sId,
    this.name,
    this.description,
    this.descText,
    this.imageCover,
    this.isActive,
    this.slug,
    this.createdBy,
    this.createdAt,
    this.updatedAt,
    this.alt,
    this.updatedBy,
  });

  PackageTypeItem.fromJson(Map<String, dynamic> json) {
    seo = json['seo'] != null ? Seo.fromJson(json['seo']) : null;
    sId = json['_id'];
    name = json['name'];
    description = json['description'];
    descText = json['descText'];
    imageCover = json['imageCover'];
    isActive = json['isActive'];
    slug = json['slug'];
    createdBy = json['createdBy'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    alt = json['alt'];
    updatedBy = json['updatedBy'];
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
    priority = json['priority'];
    ogTitle = json['ogTitle'];
    ogImage = json['ogImage'];
    ogDescription = json['ogDescription'];
  }
}
