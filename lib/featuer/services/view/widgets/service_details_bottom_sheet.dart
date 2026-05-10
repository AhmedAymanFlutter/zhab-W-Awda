import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../../core/theme/app_text_style.dart';

void showServiceDetailsBottomSheet(BuildContext context, {required String title, required String description}) {
  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    backgroundColor: Colors.white,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(24.r)),
    ),
    builder: (context) {
      return Padding(
        padding: EdgeInsets.only(
          left: 24.w,
          right: 24.w,
          bottom: MediaQuery.of(context).viewInsets.bottom + 24.h,
          top: 12.h,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Drag handle
            Container(
              width: 40.w,
              height: 4.h,
              decoration: BoxDecoration(
                color: const Color(0xFFE0E0E0),
                borderRadius: BorderRadius.circular(2.r),
              ),
            ),
            SizedBox(height: 16.h),
            // Header Row
            Row(
              children: [
                SizedBox(width: 24.w), // Balance for centering
                Expanded(
                  child: Text(
                    title,
                    textAlign: TextAlign.center,
                    style: AppTextStyle.setelMessiriBlack(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () => Navigator.pop(context),
                  child: Icon(Icons.close, size: 24.sp, color: Colors.black54),
                ), // Placed left in RTL
              ],
            ),
            SizedBox(height: 16.h),
            const Divider(color: Color(0xFFEAE9EB), thickness: 1),
            SizedBox(height: 24.h),
            // Description
            Text(
              description,
              textAlign: TextAlign.center,
              style: AppTextStyle.setelMessiriBlack(
                fontSize: 14,
                fontWeight: FontWeight.w500,
              ).copyWith(color: const Color(0xFF333333), height: 1.6),
            ),
            SizedBox(height: 32.h),
            // WhatsApp Button
            GestureDetector(
              onTap: () async {
                final Uri url = Uri.parse("https://wa.me/?text=مرحباً، أريد الاستفسار عن خدمة: $title");
                if (await canLaunchUrl(url)) {
                  await launchUrl(url, mode: LaunchMode.externalApplication);
                }
              },
              child: Container(
                width: double.infinity,
                height: 50.h,
                decoration: BoxDecoration(
                  color: const Color(0xFF4CAF50), // WhatsApp green
                  borderRadius: BorderRadius.circular(12.r),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(FontAwesomeIcons.whatsapp, color: Colors.white),
                    SizedBox(width: 8.w),
                    Text(
                      "تواصل معنا واتساب",
                      style: AppTextStyle.setelMessiriWhite(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 12.h),
            // Cancel Button
            GestureDetector(
              onTap: () => Navigator.pop(context),
              child: Container(
                width: double.infinity,
                height: 50.h,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12.r),
                  border: Border.all(color: const Color(0xFFEAE9EB)),
                ),
                child: Center(
                  child: Text(
                    "إلغاء",
                    style: AppTextStyle.setelMessiriBlack(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      );
    },
  );
}
