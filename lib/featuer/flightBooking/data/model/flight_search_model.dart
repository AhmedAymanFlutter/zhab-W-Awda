class FlightSearchResponse {
  final bool? success;
  final FlightSearchData? data;

  FlightSearchResponse({this.success, this.data});

  factory FlightSearchResponse.fromJson(Map<String, dynamic> json) {
    return FlightSearchResponse(
      success: json['success'],
      data: json['data'] != null
          ? FlightSearchData.fromJson(json['data'])
          : null,
    );
  }
}

class FlightSearchData {
  final int? count;
  final String? tripType;
  final List<FlightItinerary>? itineraries;

  FlightSearchData({this.count, this.tripType, this.itineraries});

  factory FlightSearchData.fromJson(Map<String, dynamic> json) {
    return FlightSearchData(
      count: json['count'],
      tripType: json['tripType'],
      itineraries: json['itineraries'] != null
          ? (json['itineraries'] as List)
                .map((i) => FlightItinerary.fromJson(i))
                .toList()
          : null,
    );
  }
}

class FlightItinerary {
  final String? token;
  final double? totalPrice;
  final String? currencyCode;
  final String? cabinClass;
  final Airline? airline;
  final Baggage? baggage;
  final String? handoverSummary;
  final Outbound? outbound;
  final bool? isCheapest;
  final bool? isFastest;
  final bool? isBest;

  FlightItinerary({
    this.token,
    this.totalPrice,
    this.currencyCode,
    this.cabinClass,
    this.airline,
    this.baggage,
    this.handoverSummary,
    this.outbound,
    this.isCheapest,
    this.isFastest,
    this.isBest,
  });

  factory FlightItinerary.fromJson(Map<String, dynamic> json) {
    return FlightItinerary(
      token: json['token'],
      totalPrice: (json['totalPrice'] as num?)?.toDouble(),
      currencyCode: json['currencyCode'],
      cabinClass: json['cabinClass'],
      airline: json['airline'] != null
          ? Airline.fromJson(json['airline'])
          : null,
      baggage: json['baggage'] != null
          ? Baggage.fromJson(json['baggage'])
          : null,
      handoverSummary: json['handoverSummary'],
      outbound: json['outbound'] != null
          ? Outbound.fromJson(json['outbound'])
          : null,
      isCheapest: json['isCheapest'],
      isFastest: json['isFastest'],
      isBest: json['isBest'],
    );
  }
}

class Airline {
  final String? name;
  final String? logo;
  final String? code;

  Airline({this.name, this.logo, this.code});

  factory Airline.fromJson(Map<String, dynamic> json) {
    return Airline(name: json['name'], logo: json['logo'], code: json['code']);
  }
}

class Baggage {
  final bool? personalItem;
  final bool? cabinBag;
  final bool? checkedBag;
  final String? summary;

  Baggage({this.personalItem, this.cabinBag, this.checkedBag, this.summary});

  factory Baggage.fromJson(Map<String, dynamic> json) {
    return Baggage(
      personalItem: json['personalItem'],
      cabinBag: json['cabinBag'],
      checkedBag: json['checkedBag'],
      summary: json['summary'],
    );
  }
}

class Outbound {
  final FlightLocation? origin;
  final FlightLocation? destination;
  final String? departureTime;
  final String? arrivalTime;
  final Map<String, String>? formattedTimes;
  final String? totalDuration;
  final int? stopsCount;
  final String? stopsLabel;
  final List<Connection>? connections;

  Outbound({
    this.origin,
    this.destination,
    this.departureTime,
    this.arrivalTime,
    this.formattedTimes,
    this.totalDuration,
    this.stopsCount,
    this.stopsLabel,
    this.connections,
  });

  factory Outbound.fromJson(Map<String, dynamic> json) {
    return Outbound(
      origin: json['origin'] != null
          ? FlightLocation.fromJson(json['origin'])
          : null,
      destination: json['destination'] != null
          ? FlightLocation.fromJson(json['destination'])
          : null,
      departureTime: json['departureTime'],
      arrivalTime: json['arrivalTime'],
      formattedTimes: json['formattedTimes'] != null
          ? Map<String, String>.from(json['formattedTimes'])
          : null,
      totalDuration: json['totalDuration'],
      stopsCount: json['stopsCount'],
      stopsLabel: json['stopsLabel'],
      connections: json['connections'] != null
          ? (json['connections'] as List)
                .map((c) => Connection.fromJson(c))
                .toList()
          : null,
    );
  }
}

class FlightLocation {
  final String? code;
  final String? name;
  final String? city;

  FlightLocation({this.code, this.name, this.city});

  factory FlightLocation.fromJson(Map<String, dynamic> json) {
    return FlightLocation(
      code: json['code'],
      name: json['name'],
      city: json['city'],
    );
  }
}

class Connection {
  final String? flightNumber;
  final Airline? carrier;
  final String? origin;
  final String? destination;
  final String? departureTime;
  final String? arrivalTime;
  final String? duration;
  final LayoverInfo? layoverInfo;

  Connection({
    this.flightNumber,
    this.carrier,
    this.origin,
    this.destination,
    this.departureTime,
    this.arrivalTime,
    this.duration,
    this.layoverInfo,
  });

  factory Connection.fromJson(Map<String, dynamic> json) {
    return Connection(
      flightNumber: json['flightNumber'],
      carrier: json['carrier'] != null
          ? Airline.fromJson(json['carrier'])
          : null,
      origin: json['origin'],
      destination: json['destination'],
      departureTime: json['departureTime'],
      arrivalTime: json['arrivalTime'],
      duration: json['duration'],
      layoverInfo: json['layoverInfo'] != null
          ? LayoverInfo.fromJson(json['layoverInfo'])
          : null,
    );
  }
}

class LayoverInfo {
  final String? duration;
  final String? airport;

  LayoverInfo({this.duration, this.airport});

  factory LayoverInfo.fromJson(Map<String, dynamic> json) {
    return LayoverInfo(duration: json['duration'], airport: json['airport']);
  }
}
