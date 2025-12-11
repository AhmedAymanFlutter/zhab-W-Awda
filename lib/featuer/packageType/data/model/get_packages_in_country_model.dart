import 'package:flutter_application_1/featuer/home/view/package/data/model/get_all_packages_model.dart';

class GetPackagesInCountryModel {
  bool? success;
  String? message;
  List<PackageItem>? data;

  GetPackagesInCountryModel({this.success, this.message, this.data});

  GetPackagesInCountryModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
    if (json['data'] != null) {
      data = <PackageItem>[];
      json['data'].forEach((v) {
        // Reuse the existing PackageItem.fromJson
        data!.add(PackageItem.fromJson(v));
      });
    }
  }
}
