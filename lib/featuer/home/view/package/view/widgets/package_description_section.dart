import 'package:flutter/material.dart';
import 'package:flutter_application_1/featuer/home/view/package/data/model/get_package_id_model.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import '../../../../../../core/theme/app_text_style.dart';
import 'package_section_header.dart';

class PackageDescriptionSection extends StatelessWidget {
  final Pkg pkg;

  const PackageDescriptionSection({super.key, required this.pkg});

  @override
  Widget build(BuildContext context) {
    final String content = pkg.description ?? pkg.descText ?? "";
    if (content.isEmpty) return const SizedBox.shrink();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const PackageSectionHeader(title: "عن الباقة"),
        HtmlWidget(
          content,
          textStyle: AppTextStyle.setelMessiriSecondlightGrey(
            fontSize: 14.sp,
            fontWeight: FontWeight.normal,
          ).copyWith(height: 1.6),
        ),
        SizedBox(height: 24.h),
      ],
    );
  }
}
