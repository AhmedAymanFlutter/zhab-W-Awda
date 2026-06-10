import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/theme/app_color.dart';
import '../../../../core/theme/app_text_style.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../global_setting/manager/settings_cubit.dart';
import '../../../global_setting/manager/settings_state.dart';

class ContactBanner extends StatelessWidget {
  const ContactBanner({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(24.w),
      decoration: BoxDecoration(
        color: AppColor.primaryBlue3, // Dark blue from the theme
        borderRadius: BorderRadius.circular(20.r),
      ),
      child: Column(
        children: [
          Text(
            "تواصل معنا بسهولة",
            style: AppTextStyle.setelMessiriWhite(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 8.h),
          Text(
            "نحن هنا لمساعدتك في أي استفسار عن رحلاتك أو حجوزاتك، تواصل معنا وسيسعد فريقنا بالرد عليك في أسرع وقت.",
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 12.sp,
              color: Colors.white70,
              fontFamily: 'Tajawal',
            ),
          ),
          SizedBox(height: 20.h),
          BlocBuilder<SettingsCubit, SettingsState>(
            builder: (context, state) {
              return ElevatedButton(
                onPressed: () async {
                  if (state is SettingsSuccess) {
                    final phones = state.settings.contactInfo?.phones ?? [];
                    final whatsAppPhoneList = phones.where((p) => p.isWhatsApp == true).toList();
                    final selectedPhone = whatsAppPhoneList.isNotEmpty 
                        ? whatsAppPhoneList.first 
                        : (phones.isNotEmpty ? phones.first : null);
                    
                    String? phoneNumber;
                    if (selectedPhone != null && selectedPhone.number != null) {
                      phoneNumber = selectedPhone.countryCode != null 
                        ? '${selectedPhone.countryCode}${selectedPhone.number}' 
                        : selectedPhone.number;
                    }

                    if (phoneNumber != null) {
                      String cleanedNumber = phoneNumber.replaceAll(RegExp(r'[^\d]'), '');
                      final Uri url = Uri.parse('https://wa.me/$cleanedNumber');
                      if (await canLaunchUrl(url)) {
                        await launchUrl(url, mode: LaunchMode.externalApplication);
                      }
                    }
                  }
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.white,
                  foregroundColor: AppColor.primaryBlue3,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30.r),
                  ),
                  padding: EdgeInsets.symmetric(horizontal: 32.w, vertical: 12.h),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Icon(Icons.headset_mic_outlined, size: 20),
                    SizedBox(width: 8.w),
                    Text(
                      "تواصل معنا",
                      style: AppTextStyle.setelMessiriTextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: AppColor.primaryBlue3,
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
