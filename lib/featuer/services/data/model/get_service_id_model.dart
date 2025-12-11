class GetServiceIdModel {
  String? status;
  ServiceIdData? data;

  GetServiceIdModel({this.status, this.data});

  GetServiceIdModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    // Handle nested 'data' key issue
    if (json['data'] != null) {
      if (json['data']['data'] != null) {
        data = ServiceIdData.fromJson(json['data']['data']);
      } else {
        data = ServiceIdData.fromJson(json['data']);
      }
    }
  }
}

class ServiceIdData {
  Seo? seo;
  String? sId;
  String? name;
  String? imageCover;
  String? description;
  String? descText;
  String? method;
  String? summary;
  String? alt;
  String? createdAt;
  String? updatedAt;
  String? slug;
  int? iV;
  String? id;

  ServiceIdData({
    this.seo,
    this.sId,
    this.name,
    this.imageCover,
    this.description,
    this.descText,
    this.method,
    this.summary,
    this.alt,
    this.createdAt,
    this.updatedAt,
    this.slug,
    this.iV,
    this.id,
  });

  ServiceIdData.fromJson(Map<String, dynamic> json) {
    seo = json['seo'] != null ? Seo.fromJson(json['seo']) : null;
    sId = json['_id'];
    name = json['name'];
    imageCover = json['imageCover'];
    description = json['description'];
    descText = json['descText'];
    method = json['method'];
    summary = json['summary'];
    alt = json['alt'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    slug = json['slug'];
    iV = json['__v'];
    id = json['id'];
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
