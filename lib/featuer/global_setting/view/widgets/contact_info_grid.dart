import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_application_1/core/widgets/info_border_card.dart';
import 'package:flutter_application_1/core/theme/app_color.dart';

/// A 2-column grid of 4 info cards with left-blue-border style.
class ContactInfoGrid extends StatelessWidget {
  const ContactInfoGrid({super.key});

  @override
  Widget build(BuildContext context) {
    final cards = [
      _CardData(
        icon: Icons.star_border_rounded,
        title: "مهمتنا",
        description:
            "تسهيل السفر لعملائنا بتوفير خيارات متنوعة وخدمات موثوقة تجعل كل رحلة أكثر راحة ومتعة.",
      ),
      _CardData(
        icon: Icons.mail_outline_rounded,
        title: "رسالتنا",
        description:
            "تقديم خدمات سفر متكاملة بأسعار مناسبة، وتجربة حجز بسيطة تصل عملائنا على التخطيط لرحلاتهم بسهولة.",
      ),
      _CardData(
        icon: Icons.visibility_outlined,
        title: "رؤيتنا",
        description:
            "أن نكون الخيار الأول للمسافرين الباحثين عن تجربة سهلة وموثوقة واكتشاف وجهات جديدة حول العالم.",
      ),
      _CardData(
        icon: Icons.flight_takeoff_rounded,
        title: "حجز سهل وسريع",
        description:
            "نوفر نظام حجز سهل يساعدك من البحث عن الرحلات وتوفير خيارات مرنة وضمان أفضل تجربة ممكنة.",
      ),
    ];

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w),
      child: GridView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          mainAxisSpacing: 12.h,
          crossAxisSpacing: 12.w,
          childAspectRatio: 168 / 116,
        ),
        itemCount: cards.length,
        itemBuilder: (context, index) {
          return InfoBorderCard(
            icon: Container(
              padding: EdgeInsets.all(6.w),
              decoration: BoxDecoration(
                color: AppColor.primaryBlue.withValues(alpha: 0.08),
                borderRadius: BorderRadius.circular(8.r),
              ),
              child: Icon(
                cards[index].icon,
                color: AppColor.primaryBlue,
                size: 20.sp,
              ),
            ),
            title: cards[index].title,
            description: cards[index].description,
          );
        },
      ),
    );
  }
}

class _CardData {
  final IconData icon;
  final String title;
  final String description;
  _CardData({
    required this.icon,
    required this.title,
    required this.description,
  });
}
