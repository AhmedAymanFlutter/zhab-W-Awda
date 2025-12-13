import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/theme/app_color.dart';
import '../data/repo/settings_repository.dart';
import '../manager/settings_cubit.dart';
import '../manager/settings_state.dart';
import 'widgets/contact_info_section.dart';
import 'widgets/social_media_section.dart';

class ContactUsView extends StatelessWidget {
  const ContactUsView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SettingsCubit(SettingsRepository())..fetchSettings(),
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          centerTitle: true,
          title: Text(
            "تواصل معنا",
            style: TextStyle(
              fontSize: 20.sp,
              fontWeight: FontWeight.bold,
              color: AppColor.primaryBlue,
            ),
          ),
          leading: const BackButton(color: AppColor.primaryBlue),
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
                padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // --- Contact Info ---
                    if (data.contactInfo != null)
                      ContactInfoSection(contactInfo: data.contactInfo!),

                    SizedBox(height: 20.h),

                    // --- Social Media ---
                    if (data.socialMedia != null)
                      SocialMediaSection(socialMedia: data.socialMedia!),

                    SizedBox(height: 30.h),
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
}
