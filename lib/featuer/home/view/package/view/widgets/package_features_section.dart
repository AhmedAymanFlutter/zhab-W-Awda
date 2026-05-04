import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package_feature_item.dart';
import 'package_section_header.dart';

class PackageFeaturesSection extends StatelessWidget {
  final String title;
  final List<String>? features;
  final bool isIncluded;

  const PackageFeaturesSection({
    super.key,
    required this.title,
    this.features,
    required this.isIncluded,
  });

  @override
  Widget build(BuildContext context) {
    if (features == null || features!.isEmpty) return const SizedBox.shrink();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        PackageSectionHeader(title: title),
        ...features!.map(
          (item) => PackageFeatureItem(text: item, isIncluded: isIncluded),
        ),
        SizedBox(height: 24.h),
      ],
    );
  }
}
