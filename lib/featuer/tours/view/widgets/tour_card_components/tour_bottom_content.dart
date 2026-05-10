import 'package:flutter/material.dart';
import 'package:flutter_application_1/featuer/tours/data/model/get_all_tours_model.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../../../../../../core/theme/app_text_style.dart';

class TourBottomContent extends StatelessWidget {
  final TourItem tour;

  const TourBottomContent({super.key, required this.tour});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          tour.title ?? "رحلة سياحية مميزة",
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: AppTextStyle.setelMessiriTextStyle(
            fontSize: 16.sp,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        SizedBox(height: 4.h),
        Text(
          tour.descText ??
              tour.description ??
              "استكشاف الشواطئ البيضاء وممارسة الأنشطة البحرية في أجواء خلابة.",
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
          style: AppTextStyle.setelMessiriTextStyle(
            fontSize: 11.sp,
            fontWeight: FontWeight.normal,
            color: Colors.white.withOpacity(0.9),
          ).copyWith(height: 1.4),
        ),
        SizedBox(height: 12.h),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            // Left side (in RTL, this is the right edge visually) -> Days
            Row(
              children: [
                Icon(
                  FontAwesomeIcons.clock,
                  color: Colors.white,
                  size: 12.sp,
                ),
                SizedBox(width: 4.w),
                Text(
                  "${tour.header?.days ?? '4'} أيام",
                  style: AppTextStyle.setelMessiriTextStyle(
                    fontSize: 12.sp,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
            // Right side (in RTL, this is the left edge visually) -> Price Pill
            Container(
              padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 4.h),
              decoration: BoxDecoration(
                color: const Color(0xFF1D1B20).withOpacity(0.8),
                borderRadius: BorderRadius.circular(20.r),
                border: Border.all(color: Colors.white.withOpacity(0.3)),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    tour.originPrice ?? tour.price ?? "3000",
                    style: AppTextStyle.setelMessiriTextStyle(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(width: 4.w),
                  SvgPicture.asset(
                    'assets/icon/RSA.svg',
                    height: 14.h,
                    colorFilter: const ColorFilter.mode(
                      Colors.white,
                      BlendMode.srcIn,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }
}
