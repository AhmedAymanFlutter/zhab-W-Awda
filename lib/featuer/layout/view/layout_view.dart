import 'package:flutter/material.dart';
import 'package:motion_tab_bar_v2/motion-tab-bar.dart';
import 'package:motion_tab_bar_v2/motion-tab-controller.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../../core/theme/app_color.dart';
import '../../../core/theme/app_text_style.dart';
import '../logic/layout_cubit.dart';
import '../logic/layout_state.dart';
import 'widgets/custom_drawer.dart';

class LayoutView extends StatefulWidget {
  const LayoutView({super.key});

  @override
  State<LayoutView> createState() => _LayoutViewState();
}

class _LayoutViewState extends State<LayoutView> with TickerProviderStateMixin {
  MotionTabBarController? _motionTabBarController;

  @override
  void initState() {
    super.initState();
    _motionTabBarController = MotionTabBarController(
      initialIndex: 0,
      length: 5,
      vsync: this,
    );
  }

  @override
  void dispose() {
    _motionTabBarController!.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => LayoutCubit(),
      child: BlocBuilder<LayoutCubit, LayoutState>(
        builder: (context, state) {
          var cubit = LayoutCubit.get(context);

          // Sync controller if cubit index changes from elsewhere (e.g. initial)
          if (_motionTabBarController!.index != cubit.currentIndex) {
            _motionTabBarController!.index = cubit.currentIndex;
          }

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
            drawer: const CustomDrawer(),
            body: cubit.screens[cubit.currentIndex],
            bottomNavigationBar: MotionTabBar(
              controller: _motionTabBarController,
              initialSelectedTab: "الرئيسية",
              labels: const [
                "الرئيسية",
                "الجولات",
                "طيران",
                "الباقات",
                "المزيد",
              ],
              iconWidgets: [
                _buildSvgIcon('assets/icon/home-09.svg', 0, cubit.currentIndex),
                _buildSvgIcon('assets/icon/maps.svg', 1, cubit.currentIndex),
                _buildSvgIcon(
                  'assets/icon/airplane.svg',
                  2,
                  cubit.currentIndex,
                ),
                _buildSvgIcon(
                  'assets/icon/package-open.svg',
                  3,
                  cubit.currentIndex,
                ),
                _buildSvgIcon(
                  'assets/icon/services-svgrepo-com.svg',
                  4,
                  cubit.currentIndex,
                ),
              ],
              tabSize: 55,
              tabBarHeight: 70,
              textStyle: AppTextStyle.setelMessiriTextStyle(
                fontSize: 12,
                fontWeight: FontWeight.bold,
                color: AppColor.primaryBlue,
              ),
              tabIconColor: AppColor.lightGrey,
              tabIconSelectedColor: Colors.white,
              tabSelectedColor: AppColor.primaryBlue,
              onTabItemSelected: (index) {
                if (index == 4) {
                  Scaffold.of(context).openDrawer();
                  _motionTabBarController!.index = cubit.currentIndex;
                } else {
                  cubit.changeBottomNav(index);
                }
              },
            ),
          );
        },
      ),
    );
  }

  Widget _buildSvgIcon(String asset, int index, int currentIndex) {
    final isSelected = index == currentIndex;
    return SvgPicture.asset(
      asset,
      width: 28,
      height: 28,
      colorFilter: ColorFilter.mode(
        isSelected ? Colors.white : AppColor.lightGrey,
        BlendMode.srcIn,
      ),
    );
  }

  // دالة مساعدة لتغيير عنوان الصفحة حسب التبويب المختار
  String _getAppBarTitle(int index) {
    switch (index) {
      case 0:
        return 'الرئيسية';
      case 1:
        return 'جولات سياحية';
      case 2:
        return 'حجز طيران';
      case 3:
        return 'باقات السفر';
      case 4:
        return 'المزيد';
      default:
        return 'ذهاب وعودة';
    }
  }
}
