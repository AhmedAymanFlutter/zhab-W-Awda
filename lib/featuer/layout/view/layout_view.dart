import 'package:flutter/material.dart';
import 'package:flutter_application_1/featuer/Auth/view/widgets/profile_widgets.dart';
import 'package:flutter_application_1/featuer/layout/view/widgets/floatingActionButton_widget.dart'
    show FloatingActionButtonWidget;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../../../core/theme/app_color.dart';
import '../../../core/theme/app_text_style.dart';
import '../logic/layout_cubit.dart';
import '../logic/layout_state.dart';
import 'widgets/custom_drawer.dart'; // استيراد الدروار الجديد

class LayoutView extends StatelessWidget {
  const LayoutView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => LayoutCubit(),
      child: BlocBuilder<LayoutCubit, LayoutState>(
        builder: (context, state) {
          var cubit = LayoutCubit.get(context);

          return Scaffold(
            backgroundColor: AppColor.primaryWhite,

            // --- 1. إضافة AppBar بسيط ليظهر زر القائمة ---
            appBar: AppBar(
              actions: [
                Padding(
                  padding: EdgeInsets.only(right: 12.w),
                  child: AvatarPicker(
                    radius: 20.r,
                    backgroundColor: AppColor.primaryBlue,
                    iconColor: AppColor.primaryRed,
                  ),
                ),
              ],
              backgroundColor: AppColor.mainWhite,
              elevation: 0,
              centerTitle: true,
              title: Text(
                _getAppBarTitle(cubit.currentIndex),
                style: AppTextStyle.setelMessiriTextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: AppColor.primaryBlue,
                ),
              ),
              iconTheme: const IconThemeData(color: AppColor.primaryBlue),
            ),

            // --- 2. ربط الـ Drawer ---
            drawer: const CustomDrawer(),

            body: cubit.screens[cubit.currentIndex],
            floatingActionButton: FloatingActionButtonWidget(),
            bottomNavigationBar: Container(
              decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.05),
                    blurRadius: 10,
                    offset: const Offset(0, -5),
                  ),
                ],
              ),
              child: NavigationBarTheme(
                data: NavigationBarThemeData(
                  labelTextStyle: WidgetStateProperty.resolveWith((states) {
                    if (states.contains(WidgetState.selected)) {
                      return AppTextStyle.setelMessiriTextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                        color: AppColor.primaryBlue,
                      );
                    }
                    return AppTextStyle.setelMessiriSecondlightGrey(
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                    );
                  }),
                ),
                child: NavigationBar(
                  height: 70.h,
                  backgroundColor: Colors.white,
                  indicatorColor: AppColor.primaryBlue.withOpacity(0.1),
                  elevation: 0,
                  selectedIndex: cubit.currentIndex,
                  onDestinationSelected: (index) {
                    cubit.changeBottomNav(index);
                  },
                  destinations: [
                    NavigationDestination(
                      icon: Icon(FontAwesomeIcons.home),
                      selectedIcon: Icon(
                        FontAwesomeIcons.home,
                        color: AppColor.primaryBlue,
                      ),
                      label: 'الرئيسية',
                    ),
                    NavigationDestination(
                      icon: Icon(FontAwesomeIcons.plane),
                      selectedIcon: Icon(
                        FontAwesomeIcons.plane,
                        color: AppColor.primaryBlue,
                      ),
                      label: 'الباقات',
                    ),
                    NavigationDestination(
                      icon: Icon(FontAwesomeIcons.hotel),
                      selectedIcon: Icon(
                        FontAwesomeIcons.hotel,
                        color: AppColor.primaryBlue,
                      ),
                      label: 'الفنادق',
                    ),
                    NavigationDestination(
                      icon: Icon(FontAwesomeIcons.map),
                      selectedIcon: Icon(
                        FontAwesomeIcons.map,
                        color: AppColor.primaryBlue,
                      ),
                      label: 'الجولات',
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  // دالة مساعدة لتغيير عنوان الصفحة حسب التبويب المختار
  String _getAppBarTitle(int index) {
    switch (index) {
      case 0:
        return 'الرئيسية';
      case 1:
        return 'باقات السفر';
      case 2:
        return 'أفضل الفنادق';
      case 3:
        return 'جولات سياحية';
      default:
        return 'ذهاب وعودة';
    }
  }
}
