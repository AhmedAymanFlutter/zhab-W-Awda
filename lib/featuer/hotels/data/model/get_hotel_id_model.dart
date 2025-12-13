// lib/features/hotels/data/models/get_hotel_id_model.dart

class GetHotelIdModel {
  String? status;
  HotelIdData? data;

  GetHotelIdModel({this.status, this.data});

  GetHotelIdModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    // التعامل مع مشكلة المفتاح 'data' المتداخل إذا كان موجودًا
    if (json['data'] != null) {
      if (json['data']['data'] != null) {
        data = HotelIdData.fromJson(json['data']['data']);
      } else {
        data = HotelIdData.fromJson(json['data']);
      }
    }
  }
}

class HotelIdData {
  Price? price;
  String? sId;
  String? name;
  String? country;
  String? city;
  String? rating;
  String? category;
  String? description;
  String? descText;
  bool? isActive;
  String? phone;
  String? email;
  String? website;
  List<String>? images; // تم التغيير إلى List<String>
  String? slug;
  String? createdBy;
  String? createdAt;
  String? updatedAt;
  String? alt;
  int? iV;
  String? updatedBy;
  String? imageCover; // تمت إضافته يدويًا، مهم جدًا لواجهة المستخدم

  HotelIdData({
    this.price,
    this.sId,
    this.name,
    this.country,
    this.city,
    this.rating,
    this.category,
    this.description,
    this.descText,
    this.isActive,
    this.phone,
    this.email,
    this.website,
    this.images,
    this.slug,
    this.createdBy,
    this.createdAt,
    this.updatedAt,
    this.alt,
    this.iV,
    this.updatedBy,
    this.imageCover,
  });

  HotelIdData.fromJson(Map<String, dynamic> json) {
    price = json['price'] != null ? Price.fromJson(json['price']) : null;
    sId = json['_id'];
    name = json['name'];
    // التعامل مع الكائنات المعقدة إذا جاءت كسلاسل أو كائنات
    country = json['country'] is Map
        ? json['country']['name']
        : json['country'];
    city = json['city'] is Map ? json['city']['name'] : json['city'];

    rating = json['rating']?.toString();
    category = json['category'];
    description = json['description'];
    descText = json['descText'];
    isActive = json['isActive'];
    phone = json['phone'];
    email = json['email'];
    website = json['website'];

    if (json['images'] != null) {
      images = List<String>.from(
        json['images'].where((i) => i != null).map((i) => i.toString()),
      );
    }

    slug = json['slug'];
    createdBy = json['createdBy'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    alt = json['alt'];
    iV = json['__v'];
    updatedBy = json['updatedBy'];
    imageCover = json['imageCover'];
  }
}

class Price {
  String? min;
  String? max;

  Price.fromJson(Map<String, dynamic> json) {
    min = json['min']?.toString();
    max = json['max']?.toString();
  }
}
