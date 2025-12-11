import 'package:flutter/material.dart';
import 'package:flutter_application_1/featuer/hotels/view/hotels_view.dart';
import 'package:flutter_application_1/featuer/tours/view/tours_view.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../home/view/home_view.dart';
import '../../packages/packages_view.dart';
import 'layout_state.dart';

class LayoutCubit extends Cubit<LayoutState> {
  LayoutCubit() : super(LayoutInitial());

  static LayoutCubit get(context) => BlocProvider.of(context);

  int currentIndex = 0;

  // قائمة الصفحات بالترتيب
  List<Widget> screens = [
    const HomeView(),
    const PackageTypesView(),
    const HotelsView(),
    const ToursView(),
  ];

  void changeBottomNav(int index) {
    currentIndex = index;
    // هنا بنعمل emit عشان الـ UI يتحدث
    emit(LayoutChangeBottomNavState());
  }
}
