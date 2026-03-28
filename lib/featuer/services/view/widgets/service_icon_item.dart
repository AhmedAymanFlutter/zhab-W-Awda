import 'package:flutter/material.dart';
import 'package:flutter_application_1/featuer/services/view/widgets/service_details_sheet.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../../../core/theme/app_text_style.dart';

class ServiceIconItem extends StatelessWidget {
  final String name;
  final String assetPath;
  final String? iconUrl;
  final String? id;
  final VoidCallback? onTap;

  const ServiceIconItem({
    super.key,
    required this.name,
    required this.assetPath,
    this.iconUrl,
    this.id,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        if (onTap != null) {
          onTap!();
        } else if (id != null) {
          showModalBottomSheet(
            context: context,
            isScrollControlled: true,
            backgroundColor: Colors.transparent,
            builder: (context) => ServiceDetailsSheet(serviceId: id!),
          );
        }
      },
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 56.w,
            height: 56.h,
            padding: EdgeInsets.all(8.w), // Slightly less padding for images
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12.r),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.05),
                  blurRadius: 10,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(8.r),
              child: _buildIcon(),
            ),
          ),
          SizedBox(height: 8.h),
          Text(
            name,
            textAlign: TextAlign.center,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: AppTextStyle.setelMessiriBlack(
              fontSize: 12,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildIcon() {
    if (iconUrl != null && iconUrl!.isNotEmpty) {
       // Check if it's a relative path and prepend baseUrl if needed
       String fullUrl = iconUrl!;
       if (!fullUrl.startsWith('http')) {
         // Fallback to local if it's just a placeholder or broken
         // For now, assume if it's not a URL, it might be an asset or needs base URL
         // But usually imageCover is a full URL or a path from server
         return Image.network(
          fullUrl,
          fit: BoxFit.cover,
          errorBuilder: (context, error, stackTrace) => SvgPicture.asset(
            assetPath,
            fit: BoxFit.contain,
          ),
        );
       }
       return Image.network(
        fullUrl,
        fit: BoxFit.cover,
        errorBuilder: (context, error, stackTrace) => SvgPicture.asset(
          assetPath,
          fit: BoxFit.contain,
        ),
      );
    }
    return SvgPicture.asset(
      assetPath,
      fit: BoxFit.contain,
    );
  }
}
