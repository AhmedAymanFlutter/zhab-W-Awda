import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/theme/app_color.dart';
import '../../../../core/theme/app_text_style.dart';

class SocialMediaTile extends StatelessWidget {
  final IconData icon;
  final String title;
  final String followers;
  final String posts;
  final VoidCallback onTap;

  const SocialMediaTile({
    super.key,
    required this.icon,
    required this.title,
    required this.followers,
    required this.posts,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
        decoration: BoxDecoration(
          color: AppColor.primaryRed,
          borderRadius: BorderRadius.circular(20.r),
          border: Border.all(color: AppColor.primaryBlue.withOpacity(0.1)),
        ),
        child: Row(
          children: [
            Container(
              padding: EdgeInsets.all(10.w),
              decoration: BoxDecoration(
                color: Colors.black,
                borderRadius: BorderRadius.circular(12.r),
              ),
              child: Icon(icon, color: Colors.white, size: 20.sp),
            ),
            SizedBox(width: 16.w),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: AppTextStyle.setelMessiriBlack(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 2.h),
                  Row(
                    children: [
                      Text(
                        followers,
                        style: AppTextStyle.setelMessiriSecondlightGrey(
                          fontSize: 12,
                          fontWeight: FontWeight.normal,
                        ),
                      ),
                      if (posts.isNotEmpty) ...[
                        Text(
                          " • ",
                          style: AppTextStyle.setelMessiriSecondlightGrey(
                            fontSize: 12,
                            fontWeight: FontWeight.normal,
                          ),
                        ),
                        Text(
                          posts,
                          style: AppTextStyle.setelMessiriSecondlightGrey(
                            fontSize: 12,
                            fontWeight: FontWeight.normal,
                          ),
                        ),
                      ],
                    ],
                  ),
                ],
              ),
            ),
            Container(
              padding: EdgeInsets.all(8.w),
              decoration: BoxDecoration(
                color: Colors.transparent,
                shape: BoxShape.circle,
                border: Border.all(color: Colors.grey.withOpacity(0.3)),
              ),
              child: const Icon(
                Icons.arrow_forward_ios,
                size: 14,
                color: AppColor.secondaryBlack,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
