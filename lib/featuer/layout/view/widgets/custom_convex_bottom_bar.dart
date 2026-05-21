import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../logic/layout_cubit.dart';
import 'convex_bottom_bar_painter.dart';
import 'nav_item_widget.dart';

class CustomConvexBottomBar extends StatelessWidget {
  final LayoutCubit cubit;
  final VoidCallback onHomeTap;

  const CustomConvexBottomBar({
    super.key,
    required this.cubit,
    required this.onHomeTap,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        // Custom Painted Background with Convex Bump
        CustomPaint(
          size: Size(MediaQuery.of(context).size.width, 80.h),
          painter: ConvexBottomBarPainter(),
        ),
        // The Central Flight Button
        Positioned(
          bottom: 48.h,
          left: 0,
          right: 0,
          child: Center(
            child: Container(
              width: 65.w,
              height: 65.h,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: const Color(0xFF002868),
                boxShadow: [
                  BoxShadow(
                    color: const Color(0xFF002868).withValues(alpha: 0.4),
                    blurRadius: 10,
                    spreadRadius: 1,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: FloatingActionButton(
                onPressed: () => cubit.changeBottomNav(2),
                backgroundColor: Colors.transparent,
                elevation: 0,
                child: SvgPicture.asset(
                  'assets/icon/airplane.svg',
                  width: 30.w,
                  height: 30.h,
                  colorFilter: const ColorFilter.mode(
                    Colors.white,
                    BlendMode.srcIn,
                  ),
                ),
              ),
            ),
          ),
        ),
        // Navigation Items Row
        SizedBox(
          height: 75.h,
          child: Directionality(
            textDirection: TextDirection.rtl,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                NavItemWidget(
                  label: "الرئيسية",
                  asset: 'assets/icon/home_unslect.svg',
                  index: 4,
                  currentIndex: cubit.currentIndex,
                  onTap: () {
                    cubit.changeBottomNav(4);
                    onHomeTap();
                  },
                ),
                NavItemWidget(
                  label: "الجولات",
                  asset: 'assets/icon/maps.svg',
                  index: 3,
                  currentIndex: cubit.currentIndex,
                  onTap: () => cubit.changeBottomNav(3),
                ),
                SizedBox(width: 45.w), // Space for the bump
                NavItemWidget(
                  label: "الباقات",
                  asset: 'assets/icon/package-open.svg',
                  index: 1,
                  currentIndex: cubit.currentIndex,
                  onTap: () => cubit.changeBottomNav(1),
                ),
                NavItemWidget(
                  label: "المزيد",
                  icon: Icons.menu_rounded,
                  index: 0,
                  currentIndex: cubit.currentIndex,
                  onTap: () => cubit.changeBottomNav(0),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
