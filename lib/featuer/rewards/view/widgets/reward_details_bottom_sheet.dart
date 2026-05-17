import 'package:flutter/material.dart';
import 'package:flutter_application_1/core/theme/app_text_style.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:url_launcher/url_launcher.dart';

class RewardDetailsBottomSheet extends StatelessWidget {
  final String title;
  final String description;
  final int requiredPoints;

  const RewardDetailsBottomSheet({
    super.key,
    required this.title,
    required this.description,
    required this.requiredPoints,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 24.h),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(24.r)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Text(
            "حول الباقة",
            style: AppTextStyle.setelMessiriBlack(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 12.h),
          Text(
            description,
            textAlign: TextAlign.right,
            style: AppTextStyle.setelMessirisecondaryGery(
              fontSize: 14,
              fontWeight: FontWeight.normal,
            ).copyWith(height: 1.6),
          ),
          SizedBox(height: 24.h),
          Text(
            "تفاصيل",
            style: AppTextStyle.setelMessiriBlack(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 12.h),
          _buildDetailItem(
            "التجول بين المعارض الفنية والمتاحف الشهيرة في المدينة.",
          ),
          _buildDetailItem(
            "وقت حر لالتقاط الصور واستكشاف أجواء المدينة الساحرة.",
          ),
          SizedBox(height: 32.h),
          SizedBox(
            width: double.infinity,
            height: 54.h,
            child: ElevatedButton(
              onPressed: () => _launchWhatsApp(context),
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF002868),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(27.r),
                ),
              ),
              child: Text(
                "استخدام الباقة",
                style: AppTextStyle.setelMessiriWhite(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _launchWhatsApp(BuildContext context) async {
    final String phoneNumber = "201017006883";
    final String message =
        "مرحباً، أريد استخدام باقة: $title\nالنقاط المطلوبة: $requiredPoints نقطة";
    final String url =
        "https://wa.me/$phoneNumber?text=${Uri.encodeComponent(message)}";

    final Uri uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    } else {
      // ignore: use_build_context_synchronously
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text("لا يمكن فتح واتساب")));
    }
  }

  Widget _buildDetailItem(String text) {
    return Padding(
      padding: EdgeInsets.only(bottom: 12.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Expanded(
            child: Text(
              text,
              textAlign: TextAlign.right,
              style: AppTextStyle.setelMessirisecondaryGery(
                fontSize: 14,
                fontWeight: FontWeight.normal,
              ),
            ),
          ),
          SizedBox(width: 8.w),
          Icon(Icons.check_circle_outline, color: Colors.green, size: 20.sp),
        ],
      ),
    );
  }
}
