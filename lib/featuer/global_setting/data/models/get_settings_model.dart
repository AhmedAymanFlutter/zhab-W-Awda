class GetSettingsModel {
  String? status;
  SettingsData? data;

  GetSettingsModel({this.status, this.data});

  GetSettingsModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    data = json['data'] != null ? SettingsData.fromJson(json['data']) : null;
  }
}

class SettingsData {
  ContactInfo? contactInfo;
  SocialMedia? socialMedia;
  String? sId;

  SettingsData({this.contactInfo, this.socialMedia, this.sId});

  SettingsData.fromJson(Map<String, dynamic> json) {
    contactInfo = json['contactInfo'] != null
        ? ContactInfo.fromJson(json['contactInfo'])
        : null;
    socialMedia = json['socialMedia'] != null
        ? SocialMedia.fromJson(json['socialMedia'])
        : null;
    sId = json['_id'];
  }
}

class ContactInfo {
  List<PhoneItem>? phones;
  List<EmailItem>? emails;
  List<String>? addresses;

  ContactInfo({this.phones, this.emails, this.addresses});

  ContactInfo.fromJson(Map<String, dynamic> json) {
    if (json['phones'] != null) {
      phones = <PhoneItem>[];
      json['phones'].forEach((v) {
        phones!.add(PhoneItem.fromJson(v));
      });
    }
    if (json['emails'] != null) {
      emails = <EmailItem>[];
      json['emails'].forEach((v) {
        emails!.add(EmailItem.fromJson(v));
      });
    }
    if (json['addresses'] != null) {
      addresses = json['addresses'].cast<String>();
    }
  }
}

class PhoneItem {
  String? number;
  String? label;
  bool? isPrimary;
  bool? isWhatsApp;
  String? countryCode;

  PhoneItem({
    this.number,
    this.label,
    this.isPrimary,
    this.isWhatsApp,
    this.countryCode,
  });

  PhoneItem.fromJson(Map<String, dynamic> json) {
    number = json['number'];
    label = json['label'];
    isPrimary = json['isPrimary'];
    isWhatsApp = json['isWhatsApp'];
    countryCode = json['countryCode'];
  }
}

class EmailItem {
  String? email;
  String? label;
  bool? isPrimary;

  EmailItem({this.email, this.label, this.isPrimary});

  EmailItem.fromJson(Map<String, dynamic> json) {
    email = json['email'];
    label = json['label'];
    isPrimary = json['isPrimary'];
  }
}

class SocialMedia {
  SocialPlatform? facebook;
  SocialPlatform? instagram;
  SocialPlatform? youtube;
  SocialPlatform? twitter;
  SocialPlatform? tiktok;
  SocialPlatform? snapchat;
  SocialPlatform? whatsApp;

  SocialMedia({
    this.facebook,
    this.instagram,
    this.youtube,
    this.twitter,
    this.tiktok,
    this.snapchat,
    this.whatsApp,
  });

  SocialMedia.fromJson(Map<String, dynamic> json) {
    facebook = json['facebook'] != null
        ? SocialPlatform.fromJson(json['facebook'])
        : null;
    instagram = json['instagram'] != null
        ? SocialPlatform.fromJson(json['instagram'])
        : null;
    youtube = json['youtube'] != null
        ? SocialPlatform.fromJson(json['youtube'])
        : null;
    twitter = json['twitter'] != null
        ? SocialPlatform.fromJson(json['twitter'])
        : null;
    tiktok = json['tiktok'] != null
        ? SocialPlatform.fromJson(json['tiktok'])
        : null;
    snapchat = json['snapchat'] != null
        ? SocialPlatform.fromJson(json['snapchat'])
        : null;
    whatsApp = json['whatsApp'] != null
        ? SocialPlatform.fromJson(json['whatsApp'])
        : null;
  }

  // Helper method to get non-null platforms as a list for easy UI iteration
  List<SocialPlatform> getActivePlatforms() {
    List<SocialPlatform> list = [];
    if (facebook != null) list.add(facebook!);
    if (instagram != null) list.add(instagram!);
    if (youtube != null) list.add(youtube!);
    if (twitter != null) list.add(twitter!);
    if (tiktok != null) list.add(tiktok!);
    if (snapchat != null) list.add(snapchat!);
    if (whatsApp != null) list.add(whatsApp!);
    return list;
  }
}

class SocialPlatform {
  String? name;
  String? url;
  String? deskTopImage;
  String? mobileImage;

  SocialPlatform({this.name, this.url, this.deskTopImage, this.mobileImage});

  SocialPlatform.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    url = json['url'];
    deskTopImage = json['deskTopImage'];
    mobileImage = json['mobileImage'];
  }
}
