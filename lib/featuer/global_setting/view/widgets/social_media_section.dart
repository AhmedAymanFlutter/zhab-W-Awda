import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../data/models/get_settings_model.dart';
import 'social_item.dart';

class SocialMediaSection extends StatelessWidget {
  final SocialMedia socialMedia;

  const SocialMediaSection({super.key, required this.socialMedia});

  @override
  Widget build(BuildContext context) {
    final activePlatforms = socialMedia.getActivePlatforms();

    if (activePlatforms.isEmpty) return const SizedBox();

    return Column(
      children: [
        Divider(color: Colors.grey.shade200, thickness: 1.5),
        SizedBox(height: 24.h),
        Text(
          "تابعنا على المنصات",
          style: TextStyle(
            fontSize: 16.sp,
            fontWeight: FontWeight.bold,
            color: Colors.black87,
          ),
        ),
        SizedBox(height: 20.h),
        Wrap(
          spacing: 24.w,
          runSpacing: 24.h,
          alignment: WrapAlignment.center,
          children: activePlatforms
              .map((platform) => SocialItem(platform: platform))
              .toList(),
        ),
        SizedBox(height: 20.h),
      ],
    );
  }
}
