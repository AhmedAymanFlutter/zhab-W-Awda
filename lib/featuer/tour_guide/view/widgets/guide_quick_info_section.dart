import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_application_1/featuer/countries/data/model/get_CountriesSlug_model.dart';
import 'guide_info_card.dart';

class GuideQuickInfoSection extends StatelessWidget {
  final CountryDetailsData? country;

  const GuideQuickInfoSection({super.key, this.country});

  @override
  Widget build(BuildContext context) {
    if (country == null) return const SizedBox.shrink();

    return SizedBox(
      height: 182.h,
      child: ListView(
        scrollDirection: Axis.horizontal,
        physics: const BouncingScrollPhysics(),
        children: [
          GuideInfoCard(
            title: "مدة الرحلة",
            content: country?.tripDuration ?? "غير متوفر",
            icon: Icons.timer_outlined,
          ),
          SizedBox(width: 16.w),
          GuideInfoCard(
            title: "الوثائق المطلوبة",
            content: country?.requiredVisaDocuments ?? "جواز سفر ساري",
            icon: Icons.assignment_outlined,
          ),
          SizedBox(width: 16.w),
          GuideInfoCard(
            title: "أفضل أوقات الزيارة",
            content: country?.bestTimeToVisit ?? "طوال العام",
            icon: Icons.calendar_month_outlined,
          ),
        ],
      ),
    );
  }
}
