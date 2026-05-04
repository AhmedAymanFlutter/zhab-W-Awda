import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/theme/app_text_style.dart';

class HomeCitiesHeader extends StatelessWidget {
  const HomeCitiesHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          "أفضل الوجهات السياحية",
          style: AppTextStyle.setelMessiriBlack(fontSize: 24, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 12.h),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w),
          child: Text(
            "اكتشف أشهر الوجهات حول العالم، سواء كنت تبحث عن الاستجمام، المغامرة، أو التجارب الثقافية.",
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 14.sp, color: Colors.grey[600], height: 1.5),
          ),
        ),
      ],
    );
  }
}
