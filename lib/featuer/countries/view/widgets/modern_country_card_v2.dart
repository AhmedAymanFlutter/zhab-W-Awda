import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/featuer/countries/data/model/get_countries_model.dart';
import 'package:flutter_application_1/featuer/countries/view/country_details_view.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../../../../core/theme/app_text_style.dart';

class ModernCountryCardV2 extends StatelessWidget {
  final CountryItem country;

  const ModernCountryCardV2({super.key, required this.country});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        if (country.slug != null) {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => CountryDetailsView(countrySlug: country.slug!),
            ),
          );
        }
      },
      child: Container(
        width: 246.w,
        height: 327.h,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(24.r),
          border: Border.all(color: const Color(0xFFEAE9EB), width: 1),
          boxShadow: const [
            BoxShadow(
              color: Color(0x1F000000), // #0000001F
              offset: Offset(0, 4),
              blurRadius: 12,
              spreadRadius: 0,
            ),
          ],
        ),
        child: Column(
          children: [
            // 1. Image Section
            Padding(
              padding: EdgeInsets.all(12.w),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20.r),
                child: Stack(
                  children: [
                    CachedNetworkImage(
                      imageUrl: country.imageCover ?? "https://via.placeholder.com/246x180",
                      height: 180.h,
                      width: double.infinity,
                      fit: BoxFit.cover,
                      placeholder: (context, url) => Container(
                        height: 180.h,
                        color: Colors.grey[200],
                        child: const Center(child: Icon(FontAwesomeIcons.image, color: Colors.grey)),
                      ),
                      errorWidget: (context, url, error) => Container(
                        height: 180.h,
                        color: Colors.grey[200],
                        child: const Center(child: Icon(FontAwesomeIcons.circleExclamation, color: Colors.grey)),
                      ),
                    ),
                    // Trending Badge
                    if (country.isTrending == true || true) // Hardcoded true for now to match screenshot demo
                      Positioned(
                        top: 12.h,
                        right: 12.w,
                        child: Container(
                          padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 6.h),
                          decoration: BoxDecoration(
                            color: const Color(0xFF002868), // Dark Blue from screenshot
                            borderRadius: BorderRadius.circular(20.r),
                          ),
                          child: Text(
                            "رائجة حالياً",
                            style: AppTextStyle.setelMessiriTextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                  ],
                ),
              ),
            ),

            // 2. Content Section
            Expanded(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 4.h),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Action Button (Left side)
                    Container(
                      width: 40.w,
                      height: 40.h,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(color: const Color(0xFF002868), width: 1.5),
                      ),
                      child: Center(
                        child: Icon(
                          FontAwesomeIcons.arrowUpRightFromSquare,
                          color: const Color(0xFF002868),
                          size: 14.sp,
                        ),
                      ),
                    ),
                    SizedBox(width: 12.w),
                    // Title & Description (Right side)
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text(
                            country.name ?? "اسم الوجهة",
                            textAlign: TextAlign.right,
                            style: AppTextStyle.setelMessiriBlack(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ).copyWith(height: 1.2),
                          ),
                          SizedBox(height: 4.h),
                          Text(
                            country.descText ?? country.description ?? "استكشف جمال هذه الوجهة السياحية المميزة والمعالم الخلابة.",
                            maxLines: 3,
                            overflow: TextOverflow.ellipsis,
                            textAlign: TextAlign.right,
                            style: AppTextStyle.setelMessiriTextStyle(
                              fontSize: 11,
                              fontWeight: FontWeight.normal,
                              color: Colors.grey[600]!,
                            ).copyWith(height: 1.5),
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
