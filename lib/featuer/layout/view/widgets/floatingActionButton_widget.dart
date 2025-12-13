import 'package:flutter/material.dart';
import 'package:flutter_application_1/core/theme/app_color.dart';
import 'package:flutter_application_1/featuer/global_setting/manager/settings_cubit.dart';
import 'package:flutter_application_1/featuer/global_setting/manager/settings_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

class FloatingActionButtonWidget extends StatelessWidget {
  const FloatingActionButtonWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      onPressed: () async {
        // 1. Get the current Settings State
        final settingsState = context.read<SettingsCubit>().state;
        String? targetNumber;

        // 2. Find the WhatsApp number from API data
        if (settingsState is SettingsSuccess) {
          final phones = settingsState.settings.contactInfo?.phones;

          if (phones != null && phones.isNotEmpty) {
            // Try to find one marked isWhatsApp, otherwise take the first one
            final whatsAppPhone = phones.firstWhere(
              (p) => p.isWhatsApp == true,
              orElse: () => phones.first,
            );
            targetNumber = whatsAppPhone.number;
          }
        }

        // 3. Validation
        if (targetNumber == null || targetNumber.isEmpty) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text("رقم الواتساب غير متوفر حالياً")),
          );
          return;
        }

        // 4. Launch WhatsApp
        final cleanNumber = targetNumber.replaceAll('+', '');
        final Uri whatsappUrl = Uri.parse("https://wa.me/$cleanNumber");

        try {
          if (!await launchUrl(
            whatsappUrl,
            mode: LaunchMode.externalApplication,
          )) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text("Could not open WhatsApp")),
            );
          }
        } catch (e) {
          debugPrint("Error: $e");
        }
      },
      backgroundColor: AppColor.primaryBlue,
      elevation: 4,
      shape: const CircleBorder(),
      child: const Icon(FontAwesomeIcons.whatsapp, color: Colors.white),
    );
  }
}
