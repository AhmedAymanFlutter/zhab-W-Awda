import 'package:flutter/material.dart';
import 'package:flutter_application_1/core/theme/app_text_style.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'reward_details_bottom_sheet.dart';

class RewardPackageCard extends StatelessWidget {
  final String title;
  final String description;
  final int requiredPoints;

  const RewardPackageCard({
    super.key,
    required this.title,
    required this.description,
    required this.requiredPoints,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        showModalBottomSheet(
          context: context,
          isScrollControlled: true,
          backgroundColor: Colors.transparent,
          builder: (context) => RewardDetailsBottomSheet(
            title: title,
            description: description,
            requiredPoints: requiredPoints,
          ),
        );
      },
      child: Container(
        width: 336.w,
        constraints: BoxConstraints(minHeight: 136.h),
        margin: EdgeInsets.only(bottom: 16.h),
        padding: EdgeInsets.all(16.w),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16.r),
          boxShadow: const [
            BoxShadow(
              color: Color(0x1F000000), // #0000001F
              blurRadius: 7,
              offset: Offset(0, 2),
            ),
          ],
        ),
        child: Stack(
          children: [
            // Info Icon Top Left
            Positioned(
              left: 0,
              top: 0,
              child: Image.asset(
                'assets/photo/information.png',
                width: 30.w,
                height: 30.h,
              ),
            ),

            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              mainAxisSize: MainAxisSize.min,
              children: [
                // Top Row: Points Bubble
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: 10.w,
                        vertical: 4.h,
                      ),
                      decoration: BoxDecoration(
                        color: const Color(0xFFF2F4F7),
                        borderRadius: BorderRadius.circular(20.r),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Image.asset(
                            'assets/photo/Star.png',
                            width: 16.w,
                            height: 16.h,
                          ),
                          SizedBox(width: 4.w),
                          Text(
                            "$requiredPoints نقطة",
                            style: AppTextStyle.setelMessiriBlack(
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 8.h),
                // Middle Section: Logo and Value
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text(
                      "${requiredPoints - 100 > 0 ? requiredPoints - 100 : 400}",
                      style: AppTextStyle.setelMessiriBlack(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ).copyWith(color: const Color(0xFF002868)),
                    ),
                    SizedBox(width: 8.w),
                    Image.asset(
                      'assets/photo/mainLogo.webp',
                      width: 20.w,
                      height: 20.h,
                      color: const Color(0xFF002868),
                    ),
                  ],
                ),
                SizedBox(height: 8.h),
                // Bottom Section: Title and Description
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      title,
                      textAlign: TextAlign.right,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: AppTextStyle.setelMessiriBlack(
                        fontSize: 13,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      description,
                      textAlign: TextAlign.right,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: AppTextStyle.setelMessirisecondaryGery(
                        fontSize: 11,
                        fontWeight: FontWeight.normal,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
