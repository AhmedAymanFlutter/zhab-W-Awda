class GetPackageTypeModel {
  String? status;
  double? results;
  PackageTypesDataWrapper? data;

  GetPackageTypeModel({this.status, this.results, this.data});

  GetPackageTypeModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    results = (json['results'] as num?)?.toDouble();
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
