class FlightDestinationResponse {
  bool? success;
  List<FlightDestination>? data;

  FlightDestinationResponse({this.success, this.data});

  FlightDestinationResponse.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    if (json['data'] != null) {
      data = <FlightDestination>[];
      json['data'].forEach((v) {
        data!.add(FlightDestination.fromJson(v));
      });
    }
  }
}

class FlightDestination {
  String? id;
  String? name;
  String? code;
  String? cityName;
  String? countryName;
  String? type;
  String? photo;

  FlightDestination({
    this.id,
    this.name,
    this.code,
    this.cityName,
    this.countryName,
    this.type,
    this.photo,
  });

  FlightDestination.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    code = json['code'];
    cityName = json['cityName'];
    countryName = json['countryName'];
    type = json['type'];
    photo = json['photo'];
  }
}
