import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../../core/theme/app_color.dart';
import '../../../core/theme/app_text_style.dart';
import '../logic/layout_cubit.dart';
import '../logic/layout_state.dart';
import 'widgets/custom_drawer.dart';
import '../../home/view/offer/manager/offers_cubit.dart';
import '../../home/view/package/manager/packages_cubit.dart';
import '../../hotels/manager/hotels_cubit.dart';
import '../../countries/manager/countries_cubit.dart';
import '../../Cities/manager/cities_cubit.dart';
import '../../tours/manager/tours_cubit.dart';

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
            extendBody: true,
            backgroundColor: AppColor.primaryWhite,
            drawer: const CustomDrawer(),
            body: cubit.screens[cubit.currentIndex],
            bottomNavigationBar: Stack(
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
                            color: const Color(0xFF002868).withOpacity(0.4),
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
                        _buildNavItem(
                          label: "الرئيسية",
                          asset: 'assets/icon/home_unslect.svg',
                          index: 4,
                          currentIndex: cubit.currentIndex,
                          onTap: () {
                            cubit.changeBottomNav(4);
                            _refreshHomeData(context);
                          },
                        ),
                        _buildNavItem(
                          label: "الجولات",
                          asset: 'assets/icon/maps.svg',
                          index: 3,
                          currentIndex: cubit.currentIndex,
                          onTap: () => cubit.changeBottomNav(3),
                        ),
                        SizedBox(width: 45.w), // Space for the bump
                        _buildNavItem(
                          label: "الباقات",
                          asset: 'assets/icon/package-open.svg',
                          index: 1,
                          currentIndex: cubit.currentIndex,
                          onTap: () => cubit.changeBottomNav(1),
                        ),
                        _buildNavItem(
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
            ),
          );
        },
      ),
    );
  }

  void _refreshHomeData(BuildContext context) {
    context.read<ToursCubit>().fetchTours();
    context.read<HotelsCubit>().fetchHotels();
    context.read<PackagesCubit>().fetchPackages();
    context.read<OffersCubit>().fetchOffers();
    context.read<CitiesCubit>().fetchCities();
    context.read<CountriesCubit>().fetchCountries();
  }

  Widget _buildNavItem({
    required String label,
    String? asset,
    IconData? icon,
    required int index,
    required int currentIndex,
    required VoidCallback onTap,
  }) {
    final bool isSelected = currentIndex == index;
    final Color color = isSelected
        ? const Color(0xFF002868)
        : const Color(0xFF98A2B3);

    return Expanded(
      child: GestureDetector(
        onTap: onTap,
        behavior: HitTestBehavior.opaque,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (asset != null)
              SvgPicture.asset(
                asset,
                width: 26.w,
                height: 26.h,
                colorFilter: ColorFilter.mode(color, BlendMode.srcIn),
              )
            else if (icon != null)
              Icon(icon, size: 28.sp, color: color),
            SizedBox(height: 4.h),
            Text(
              label,
              style: AppTextStyle.setelMessiriTextStyle(
                fontSize: 12,
                fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                color: color,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ConvexBottomBarPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.white
      ..style = PaintingStyle.fill;

    final path = Path();
    double width = size.width;
    double height = size.height;
    double centerWidth = width / 2;

    // Wave parameters
    double curveWidth = 80.w;
    double curveHeight = 38.h;

    path.moveTo(0, 0);
    path.lineTo(centerWidth - curveWidth * 1.5, 0);

    // Smooth Wave Bump
    path.cubicTo(
      centerWidth - curveWidth * 0.8,
      0,
      centerWidth - curveWidth * 0.6,
      -curveHeight,
      centerWidth,
      -curveHeight,
    );
    path.cubicTo(
      centerWidth + curveWidth * 0.6,
      -curveHeight,
      centerWidth + curveWidth * 0.8,
      0,
      centerWidth + curveWidth * 1.5,
      0,
    );

    path.lineTo(width, 0);
    path.lineTo(width, height);
    path.lineTo(0, height);
    path.close();

    // Soft Shadow
    canvas.drawShadow(
      path.shift(const Offset(0, -1)),
      Colors.black.withOpacity(0.12),
      12,
      false,
    );
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}
