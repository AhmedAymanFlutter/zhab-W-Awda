import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/theme/app_text_style.dart';

class FlightHeaderSection extends StatelessWidget {
  const FlightHeaderSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(height: 20.h),
        Text(
          "احجز رحلتك الجوية بسهولة",
          style: AppTextStyle.setelMessiriBlack(
            fontSize: 24,
            fontWeight: FontWeight.w900,
          ),
          textAlign: TextAlign.center,
        ),
        SizedBox(height: 12.h),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 24.w),
          child: Text(
            "استكشف أفضل عروض الطيران واحجز رحلتك إلى وجهتك المفضلة بكل سهولة. نقارن بين شركات الطيران لنقدم لك أفضل الأسعار وخيارات السفر المناسبة لرحلتك.",
            style: AppTextStyle.setelMessiriBlack(
              fontSize: 14,
              fontWeight: FontWeight.w500,
            ),
            textAlign: TextAlign.center,
          ),
        ),
        SizedBox(height: 30.h),
        Padding(
          padding: EdgeInsets.all(20.w),
          child: Image.asset(
            'assets/photo/flight_component.png',
            height: 160.h,
            width: double.infinity,
            fit: BoxFit.cover,
            alignment: Alignment.topCenter,
          ),
        ),
      ],
    );
  }
}
