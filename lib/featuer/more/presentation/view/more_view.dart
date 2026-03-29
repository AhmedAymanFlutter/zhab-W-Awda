import 'package:flutter/material.dart';
import 'package:flutter_application_1/core/router/routes.dart';
import 'package:flutter_application_1/core/theme/app_color.dart';
import 'package:flutter_application_1/core/widgets/main_app_header.dart';
import 'package:flutter_application_1/featuer/more/presentation/view/widgets/more_menu_item.dart';
import 'package:flutter_application_1/featuer/more/presentation/view/widgets/profile_card.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class MoreView extends StatelessWidget {
  const MoreView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F7F9),
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: MainAppHeader(title: "ذهاب و عودة"),
            ),
            Expanded(
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                padding: EdgeInsets.all(16.w),
                child: Column(
                  children: [
                    const ProfileCard(),
                    SizedBox(height: 20.h),
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(16.r),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.05),
                            blurRadius: 10,
                            offset: const Offset(0, 4),
                          ),
                        ],
                      ),
                      child: Column(
                        children: [
                          MoreMenuItem(
                            title: "نبذة عنا",
                            iconPath:
                                "assets/icon/call-chat-rounded-svgrepo-com.svg",
                            onTap: () {
                              Navigator.pushNamed(
                                context,
                                Routes.contactUsView,
                              );
                            },
                          ),
                          const Divider(height: 1),
                          MoreMenuItem(
                            title: "الفنادق",
                            iconPath: "assets/icon/city-block-svgrepo-com.svg",
                            iconColor: AppColor.primaryBlue,
                            onTap: () {
                              Navigator.pushNamed(context, Routes.hotelsView);
                            },
                          ),
                          const Divider(height: 1),
                          MoreMenuItem(
                            title: "الجولات",
                            iconPath: "assets/icon/maps.svg",
                            iconColor: Colors.blueAccent,
                            onTap: () {
                              Navigator.pushNamed(context, Routes.toursView);
                            },
                          ),
                          const Divider(height: 1),
                          MoreMenuItem(
                            title: "الباقات",
                            iconPath: "assets/icon/package-open.svg",
                            iconColor: Colors.indigo,
                            onTap: () {
                              Navigator.pushNamed(context, Routes.packagesView);
                            },
                          ),
                          const Divider(height: 1),
                          MoreMenuItem(
                            title: "الطيران",
                            iconPath: "assets/icon/airplane.svg",
                            iconColor: Colors.lightBlue,
                            onTap: () {
                              Navigator.pushNamed(
                                context,
                                Routes.bookFlightView,
                              );
                            },
                          ),
                          const Divider(height: 1),
                          MoreMenuItem(
                            title: "الدليل السياحي",
                            iconPath:
                                "assets/icon/map-point-wave-svgrepo-com.svg",
                            iconColor: Colors.blueGrey,
                            onTap: () {
                              Navigator.pushNamed(
                                context,
                                Routes.countriesView,
                              );
                            },
                          ),
                          const Divider(height: 1),
                          MoreMenuItem(
                            title: "الخدمات",
                            iconPath: "assets/icon/services-svgrepo-com.svg",
                            iconColor: Colors.blue,
                            onTap: () {
                              Navigator.pushNamed(context, Routes.servicesView);
                            },
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
