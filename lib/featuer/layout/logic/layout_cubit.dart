import 'package:flutter/material.dart';
import 'package:flutter_application_1/featuer/flightBooking/view/book_flight_view.dart';
import 'package:flutter_application_1/featuer/tours/view/tours_view.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../packages/packages_view.dart';
import '../../home/view/home_view.dart';
import 'layout_state.dart';

class LayoutCubit extends Cubit<LayoutState> {
  LayoutCubit() : super(LayoutInitial());

  static LayoutCubit get(context) => BlocProvider.of(context);

  int currentIndex = 0;

  // قائمة الصفحات بـ 5 عناصر حسب طلب المستخدم
  List<Widget> screens = [
    const HomeView(),
    const ToursView(),
    const BookFlightView(), // Airplane tab
    const PackageTypesView(),
    const Scaffold(
      body: Center(child: Text('المزيد')),
    ), // Placeholder for "More"
  ];

  void changeBottomNav(int index) {
    currentIndex = index;
    emit(LayoutChangeBottomNavState());
  }
}
