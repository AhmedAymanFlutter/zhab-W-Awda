class GetTourGuideDetailsModel {
  bool? success;
  TourGuideData? data;

  GetTourGuideDetailsModel({this.success, this.data});

  GetTourGuideDetailsModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    data = json['data'] != null ? TourGuideData.fromJson(json['data']) : null;
  }
}

class TourGuideData {
  bool? isPoular;
  Country? country;
  List<GuideCity>? cities;
  String? introduction;
  List<GuideFeature>? features;
  List<GuideRestaurant>? restaurants;
  List<GuideThingToDo>? thingsToDo;
  List<GuideHotel>? hotels;

  TourGuideData({
    this.isPoular,
    this.country,
    this.cities,
    this.introduction,
    this.features,
    this.restaurants,
    this.thingsToDo,
    this.hotels,
  });

  TourGuideData.fromJson(Map<String, dynamic> json) {
    isPoular = json['isPoular'];
    country = json['country'] != null ? Country.fromJson(json['country']) : null;
    if (json['cities'] != null) {
      cities = <GuideCity>[];
      json['cities'].forEach((v) {
        cities!.add(GuideCity.fromJson(v));
      });
    }
    introduction = json['introduction'];
    if (json['features'] != null) {
      features = <GuideFeature>[];
      json['features'].forEach((v) {
        features!.add(GuideFeature.fromJson(v));
      });
    }
    if (json['restaurants'] != null) {
      restaurants = <GuideRestaurant>[];
      json['restaurants'].forEach((v) {
        restaurants!.add(GuideRestaurant.fromJson(v));
      });
    }
    if (json['thingsToDo'] != null) {
      thingsToDo = <GuideThingToDo>[];
      json['thingsToDo'].forEach((v) {
        thingsToDo!.add(GuideThingToDo.fromJson(v));
      });
    }
    if (json['hotels'] != null) {
      hotels = <GuideHotel>[];
      json['hotels'].forEach((v) {
        hotels!.add(GuideHotel.fromJson(v));
      });
    }
  }
}

class Country {
  String? sId;
  String? name;
  String? slug;
  String? continent;
  String? descText;
  String? description;
  String? language;
  String? imageCover;

  Country.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    name = json['name'];
    slug = json['slug'];
    continent = json['continent'];
    descText = json['descText'];
    description = json['description'];
    language = json['language'];
    imageCover = json['imageCover'];
  }
}

class GuideCity {
  String? sId;
  String? name;
  String? slug;
  List<String>? images;
  String? descText;
  String? description;

  GuideCity.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    name = json['name'];
    slug = json['slug'];
    images = json['images']?.cast<String>();
    descText = json['descText'];
    description = json['description'];
  }
}

class GuideFeature {
  String? title;
  String? icon;
  String? description;

  GuideFeature.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    icon = json['icon'];
    description = json['description'];
  }
}

class GuideRestaurant {
  String? name;
  String? description;
  String? imageCover;
  String? sId;

  GuideRestaurant.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    description = json['description'];
    imageCover = json['imageCover'];
    sId = json['_id'];
  }
}

class GuideThingToDo {
  String? name;
  String? description;
  String? imageCover;
  String? sId;

  GuideThingToDo.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    description = json['description'];
    imageCover = json['imageCover'];
    sId = json['_id'];
  }
}

class GuideHotel {
  String? sId;
  String? hotelName;
  List<String>? images;
  String? description;
  String? overview;
  String? slug;

  GuideHotel.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    hotelName = json['hotel_name'];
    images = json['images']?.cast<String>();
    description = json['description'];
    overview = json['overview'];
    slug = json['slug'];
  }
}
