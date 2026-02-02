import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../../../../core/theme/app_color.dart';
import '../../../../core/theme/app_text_style.dart';
import '../data/repo/settings_repository.dart';
import '../manager/settings_cubit.dart';
import '../manager/settings_state.dart';
import 'widgets/contact_card.dart';
import 'widgets/social_media_tile.dart';

class ContactUsView extends StatelessWidget {
  const ContactUsView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SettingsCubit(SettingsRepository())..fetchSettings(),
      child: Scaffold(
        backgroundColor: AppColor.primaryWhite,
        appBar: AppBar(
          backgroundColor: AppColor.primaryBlue,
          elevation: 0,
          leading: const BackButton(color: AppColor.primaryWhite),
          title: Text(
            "تواصل معنا",
            style: AppTextStyle.setelMessiriBlack(
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ).copyWith(color: AppColor.primaryWhite),
          ),
          centerTitle: true,
          titleSpacing: 0,
        ),
        body: BlocBuilder<SettingsCubit, SettingsState>(
          builder: (context, state) {
            if (state is SettingsLoading) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is SettingsError) {
              return Center(child: Text(state.message));
            } else if (state is SettingsSuccess) {
              final data = state.settings;

              return SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                padding: EdgeInsets.symmetric(horizontal: 20.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 24.h),
                    // Call & Email Cards Row
                    Row(
                      children: [
                        Expanded(
                          child: ContactCard(
                            icon: FontAwesomeIcons.phone,
                            title: "اتصل بنا",
                            subtitle: "فريقنا متاح على الخط",
                            hours: "يومياً ",
                            onTap: () {
                              if (data.contactInfo?.phones != null &&
                                  data.contactInfo!.phones!.isNotEmpty) {
                                var phone = data.contactInfo!.phones!
                                    .firstWhere(
                                      (element) => element.isPrimary == true,
                                      orElse: () =>
                                          data.contactInfo!.phones!.first,
                                    )
                                    .number;
                                if (phone != null) {
                                  _launchUrl('tel:$phone');
                                }
                              }
                            },
                          ),
                        ),
                        SizedBox(width: 16.w),
                        Expanded(
                          child: ContactCard(
                            icon: FontAwesomeIcons.envelope,
                            title: "راسلنا",
                            subtitle: "فريقنا متواجد أونلاين",
                            hours: "يومياً ",
                            onTap: () {
                              if (data.contactInfo?.emails != null &&
                                  data.contactInfo!.emails!.isNotEmpty) {
                                var email = data.contactInfo!.emails!
                                    .firstWhere(
                                      (element) => element.isPrimary == true,
                                      orElse: () =>
                                          data.contactInfo!.emails!.first,
                                    )
                                    .email;
                                if (email != null) {
                                  _launchUrl('mailto:$email');
                                }
                              }
                            },
                          ),
                        ),
                      ],
                    ),

                    SizedBox(height: 32.h),

                    // Social Media Header
                    Text(
                      "تواصل معنا عبر وسائل التواصل الاجتماعي",
                      style: AppTextStyle.setelMessiriSecondlightGrey(
                        fontSize: 14,
                        fontWeight: FontWeight.normal,
                      ),
                    ),
                    SizedBox(height: 16.h),

                    // Social Media List
                    SocialMediaTile(
                      icon: FontAwesomeIcons.instagram,
                      title: "Instagram",
                      followers: "تابعنا على انستقرام",
                      posts: "",
                      onTap: () {
                        if (data.socialMedia?.instagram?.url != null) {
                          _launchUrl(data.socialMedia!.instagram!.url!);
                        }
                      },
                    ),
                    SizedBox(height: 12.h),

                    SocialMediaTile(
                      icon: FontAwesomeIcons.snapchat,
                      title: "Snapchat",
                      followers: "تابعنا على سناب شات",
                      posts: "",
                      onTap: () {
                        if (data.socialMedia?.snapchat?.url != null) {
                          _launchUrl(data.socialMedia!.snapchat!.url!);
                        }
                      },
                    ),
                    SizedBox(height: 12.h),
                    SocialMediaTile(
                      icon: FontAwesomeIcons.facebook,
                      title: "Facebook",
                      followers: "تابعنا على فيسبوك",
                      posts: "",
                      onTap: () {
                        if (data.socialMedia?.facebook?.url != null) {
                          _launchUrl(data.socialMedia!.facebook!.url!);
                        }
                      },
                    ),
                    SizedBox(height: 12.h),
                    SocialMediaTile(
                      icon: FontAwesomeIcons.whatsapp,
                      title: "WhatsApp",
                      followers: "متاح يومياً",
                      posts: "9-17",
                      onTap: () {
                        if (data.socialMedia?.whatsApp?.url != null) {
                          _launchUrl(data.socialMedia!.whatsApp!.url!);
                        }
                      },
                    ),
                    SizedBox(height: 40.h),
                  ],
                ),
              );
            }
            return const SizedBox();
          },
        ),
      ),
    );
  }

  Future<void> _launchUrl(String url) async {
    final Uri uri = Uri.parse(url);
    if (!await launchUrl(uri, mode: LaunchMode.externalApplication)) {
      debugPrint("Could not launch $url");
    }
  }
}
