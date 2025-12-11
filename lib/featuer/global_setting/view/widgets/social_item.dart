import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../data/models/get_settings_model.dart';

class SocialItem extends StatelessWidget {
  final SocialPlatform platform;

  const SocialItem({super.key, required this.platform});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (platform.url != null) {
          debugPrint("Launching: ${platform.url}");
          // launchUrl(Uri.parse(platform.url!));
        }
      },
      child: Column(
        children: [
          Container(
            width: 55.w,
            height: 55.w,
            padding: EdgeInsets.all(8.w),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.08),
                  blurRadius: 10,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: ClipOval(
              child: CachedNetworkImage(
                imageUrl: platform.mobileImage ?? platform.deskTopImage ?? "",
                fit: BoxFit.cover,
                placeholder: (context, url) => const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: CircularProgressIndicator(strokeWidth: 2),
                ),
                errorWidget: (context, url, error) => const Icon(Icons.link),
              ),
            ),
          ),
          SizedBox(height: 8.h),
          Text(
            platform.name ?? "",
            style: TextStyle(
              fontSize: 11.sp,
              fontWeight: FontWeight.w500,
              color: Colors.grey[700],
            ),
          ),
        ],
      ),
    );
  }
}
