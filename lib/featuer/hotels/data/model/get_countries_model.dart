class GetHotelCountriesModel {
  bool? success;
  String? message;
  int? count;
  List<CountryItem>? data;

  GetHotelCountriesModel({this.success, this.message, this.count, this.data});

  GetHotelCountriesModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
    count = json['count'];
    if (json['data'] != null) {
      data = <CountryItem>[];
      json['data'].forEach((v) {
        data!.add(CountryItem.fromJson(v));
      });
    }
  }
}

class CountryItem {
  String? country;
  String? label;

  CountryItem({this.country, this.label});

  CountryItem.fromJson(Map<String, dynamic> json) {
    country = json['country'];
    label = json['label'];
  }
}
