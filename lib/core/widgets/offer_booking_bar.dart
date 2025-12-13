import 'package:flutter/material.dart';
import 'package:flutter_application_1/featuer/global_setting/manager/settings_cubit.dart';
import 'package:flutter_application_1/featuer/global_setting/manager/settings_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

import '../theme/app_color.dart';

class OfferBookingBar extends StatelessWidget {
  final String? offerName;

  const OfferBookingBar({super.key, this.offerName});

  Future<void> _bookOnWhatsApp(BuildContext context) async {
    final settingsState = context.read<SettingsCubit>().state;

    String? targetNumber;

    if (settingsState is SettingsSuccess) {
      final phones = settingsState.settings.contactInfo?.phones;

      if (phones != null && phones.isNotEmpty) {
        final whatsAppNumber = phones.firstWhere(
          (phone) => phone.isWhatsApp == true,
          orElse: () => phones.first,
        );

        targetNumber = whatsAppNumber.number;
      }
    }

    if (targetNumber == null || targetNumber.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("عذراً، رقم التواصل غير متوفر حالياً")),
      );
      return;
    }

    final cleanNumber = targetNumber.replaceAll('+', '');
    final String message =
        "مرحباً، أريد حجز هذا العرض${offerName != null ? ': $offerName' : ''}";

    final Uri whatsappUrl = Uri.parse(
      "https://wa.me/$cleanNumber?text=${Uri.encodeComponent(message)}",
    );

    // 5. Launch
    try {
      if (!await launchUrl(whatsappUrl, mode: LaunchMode.externalApplication)) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Could not launch WhatsApp")),
        );
      }
    } catch (e) {
      debugPrint("Error launching WhatsApp: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 15.h),
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
        child: SizedBox(
          width: double.infinity,
          child: ElevatedButton(
            onPressed: () {
              _bookOnWhatsApp(context);
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColor.primaryBlue,
              padding: EdgeInsets.symmetric(vertical: 15.h),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16.r),
              ),
              elevation: 0,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(FontAwesomeIcons.whatsapp, color: Colors.white),
                SizedBox(width: 8.w),
                Text(
                  "احجز الآن",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16.sp,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
