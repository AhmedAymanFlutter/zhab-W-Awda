import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
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
                _buildSvgIcon(
                  asset: 'assets/icon/home_unslect.svg',
                  unselectedAsset: 'assets/icon/home_unslect.svg',
                  index: 0,
                ),
                _buildSvgIcon(
                  asset: 'assets/icon/maps.svg',
                  unselectedAsset: 'assets/icon/maps_unselect.svg',
                  index: 1,
                ),
                _buildSvgIcon(
                  asset: 'assets/icon/airplane.svg',
                  index: 2,
                ),
                _buildSvgIcon(
                  asset: 'assets/icon/package-open.svg',
                  unselectedAsset: 'assets/icon/package_unselected.svg',
                  index: 3,
                ),
                _buildSvgIcon(
                  asset: 'assets/icon/services-svgrepo-com.svg',
                  index: 4,
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
              tabSelectedColor: AppColor.primaryBlue3,
              onTabItemSelected: (index) {
                cubit.changeBottomNav(index);
              },
            ),
          );
        },
      ),
    );
  }

  Widget _buildSvgIcon({
    required String asset,
    String? unselectedAsset,
    required int index,
  }) {
    return ListenableBuilder(
      listenable: _motionTabBarController!,
      builder: (context, child) {
        final isSelected = _motionTabBarController!.index == index;
        return SvgPicture.asset(
          isSelected ? asset : (unselectedAsset ?? asset),
          width: 32.h,
          height: 32.h,
          colorFilter: ColorFilter.mode(
            isSelected ? Colors.white : AppColor.lightGrey,
            BlendMode.srcIn,
          ),
        );
      },
    );
  }
}
