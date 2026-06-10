import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:flutter_application_1/core/utils/whatsapp_helper.dart';
import 'package:flutter_application_1/featuer/global_setting/manager/settings_cubit.dart';
import 'package:flutter_application_1/featuer/global_setting/manager/settings_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/theme/app_color.dart';

class HotelBookingBottomBar extends StatelessWidget {
  final num? price;
  final String? currency;

  final String? hotelName;

  const HotelBookingBottomBar({super.key, this.price, this.currency, this.hotelName});

  void _launchWhatsApp(BuildContext context) {
    final settingsState = context.read<SettingsCubit>().state;
    String phoneNumber = "+201090124803"; // Default fallback

    if (settingsState is SettingsSuccess) {
      final whatsAppSetting = settingsState.settings.socialMedia?.whatsApp;
      if (whatsAppSetting != null && whatsAppSetting.url != null) {
        phoneNumber = whatsAppSetting.url!.replaceAll(RegExp(r'[^0-9+]'), '');
      }
    }

    WhatsAppHelper.launchWhatsApp(
      phone: phoneNumber,
      message: "مرحباً، أود الاستفسار عن حجز في فندق: ${hotelName ?? 'غير محدد'}",
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.only(top: 20.h, bottom: 20.h, left: 8.w, right: 8.w),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: const [
          BoxShadow(
            color: Color(0x24000000),
            blurRadius: 8,
            offset: Offset(0, -3),
          ),
        ],
      ),
      child: SafeArea(
        top: false,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // --- Price Row ---
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Text(
                      "ابتداءً من ",
                      style: TextStyle(fontSize: 12.sp, color: Colors.black),
                    ),
                    Text(
                      "${price?.toInt() ?? 2300}",
                      style: TextStyle(
                        fontSize: 22.sp,
                        fontWeight: FontWeight.bold,
                        color: AppColor.primaryBlue,
                      ),
                    ),
                    SizedBox(width: 4.w),
                    SvgPicture.asset(
                      'assets/icon/RSA.svg',
                      height: 18.h,
                      colorFilter: const ColorFilter.mode(
                        AppColor.primaryBlue,
                        BlendMode.srcIn,
                      ),
                    ),
                  ],
                ),
                Text(
                  "(شامل ضريبة القيمة المضافة)",
                  style: TextStyle(fontSize: 10.sp, color: Colors.grey[600]),
                ),
              ],
            ),
            SizedBox(height: 16.h),
            // --- WhatsApp Button ---
            InkWell(
              onTap: () => _launchWhatsApp(context),
              borderRadius: BorderRadius.circular(76.r),
              child: Container(
                width: 343.w,
                height: 52.h,
                decoration: BoxDecoration(
                  color: const Color(0xFF4AC759),
                  borderRadius: BorderRadius.circular(76.r),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "تواصل معنا عبر واتساب",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16.sp,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(width: 8.w),
                    Icon(
                      FontAwesomeIcons.whatsapp,
                      color: Colors.white,
                      size: 24.sp,
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
