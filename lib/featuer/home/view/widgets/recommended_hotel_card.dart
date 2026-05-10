import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/core/router/routes.dart';
import 'package:flutter_application_1/core/theme/app_color.dart';
import 'package:flutter_application_1/core/theme/app_text_style.dart';
import 'package:flutter_application_1/featuer/hotels/data/model/getHotel_model.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

class RecommendedHotelCard extends StatelessWidget {
  final HotelItem hotel;

  const RecommendedHotelCard({super.key, required this.hotel});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(
          context,
          Routes.hotelDetailsSlugView,
          arguments: hotel.slug,
        );
      },
      child: Container(
        width: 343.w,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16.r),
          border: Border.all(color: const Color(0xFFEAE9EB), width: 1),
        ),
        child: Row(
          children: [
            // 1. Image (Right Side in RTL)
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 6.w, vertical: 6.h),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10.r),
                child: Stack(
                  children: [
                    CachedNetworkImage(
                      imageUrl:
                          hotel.imageCover ??
                          "https://via.placeholder.com/125x137",
                      width: 125.w,
                      height: 137.h,
                      fit: BoxFit.cover,
                      placeholder: (context, url) =>
                          Container(color: Colors.grey[200]),
                      errorWidget: (context, url, error) =>
                          const Center(child: Icon(Icons.error)),
                    ),
                    // Badge "جناح فاخر"
                    Positioned(
                      top: 8.h,
                      right: 8.w,
                      child: Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: 8.w,
                          vertical: 4.h,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.black.withOpacity(0.3),
                          borderRadius: BorderRadius.circular(20.r),
                        ),
                        child: Text(
                          "جناح فاخر",
                          style: AppTextStyle.setelMessiriWhite(
                            fontSize: 10,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            // 2. Content (Left Side in RTL)
            Expanded(
              child: Padding(
                padding: EdgeInsets.only(
                  left: 12.w,
                  right: 6.w,
                  top: 12.h,
                  bottom: 12.h,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start, // Align to right (RTL start)
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      hotel.name ?? "اسم الفندق",
                      textAlign: TextAlign.right,
                      textDirection: TextDirection.rtl,
                      style: AppTextStyle.setelMessiriBlack(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    SizedBox(height: 8.h),
                    Text(
                      hotel.description ??
                          "استمتع بإقامة هادئة مع إطلالات لا تُنسى.",
                      textAlign: TextAlign.right,
                      textDirection: TextDirection.rtl,
                      style: AppTextStyle.setelMessiriSecondlightGrey(
                        fontSize: 12,
                        fontWeight: FontWeight.w400,
                      ).copyWith(color: const Color(0xFF667085)),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    SizedBox(height: 8.h),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Expanded(
                          child: Text(
                            "${hotel.city?.name ?? 'المدينة'}، ${hotel.country?.name ?? 'الدولة'}",
                            textAlign: TextAlign.right,
                            textDirection: TextDirection.rtl,
                            style: AppTextStyle.setelMessiriSecondlightGrey(
                              fontSize: 12,
                              fontWeight: FontWeight.w400,
                            ).copyWith(color: const Color(0xFF667085)),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        SizedBox(width: 4.w),
                        Icon(
                          Icons.location_on_outlined,
                          size: 14.sp,
                          color: const Color(0xFF667085),
                        ),
                      ],
                    ),
                    SizedBox(height: 8.h),
                    // Price Row
                    FittedBox(
                      fit: BoxFit.scaleDown,
                      alignment: AlignmentDirectional.centerStart,
                      child: Row(
                        children: [
                          Text(
                            "${hotel.price ?? 1500}",
                            style: AppTextStyle.setelMessiriBlack(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ).copyWith(color: AppColor.primaryBlue),
                          ),
                          SizedBox(width: 4.w),
                          SvgPicture.asset(
                            'assets/icon/RSA.svg',
                            height: 16.h,
                            colorFilter: const ColorFilter.mode(
                              AppColor.primaryBlue,
                              BlendMode.srcIn,
                            ),
                          ),
                          SizedBox(width: 4.w),
                          Text(
                            "/ليلة",
                            style: AppTextStyle.setelMessiriSecondlightGrey(
                              fontSize: 12,
                              fontWeight: FontWeight.w400,
                            ).copyWith(color: const Color(0xFF667085)),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
