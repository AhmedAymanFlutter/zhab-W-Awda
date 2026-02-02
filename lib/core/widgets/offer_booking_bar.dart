import 'package:flutter/material.dart';
import 'package:flutter_application_1/featuer/global_setting/manager/settings_cubit.dart';
import 'package:flutter_application_1/featuer/global_setting/manager/settings_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

import '../theme/app_color.dart';
import '../theme/app_text_style.dart';

class OfferBookingBar extends StatelessWidget {
  final String? offerName;
  final String? price;
  final String? targetPhoneNumber;
  final String? bookingUrl;

  const OfferBookingBar({
    super.key,
    this.offerName,
    this.price,
    this.targetPhoneNumber,
    this.bookingUrl,
  });

  Future<void> _handleBooking(BuildContext context) async {
    // 1. If we have a direct booking URL, use it.
    if (bookingUrl != null && bookingUrl!.isNotEmpty) {
      final Uri url = Uri.parse(bookingUrl!);
      try {
        if (!await launchUrl(url, mode: LaunchMode.externalApplication)) {
          if (context.mounted) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text("Could not launch booking URL")),
            );
          }
        }
      } catch (e) {
        debugPrint("Error launching URL: $e");
      }
      return;
    }

    // 2. Fallback to WhatsApp
    await _bookOnWhatsApp(context);
  }

  Future<void> _bookOnWhatsApp(BuildContext context) async {
    String? finalDataNumber;

    // 1. Prefer passed phone number
    if (targetPhoneNumber != null && targetPhoneNumber!.isNotEmpty) {
      finalDataNumber = targetPhoneNumber;
    } else {
      // 2. Fallback to settings
      final settingsState = context.read<SettingsCubit>().state;
      if (settingsState is SettingsSuccess) {
        final phones = settingsState.settings.contactInfo?.phones;
        if (phones != null && phones.isNotEmpty) {
          final whatsAppNumber = phones.firstWhere(
            (phone) => phone.isWhatsApp == true,
            orElse: () => phones.first,
          );
          finalDataNumber = whatsAppNumber.number;
        }
      }
    }

    if (finalDataNumber == null || finalDataNumber.isEmpty) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("عذراً، رقم التواصل غير متوفر حالياً")),
        );
      }
      return;
    }

    final cleanNumber = finalDataNumber.replaceAll('+', '');
    final String message =
        "مرحباً، أريد حجز هذا العرض${offerName != null ? ': $offerName' : ''}";

    final Uri whatsappUrl = Uri.parse(
      "https://wa.me/$cleanNumber?text=${Uri.encodeComponent(message)}",
    );

    try {
      if (!await launchUrl(whatsappUrl, mode: LaunchMode.externalApplication)) {
        if (context.mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text("Could not launch WhatsApp")),
          );
        }
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
        child: price != null
            ? _buildWithPrice(context)
            : SizedBox(width: double.infinity, child: _buildButton(context)),
      ),
    );
  }

  Widget _buildWithPrice(BuildContext context) {
    return Row(
      children: [
        Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "يبدأ من",
              style: AppTextStyle.setelMessiriSecondlightGrey(
                fontSize: 12,
                fontWeight: FontWeight.bold,
              ),
            ),
            RichText(
              text: TextSpan(
                children: [
                  TextSpan(
                    text: "$price",
                    style: AppTextStyle.setelMessiriDeepPurple(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  TextSpan(
                    text: " ج.م",
                    style: AppTextStyle.setelMessiriDeepPurple(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        const Spacer(),
        _buildButton(context),
      ],
    );
  }

  Widget _buildButton(BuildContext context) {
    return ElevatedButton(
      onPressed: () => _handleBooking(context),
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColor.primaryBlue,
        padding: EdgeInsets.symmetric(
          vertical: 15.h,
          horizontal: price != null ? 32.w : 0,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16.r),
        ),
        elevation: 0,
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            bookingUrl != null && bookingUrl!.isNotEmpty
                ? FontAwesomeIcons.globe
                : FontAwesomeIcons.whatsapp,
            color: Colors.white,
          ),
          SizedBox(width: 8.w),
          Text(
            "احجز الآن",
            style: AppTextStyle.setelMessiriWhite(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}
