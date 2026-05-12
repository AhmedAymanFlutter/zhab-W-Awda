import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../../../../../../core/theme/app_color.dart';
import '../../../../../../core/theme/app_text_style.dart';
import 'package:flutter_application_1/core/utils/whatsapp_helper.dart';
import 'package:flutter_application_1/featuer/global_setting/manager/settings_cubit.dart';
import 'package:flutter_application_1/featuer/global_setting/manager/settings_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PackageBookingPanel extends StatelessWidget {
  final num? price;
  final String? currency;
  final String? packageName;

  const PackageBookingPanel({
    super.key,
    required this.price,
    this.currency = "ريال",
    this.packageName,
  });

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
      message: "مرحباً، أريد الاستفسار عن باقة: ${packageName ?? 'غير محدد'}",
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 16.h),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, -5),
          ),
        ],
      ),
      child: SafeArea(
        top: false,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "تفاصيل الباقة",
                      style: AppTextStyle.setelMessiriBlack(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      "السعر لـ 2 شخص",
                      style: TextStyle(
                        fontSize: 12.sp,
                        color: Colors.grey[600],
                      ),
                    ),
                  ],
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.baseline,
                  textBaseline: TextBaseline.alphabetic,
                  children: [
                    Text(
                      "$price",
                      style: AppTextStyle.setelMessiriBlack(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ).copyWith(color: AppColor.primaryBlue),
                    ),
                    SizedBox(width: 4.w),
                    Text(
                      currency!,
                      style: TextStyle(
                        fontSize: 14.sp,
                        fontWeight: FontWeight.bold,
                        color: AppColor.primaryBlue,
                      ),
                    ),
                  ],
                ),
              ],
            ),
            SizedBox(height: 16.h),
            _buildInstallmentInfo(),
            SizedBox(height: 16.h),
            GestureDetector(
              onTap: () => _launchWhatsApp(context),
              child: _buildWhatsAppButton(),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInstallmentInfo() {
    return Container(
      padding: EdgeInsets.all(12.w),
      decoration: BoxDecoration(
        color: Colors.grey[50],
        borderRadius: BorderRadius.circular(12.r),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            "التقسيط متاح",
            style: TextStyle(fontSize: 12.sp, color: Colors.grey[600]),
          ),
          SizedBox(width: 12.w),
          Text(
            "tamara | tabby",
            style: TextStyle(
              fontSize: 16.sp,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildWhatsAppButton() {
    return Container(
      width: double.infinity,
      height: 56.h,
      decoration: BoxDecoration(
        color: const Color(0xFF4CAF50),
        borderRadius: BorderRadius.circular(28.r),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(FontAwesomeIcons.whatsapp, color: Colors.white),
          SizedBox(width: 12.w),
          Text(
            "تواصل معنا عبر واتساب",
            style: TextStyle(
              fontSize: 16.sp,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }
}
