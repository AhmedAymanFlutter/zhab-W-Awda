// lib/features/home/data/models/get_all_offers_model.dart

class GetAllOffersModel {
  String? status;
  int? results;
  OfferDataWrapper? data;

  GetAllOffersModel({this.status, this.results, this.data});

  GetAllOffersModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    results = (json['results'] as num?)?.toInt();
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
  String? originPrice;
  String? oldPrice;

  OfferItem({
    this.sId,
    this.imageCover,
    this.offer,
    this.name,
    this.description,
    this.price,
    this.originPrice,
    this.oldPrice,
  });

  OfferItem.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    imageCover = json['imageCover'];
    offer = json['offer'];
    name = json['name'];
    description = json['description'];
    
    // Handle complex price object {amount: 100, currency: AED}
    if (json['price'] != null) {
      if (json['price'] is Map) {
        final amt = json['price']['amount'];
        final curr = json['price']['currency'];
        price = amt?.toString();
        originPrice = "$amt $curr";
      } else {
        price = json['price'].toString();
        originPrice = price;
      }
    }

    if (json['oldPrice'] != null) {
      if (json['oldPrice'] is Map) {
        final amt = json['oldPrice']['amount'];
        final curr = json['oldPrice']['currency'];
        oldPrice = "$amt $curr";
      } else {
        oldPrice = json['oldPrice'].toString();
      }
    }
  }
}
