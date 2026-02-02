import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/featuer/layout/view/widgets/floatingActionButton_widget.dart'
    show FloatingActionButtonWidget;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
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

            appBar: AppBar(
              backgroundColor: AppColor.primaryBlue,
              elevation: 0,
              centerTitle: true,
              title: Text(
                _getAppBarTitle(cubit.currentIndex),
                style: AppTextStyle.setelMessiriTextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              iconTheme: const IconThemeData(color: Colors.white),
            ),

            // Drawer ---
            drawer: const CustomDrawer(),

            body: cubit.screens[cubit.currentIndex],
            floatingActionButton: FloatingActionButtonWidget(),
            bottomNavigationBar: SafeArea(
              child: CurvedNavigationBar(
                backgroundColor: Colors.transparent,
                color: AppColor.primaryBlue,
                buttonBackgroundColor: Colors.white,
                height: 75.h,
                animationDuration: const Duration(milliseconds: 300),
                animationCurve: Curves.easeInOut,
                index: cubit.currentIndex,
                onTap: (index) {
                  cubit.changeBottomNav(index);
                },
                items: <Widget>[
                  cubit.currentIndex == 0
                      ? SvgPicture.asset(
                          'assets/icon/home-2.svg',
                          width: 30.w,
                          height: 30.h,
                          color: AppColor.primaryBlue,
                          fit: BoxFit.scaleDown,
                        )
                      : Padding(
                          padding: EdgeInsets.only(top: 8.h),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              SvgPicture.asset(
                                'assets/icon/home-2.svg',
                                width: 30.w,
                                height: 30.h,
                                color: Colors.white,
                                fit: BoxFit.scaleDown,
                              ),
                              SizedBox(height: 4.h),
                              Text(
                                'الرئيسية',
                                style: AppTextStyle.setelMessiriTextStyle(
                                  fontSize: 10,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                            ],
                          ),
                        ),
                  cubit.currentIndex == 1
                      ? SvgPicture.asset(
                          'assets/icon/Packages.svg',
                          width: 30.w,
                          height: 30.h,
                          color: AppColor.primaryBlue,
                          fit: BoxFit.scaleDown,
                        )
                      : Padding(
                          padding: EdgeInsets.only(top: 8.h),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              SvgPicture.asset(
                                'assets/icon/Packages.svg',
                                width: 30.w,
                                height: 30.h,
                                color: Colors.white,
                                fit: BoxFit.scaleDown,
                              ),
                              SizedBox(height: 4.h),
                              Text(
                                'الباقات',
                                style: AppTextStyle.setelMessiriTextStyle(
                                  fontSize: 10,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                            ],
                          ),
                        ),
                  cubit.currentIndex == 2
                      ? SvgPicture.asset(
                          'assets/icon/hotel_filled.svg',
                          width: 30.w,
                          height: 30.h,
                          color: AppColor.primaryBlue,
                          fit: BoxFit.scaleDown,
                        )
                      : Padding(
                          padding: EdgeInsets.only(top: 8.h),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              SvgPicture.asset(
                                'assets/icon/hotel_filled.svg',
                                width: 30.w,
                                height: 30.h,
                                color: Colors.white,
                                fit: BoxFit.scaleDown,
                              ),
                              SizedBox(height: 4.h),
                              Text(
                                'الفنادق',
                                style: AppTextStyle.setelMessiriTextStyle(
                                  fontSize: 10,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                            ],
                          ),
                        ),
                  cubit.currentIndex == 3
                      ? SvgPicture.asset(
                          'assets/icon/bag.svg',
                          width: 30.w,
                          height: 30.h,
                          color: AppColor.primaryBlue,
                          fit: BoxFit.scaleDown,
                        )
                      : Padding(
                          padding: EdgeInsets.only(top: 8.h),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              SvgPicture.asset(
                                'assets/icon/bag.svg',
                                width: 30.w,
                                height: 30.h,
                                color: Colors.white,
                                fit: BoxFit.scaleDown,
                              ),
                              SizedBox(height: 4.h),
                              Text(
                                'الجولات',
                                style: AppTextStyle.setelMessiriTextStyle(
                                  fontSize: 10,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                            ],
                          ),
                        ),
                ],
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
