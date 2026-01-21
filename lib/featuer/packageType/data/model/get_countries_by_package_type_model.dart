class GetCountriesByPackageTypeModel {
  bool? success;
  String? message;
  List<CountryInPackageItem>? data;

  GetCountriesByPackageTypeModel({this.success, this.message, this.data});

  GetCountriesByPackageTypeModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
    if (json['data'] != null) {
      data = <CountryInPackageItem>[];
      if (json['data'] is Map && json['data']['packages'] != null) {
        json['data']['packages'].forEach((v) {
          data!.add(CountryInPackageItem.fromJson(v));
        });
      } else if (json['data'] is List) {
        json['data'].forEach((v) {
          data!.add(CountryInPackageItem.fromJson(v));
        });
      }
    }
  }
}

class CountryInPackageItem {
  String? sId;
  String? name;
  String? imageCover;
  String? slug;
  String? id;

  CountryInPackageItem({
    this.sId,
    this.name,
    this.imageCover,
    this.slug,
    this.id,
  });

  CountryInPackageItem.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    name = json['name'];
    imageCover = json['imageCover'];
    slug = json['slug'];
    id = json['id'];
  }
}
