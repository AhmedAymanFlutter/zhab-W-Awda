// lib/features/home/data/models/get_all_offers_model.dart

class GetAllOffersModel {
  String? status;
  int? results;
  OfferDataWrapper? data;

  GetAllOffersModel({this.status, this.results, this.data});

  GetAllOffersModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    results = json['results'];
    data = json['data'] != null
        ? OfferDataWrapper.fromJson(json['data'])
        : null;
  }
}

class OfferDataWrapper {
  List<OfferItem>? offersList;

  OfferDataWrapper({this.offersList});

  OfferDataWrapper.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      offersList = <OfferItem>[];
      json['data'].forEach((v) {
        offersList!.add(OfferItem.fromJson(v));
      });
    }
  }
}

class OfferItem {
  String? sId;
  String? imageCover;
  String? offer;
  String? name;
  String? description;
  String? price;
  String? oldPrice;

  OfferItem({
    this.sId,
    this.imageCover,
    this.offer,
    this.name,
    this.description,
    this.price,
    this.oldPrice,
  });

  OfferItem.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    imageCover = json['imageCover'];
    offer = json['offer'];
    name = json['name'];
    description = json['description'];
    price = json['price'];
    oldPrice = json['oldPrice'];
  }
}
