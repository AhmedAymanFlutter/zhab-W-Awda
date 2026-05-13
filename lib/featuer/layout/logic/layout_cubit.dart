import 'package:flutter/material.dart';
import 'package:flutter_application_1/featuer/flightBooking/view/book_flight_view.dart';
import 'package:flutter_application_1/featuer/packageType/view/package_types_view.dart';
import 'package:flutter_application_1/featuer/tours/view/tours_view.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../home/view/home_view.dart';
import '../../more/presentation/view/more_view.dart';
import 'layout_state.dart';

class LayoutCubit extends Cubit<LayoutState> {
  LayoutCubit() : super(LayoutInitial());

  static LayoutCubit get(context) => BlocProvider.of(context);

  int currentIndex = 4;

  List<Widget> screens = [
    const MoreView(),
    const PackageTypesView(),
    const BookFlightView(),
    const ToursView(),
    const HomeView(),
  ];

  void changeBottomNav(int index) {
    currentIndex = index;
    emit(LayoutChangeBottomNavState());
  }
}
