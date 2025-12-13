import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'package:url_launcher/url_launcher.dart'; // Import this
import '../../data/models/get_settings_model.dart';

class SocialItem extends StatelessWidget {
  final SocialPlatform platform;

  const SocialItem({super.key, required this.platform});

  // --- Helper Function ---
  Future<void> _launchURL(BuildContext context, String? urlString) async {
    if (urlString == null || urlString.isEmpty) return;

    final Uri uri = Uri.parse(urlString);
    try {
      if (!await launchUrl(uri, mode: LaunchMode.externalApplication)) {
        // Fallback or Error handling
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(const SnackBar(content: Text("Could not launch link")));
      }
    } catch (e) {
      debugPrint("Error launching URL: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => _launchURL(context, platform.url), // Call the function here
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
                placeholder: (context, url) =>
                    Skeletonizer(child: Icon(FontAwesomeIcons.facebook)),
                errorWidget: (context, url, error) =>
                    const Icon(FontAwesomeIcons.circleExclamation),
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
