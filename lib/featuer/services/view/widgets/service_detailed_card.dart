import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../../../../core/theme/app_text_style.dart';
import '../../../../core/theme/app_color.dart';

class ServiceDetailedCard extends StatelessWidget {
  final String title;
  final String description;
  final String? iconUrl;
  final VoidCallback onDetailsTap;
  final VoidCallback onBookTap;

  const ServiceDetailedCard({
    super.key,
    required this.title,
    required this.description,
    this.iconUrl,
    required this.onDetailsTap,
    required this.onBookTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 343.w,
      padding: EdgeInsets.all(12.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8.r),
        border: Border.all(color: const Color(0xFFEAE9EB), width: 1),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Top Part
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment:
                      CrossAxisAlignment.start, // Right aligned in RTL
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      "الخدمة",
                      style: AppTextStyle.setelMessiriSecondlightGrey(
                        fontSize: 10,
                        fontWeight: FontWeight.w400,
                      ).copyWith(color: const Color(0xFF667085)),
                    ),
                    SizedBox(height: 4.h),
                    Text(
                      title,
                      style: AppTextStyle.setelMessiriBlack(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    SizedBox(height: 4.h),
                    Text(
                      description,
                      style: AppTextStyle.setelMessiriSecondlightGrey(
                        fontSize: 10,
                        fontWeight: FontWeight.w400,
                      ).copyWith(color: const Color(0xFF667085)),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
              SizedBox(width: 12.w),
              // Icon (Left in RTL)
              Container(
                width: 48.w,
                height: 48.w,
                decoration: const BoxDecoration(
                  color: Color(0xFFF0F5FA), // Light blue circle
                  shape: BoxShape.circle,
                ),
                child: Center(
                  child: iconUrl != null && iconUrl!.isNotEmpty
                      ? Image.network(
                          iconUrl!,
                          width: 24.w,
                          height: 24.w,
                          errorBuilder: (_, __, ___) => Icon(
                            Icons.miscellaneous_services,
                            color: AppColor.primaryBlue,
                            size: 24.sp,
                          ),
                        )
                      : Icon(
                          Icons.car_rental,
                          color: AppColor.primaryBlue,
                          size: 24.sp,
                        ),
                ),
              ),
            ],
          ),
          SizedBox(height: 16.h), // Gap adjustment
          // Bottom Part: Buttons
          Row(
            children: [
              // Details Button (Right in RTL)
              Expanded(
                child: GestureDetector(
                  onTap: onDetailsTap,
                  child: Container(
                    height: 40.h,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(8.r),
                      border: Border.all(color: const Color(0xFFEAE9EB)),
                    ),
                    child: Center(
                      child: Text(
                        "تفاصيل",
                        style: AppTextStyle.setelMessiriBlack(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                        ).copyWith(color: AppColor.primaryBlue),
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(width: 12.w),
              // Book Now Button (Left in RTL)
              Expanded(
                child: GestureDetector(
                  onTap: onBookTap,
                  child: Container(
                    height: 40.h,
                    decoration: BoxDecoration(
                      color: AppColor.primaryBlue,
                      borderRadius: BorderRadius.circular(8.r),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        FaIcon(
                          FontAwesomeIcons.whatsapp,
                          color: Colors.white,
                          size: 24,
                        ),
                        SizedBox(width: 8.w),
                        Text(
                          "احجز الآن",
                          style: AppTextStyle.setelMessiriWhite(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
