import 'get_all_offers_model.dart';

class GetSingleOfferModel {
  String? status;
  OfferItem? data;

  GetSingleOfferModel({this.status, this.data});

  GetSingleOfferModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];

    if (json['data'] != null && json['data']['data'] != null) {
      data = OfferItem.fromJson(json['data']['data']);
    } else if (json['data'] != null) {
      try {
        data = OfferItem.fromJson(json['data']);
      } catch (e) {
        data = null;
      }
    }
  }
}
