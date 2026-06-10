import 'package:flutter/material.dart';
import 'package:flutter_application_1/core/theme/app_text_style.dart';
import 'package:flutter_application_1/featuer/tours/data/model/get_tour_id_model.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/theme/app_color.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'product_option_details/option_details_bottom_sheet.dart';

class TourPackageCard extends StatelessWidget {
  final ProductOption option;
  final String? tourDescription;

  const TourPackageCard({
    super.key,
    required this.option,
    this.tourDescription,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        showModalBottomSheet(
          context: context,
          isScrollControlled: true,
          backgroundColor: Colors.transparent,
          builder: (context) => OptionDetailsBottomSheet(
            option: option,
            tourDescription: tourDescription,
          ),
        );
      },
      child: Container(
        width: 336.w,
        padding: EdgeInsets.all(16.w),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16.r),
          boxShadow: const [
            BoxShadow(
              color: Color(0x1F000000),
              blurRadius: 7,
              offset: Offset(0, 2),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          mainAxisSize: MainAxisSize.min, // Wrap content vertically
          children: [
            // Header Icons
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SvgPicture.asset(
                  'assets/icon/information-diamond.svg',
                  width: 24.w,
                  height: 24.h,
                ),
                SvgPicture.asset(
                  'assets/icon/package_unselected.svg',
                  width: 32.w,
                  height: 32.h,
                  colorFilter: const ColorFilter.mode(
                    AppColor.primaryBlue3,
                    BlendMode.srcIn,
                  ),
                ),
              ],
            ),

            SizedBox(height: 12.h), // Replaced Spacer

            // Title
            Text(
              option.title ?? "رحلة ساحرة في شوارع فلورنسا الفنية والثقافية",
              textAlign: TextAlign.right,
              textDirection: TextDirection.rtl,
              style: TextStyle(
                fontSize: 18.sp,
                fontWeight: FontWeight.bold,
                color: const Color(0xFF1A1A1A),
                fontFamily: 'ElMessiri',
              ),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),

            SizedBox(height: 8.h),

            // Description
            Text(
              option.packageDescription?.isNotEmpty == true
                  ? option.packageDescription!.first
                  : "تجول في شوارع فلورنسا واستمتع بالفن والثقافة، من المتاحف إلى ميادين عصر النهضة، واختبر أجواء المدينة الساحرة.",
              textAlign: TextAlign.right,
              textDirection: TextDirection.rtl,
              style: TextStyle(
                fontSize: 13.sp,
                color: Colors.grey[600],
                height: 1.5,
                fontFamily: 'ElMessiri',
              ),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),

            SizedBox(height: 16.h), // Replaced Spacer

            // Price Pill & VAT
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // VAT Text (Left)
                Flexible(
                  child: Text(
                    "(شامل ضريبة القيمة المضافة)",
                    style: AppTextStyle.setelMessiriTextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w400,
                      color: AppColor.secondeLightGrey,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                
                SizedBox(width: 8.w),

                // Price Pill (Right)
                Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: 16.w,
                    vertical: 8.h,
                  ),
                  decoration: BoxDecoration(
                    color: const Color(0xFFE8EEF5),
                    borderRadius: BorderRadius.circular(25.r),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Flexible(
                        child: Text(
                          "${option.price?.toInt() ?? 2500}",
                          style: TextStyle(
                            fontSize: 20.sp,
                            fontWeight: FontWeight.bold,
                            color: AppColor.primaryBlue3,
                            fontFamily: 'ElMessiri',
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      SizedBox(width: 8.w),
                      SvgPicture.asset(
                        'assets/icon/RSA.svg',
                        width: 20.w,
                        height: 20.h,
                        colorFilter: const ColorFilter.mode(
                          AppColor.primaryBlue3,
                          BlendMode.srcIn,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
