import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:url_launcher/url_launcher.dart';
import '../data/repo/settings_repository.dart';
import '../manager/settings_cubit.dart';
import '../manager/settings_state.dart';
import 'widgets/contact_hero_section.dart';
import 'widgets/contact_features_card.dart';
import 'widgets/contact_info_grid.dart';
import 'widgets/contact_cta_section.dart';

class ContactUsView extends StatelessWidget {
  const ContactUsView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SettingsCubit(SettingsRepository())..fetchSettings(),
      child: Scaffold(
        backgroundColor: const Color(0xFFF4F6F9),
        body: BlocBuilder<SettingsCubit, SettingsState>(
          builder: (context, state) {
            String? whatsappUrl;
            if (state is SettingsSuccess) {
              whatsappUrl = state.settings.socialMedia?.whatsApp?.url;
            }
            return CustomScrollView(
              physics: const BouncingScrollPhysics(),
              slivers: [
                // Hero Section (takes the full top area)
                SliverToBoxAdapter(
                  child: ContactHeroSection(
                    onContactTap: () => _launchUrl(whatsappUrl ?? ''),
                  ),
                ),
                SliverToBoxAdapter(child: SizedBox(height: 24.h)),

                // Main Features Card
                const SliverToBoxAdapter(child: ContactFeaturesCard()),
                SliverToBoxAdapter(child: SizedBox(height: 24.h)),

                // Info Cards Grid (مهمتنا / رسالتنا / رؤيتنا / حجز سهل)
                const SliverToBoxAdapter(child: ContactInfoGrid()),
                SliverToBoxAdapter(child: SizedBox(height: 24.h)),

                // Bottom CTA Card
                SliverToBoxAdapter(
                  child: ContactCtaSection(
                    onContactTap: () => _launchUrl(whatsappUrl ?? ''),
                  ),
                ),
                SliverToBoxAdapter(child: SizedBox(height: 50.h)),
              ],
            );
          },
        ),
      ),
    );
  }

  Future<void> _launchUrl(String url) async {
    if (url.isEmpty) return;
    final Uri uri = Uri.parse(url);
    if (!await launchUrl(uri, mode: LaunchMode.externalApplication)) {
      debugPrint("Could not launch $url");
    }
  }
}
