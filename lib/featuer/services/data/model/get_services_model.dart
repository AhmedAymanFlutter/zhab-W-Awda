class GetServicesModel {
  String? status;
  ServicesDataWrapper? data;

  GetServicesModel({this.status, this.data});

  GetServicesModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    data = json['data'] != null
        ? ServicesDataWrapper.fromJson(json['data'])
        : null;
  }
}

class ServicesDataWrapper {
  List<ServiceItem>? services;
  Settings? settings;

  ServicesDataWrapper({this.services, this.settings});

  ServicesDataWrapper.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      services = <ServiceItem>[];
      json['data'].forEach((v) {
        services!.add(ServiceItem.fromJson(v));
      });
    }
    settings = json['settings'] != null
        ? Settings.fromJson(json['settings'])
        : null;
  }
}

class ServiceItem {
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

  ServiceItem({
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

  ServiceItem.fromJson(Map<String, dynamic> json) {
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

// --- Sub Classes ---

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

class Settings {
  String? sId;
  ContactInfo? contactInfo;

  Settings.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    contactInfo = json['contactInfo'] != null
        ? ContactInfo.fromJson(json['contactInfo'])
        : null;
  }
}

class ContactInfo {
  List<Phones>? phones;

  ContactInfo.fromJson(Map<String, dynamic> json) {
    if (json['phones'] != null) {
      phones = <Phones>[];
      json['phones'].forEach((v) {
        phones!.add(Phones.fromJson(v));
      });
    }
  }
}

class Phones {
  String? number;
  String? label;
  bool? isPrimary;
  bool? isWhatsApp;
  String? countryCode;
  String? sId;

  Phones.fromJson(Map<String, dynamic> json) {
    number = json['number'];
    label = json['label'];
    isPrimary = json['isPrimary'];
    isWhatsApp = json['isWhatsApp'];
    countryCode = json['countryCode'];
    sId = json['_id'];
  }
}
