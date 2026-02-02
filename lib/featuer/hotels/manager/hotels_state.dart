import 'package:flutter_application_1/featuer/hotels/data/model/getHotel_model.dart';
import 'package:flutter_application_1/featuer/hotels/data/model/get_hotel_id_model.dart';

abstract class HotelsState {}

class HotelsInitial extends HotelsState {}

class HotelsLoading extends HotelsState {}

class HotelsSuccess extends HotelsState {
  final List<HotelItem> hotels;
  HotelsSuccess(this.hotels);
}

class HotelsError extends HotelsState {
  final String message;
  HotelsError(this.message);
}

class HotelDetailsLoading extends HotelsState {}

class HotelDetailsSuccess extends HotelsState {
  final HotelIdData hotel;
  final List<HotelItem> relatedHotels;
  HotelDetailsSuccess(this.hotel, {this.relatedHotels = const []});
}

class HotelDetailsError extends HotelsState {
  final String message;
  HotelDetailsError(this.message);
}

class HotelCountriesLoading extends HotelsState {}

class HotelCountriesSuccess extends HotelsState {}

class HotelCountriesError extends HotelsState {
  final String message;
  HotelCountriesError(this.message);
}
