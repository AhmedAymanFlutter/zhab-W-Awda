import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import '../../../../../../core/theme/app_text_style.dart';

class PackageOverviewSection extends StatelessWidget {
  final String? title;
  final String? description;

  const PackageOverviewSection({
    super.key,
    this.title = "نظرة عامة عن الباقة",
    required this.description,
  });

  @override
  Widget build(BuildContext context) {
    if (description == null || description!.isEmpty) return const SizedBox.shrink();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title!,
          style: AppTextStyle.setelMessiriBlack(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(height: 12.h),
        HtmlWidget(
          description!,
          textStyle: TextStyle(
            fontSize: 14.sp,
            color: Colors.grey[800],
            height: 1.8,
          ),
        ),
      ],
    );
  }
}
