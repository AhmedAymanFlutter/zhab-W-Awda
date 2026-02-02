import 'package:flutter/material.dart';
import 'package:flutter_application_1/core/router/routes.dart';
import 'package:flutter_application_1/core/theme/app_color.dart';
import 'package:flutter_application_1/featuer/layout/data/models/drawer_item_model.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../../core/theme/app_text_style.dart';

class CustomDrawer extends StatelessWidget {
  const CustomDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    // قائمة العناصر المطلوبة
    final List<DrawerItemModel> drawerItems = [
      DrawerItemModel(
        title: "الدليل السياحي",
        icon: SvgPicture.asset(
          'assets/icon/map-point-wave-svgrepo-com.svg',
          width: 24.w,
          height: 24.h,
          fit: BoxFit.scaleDown,
          colorFilter: ColorFilter.mode(AppColor.primaryBlue, BlendMode.srcIn),
        ),
        onTap: () {
          Navigator.pushNamed(context, Routes.countriesView);
        },
      ),
      DrawerItemModel(
        title: "وجهات الفنادق",
        icon: SvgPicture.asset(
          'assets/icon/hotel_filled.svg',
          width: 24.w,
          height: 24.h,
          fit: BoxFit.scaleDown,
          colorFilter: ColorFilter.mode(AppColor.primaryBlue, BlendMode.srcIn),
        ),
        onTap: () {
          Navigator.pushNamed(context, Routes.hotelCountriesView);
        },
      ),
      DrawerItemModel(
        title: "حجز الطيران",
        icon: SvgPicture.asset(
          'assets/icon/booking-destination-internet-svgrepo-com.svg',
          width: 24.w,
          height: 24.h,
          fit: BoxFit.scaleDown,
          colorFilter: ColorFilter.mode(AppColor.primaryBlue, BlendMode.srcIn),
        ),
        onTap: () {
          Navigator.pushNamed(context, Routes.bookFlightView);
        },
      ),
      DrawerItemModel(
        title: "المدن",
        icon: SvgPicture.asset(
          'assets/icon/city-block-svgrepo-com.svg',
          width: 24.w,
          height: 24.h,
          fit: BoxFit.scaleDown,
          colorFilter: ColorFilter.mode(AppColor.primaryBlue, BlendMode.srcIn),
        ),
        onTap: () {
          Navigator.pushNamed(context, Routes.cities);
        },
      ),
      DrawerItemModel(
        title: "الخدمات",
        icon: SvgPicture.asset(
          'assets/icon/services-svgrepo-com.svg',
          width: 24.w,
          height: 24.h,
          fit: BoxFit.scaleDown,
          colorFilter: ColorFilter.mode(AppColor.primaryBlue, BlendMode.srcIn),
        ),
        onTap: () {
          Navigator.pushNamed(context, Routes.servicesView);
        },
      ),
      DrawerItemModel(
        title: "تواصل معنا",
        icon: SvgPicture.asset(
          'assets/icon/call-chat-rounded-svgrepo-com.svg',
          width: 24.w,
          height: 24.h,
          fit: BoxFit.scaleDown,
          colorFilter: ColorFilter.mode(AppColor.primaryBlue, BlendMode.srcIn),
        ),
        onTap: () {
          Navigator.pushNamed(context, Routes.contactUsView);
        },
      ),

      DrawerItemModel(
        title: "آراء العملاء",
        icon: SvgPicture.asset(
          'assets/icon/star-sharp-svgrepo-com.svg',
          width: 24.w,
          height: 24.h,
          fit: BoxFit.scaleDown,
          colorFilter: ColorFilter.mode(AppColor.primaryBlue, BlendMode.srcIn),
        ),
        onTap: () {
          Navigator.pushNamed(context, Routes.reviewsView);
        },
      ),
    ];

    return Drawer(
      backgroundColor: AppColor.mainWhite,
      shape: const RoundedRectangleBorder(),
      child: Column(
        children: [
          // --- 1. Header (Logo & Welcome) ---
          Container(
            width: double.infinity,
            padding: EdgeInsets.only(top: 50.h, bottom: 20.h),
            decoration: const BoxDecoration(color: AppColor.primaryBlue),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CircleAvatar(
                  radius: 40.r,
                  backgroundColor: Colors.white,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Image.asset(
                      "assets/photo/mainLogo.webp",
                    ), // تأكد من مسار اللوجو
                  ),
                ),
                SizedBox(height: 12.h),
                Text(
                  "أهلاً بك في ذهاب وعودة",
                  style: AppTextStyle.setelMessiriWhite(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),

          SizedBox(height: 20.h),

          // --- 2. List Items ---
          Expanded(
            child: ListView.separated(
              padding: EdgeInsets.symmetric(horizontal: 16.w),
              itemCount: drawerItems.length,
              separatorBuilder: (context, index) => Divider(
                color: AppColor.lightGrey.withOpacity(0.3),
                height: 20.h,
              ),
              itemBuilder: (context, index) {
                return ListTile(
                  leading: drawerItems[index].icon,
                  title: Text(
                    drawerItems[index].title,
                    style: AppTextStyle.setelMessiriBlack(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                    ),
                  ),

                  onTap: () {
                    Navigator.pop(context); // غلق الدروار أولاً
                    drawerItems[index].onTap(); // تنفيذ الأكشن
                  },
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  hoverColor: AppColor.primaryBlue.withOpacity(0.05),
                );
              },
            ),
          ),

          // --- 3. Footer (Version or Logout) ---
          Padding(
            padding: EdgeInsets.only(bottom: 30.h),
            child: Text(
              "الإصدار 1.0.0",
              style: AppTextStyle.setelMessiriSecondlightGrey(
                fontSize: 12,
                fontWeight: FontWeight.normal,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
