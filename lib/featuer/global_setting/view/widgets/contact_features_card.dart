import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_application_1/core/theme/app_text_style.dart';

/// The large feature card (343x427) shown below the hero section.
/// Displays why the user should choose the service, with company logos.
class ContactFeaturesCard extends StatelessWidget {
  const ContactFeaturesCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 343.w,
      margin: EdgeInsets.symmetric(horizontal: 16.w),
      padding: EdgeInsets.all(20.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.08),
            blurRadius: 4,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Text(
            "لماذا يبقى بقي عملاؤنا",
            style: AppTextStyle.setelMessiriBlack(
              fontSize: 20,
              fontWeight: FontWeight.w900,
            ),
          ),
          SizedBox(height: 8.h),
          Text(
            "نحرص على تقديم خدمة سهلة وموثوقة لعملائنا من خلال خدمات احترافية، عروض مميزة في كل خطوة وندعم مسيرتهم في التخطيط لرحلتهم لرحلتهم لتجعل عملائنا على كل راحة تجعل رحلتك لتجعل الأمثل لرحلتك سلسة.",
            textAlign: TextAlign.right,
            style: AppTextStyle.setelMessiriSecondlightGrey(
              fontSize: 12,
              fontWeight: FontWeight.w400,
            ).copyWith(height: 1.6),
          ),
          SizedBox(height: 20.h),

          Divider(color: Colors.grey.shade200),
          SizedBox(height: 16.h),
          // Feature rows
          _buildFeatureRow(
            icon: Image.asset(
              'assets/photo/Container.png',
              width: 60.w,
              height: 60.h,
            ),
            title: "أفضل الأسعار والعروض",
            description:
                "نعثر على أفضل الأسعار والعروض من شركات الطيران والفنادق والتوافق مع متطلبات السفر.",
          ),
          SizedBox(height: 16.h),
          _buildFeatureRow(
            icon: Image.asset(
              'assets/photo/Container (1).png',
              width: 60.w,
              height: 60.h,
            ),
            title: "دعم متواصل",
            description:
                "فريق دعم جاهز لمساعدتك في أي وقت وبكل مواكبتك خلال رحلتك في جميع أقسام الرحلة.",
          ),
          SizedBox(height: 16.h),
          _buildFeatureRow(
            icon: Image.asset(
              'assets/photo/Container (2).png',
              width: 60.w,
              height: 60.h,
            ),
            title: "شركاء موثوقون",
            description:
                "نتعاون مع شركات طيران وفنادق ذات سمعة عالية الجودة لضمان تجربة سفر آمنة وموثوقة.",
          ),
        ],
      ),
    );
  }

  Widget _buildFeatureRow({
    required Widget icon,
    required String title,
    required String description,
  }) {
    return Row(
      textDirection: TextDirection.rtl,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        icon,
        SizedBox(width: 12.w),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                title,
                style: AppTextStyle.setelMessiriBlack(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 4.h),
              Text(
                description,
                textDirection: TextDirection.rtl,
                style: AppTextStyle.setelMessiriSecondlightGrey(
                  fontSize: 11,
                  fontWeight: FontWeight.w400,
                ).copyWith(height: 1.5),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
