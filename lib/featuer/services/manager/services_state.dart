import 'package:flutter_application_1/featuer/services/data/model/get_service_id_model.dart';
import 'package:flutter_application_1/featuer/services/data/model/get_services_model.dart';

abstract class ServicesState {}

class ServicesInitial extends ServicesState {}

class ServicesLoading extends ServicesState {}

class ServicesSuccess extends ServicesState {
  final List<ServiceItem> services;
  ServicesSuccess(this.services);
}

class ServicesError extends ServicesState {
  final String message;
  ServicesError(this.message);
}

class ServiceDetailsLoading extends ServicesState {}

class ServiceDetailsSuccess extends ServicesState {
  final ServiceIdData service;
  ServiceDetailsSuccess(this.service);
}

class ServiceDetailsError extends ServicesState {
  final String message;
  ServiceDetailsError(this.message);
}
