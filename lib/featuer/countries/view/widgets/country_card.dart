import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/featuer/countries/data/model/get_countries_model.dart';
import 'package:flutter_application_1/featuer/countries/view/country_details_view.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/theme/app_color.dart';

class CountryCard extends StatelessWidget {
  final CountryItem country;

  const CountryCard({super.key, required this.country});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        if (country.slug != null) {
          // Using slug instead of ID
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) =>
                  CountryDetailsView(countrySlug: country.slug!),
            ),
          );
        }
      },
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16.r),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 5,
              spreadRadius: 1,
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Image
            Expanded(
              flex: 3,
              child: ClipRRect(
                borderRadius: BorderRadius.vertical(top: Radius.circular(16.r)),
                child: Stack(
                  fit: StackFit.expand,
                  children: [
                    CachedNetworkImage(
                      imageUrl:
                          country.imageCover ??
                          "https://via.placeholder.com/200",
                      fit: BoxFit.cover,
                      placeholder: (context, url) =>
                          const Center(child: CircularProgressIndicator()),
                      errorWidget: (context, url, error) =>
                          const Icon(Icons.error),
                    ),
                    // Gradient Overlay
                    Container(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [
                            Colors.transparent,
                            Colors.black.withOpacity(0.7),
                          ],
                        ),
                      ),
                    ),
                    // Country Name on Image
                    Positioned(
                      bottom: 10.h,
                      right: 10.w,
                      child: Text(
                        country.name ?? "اسم الدولة",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16.sp,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),

            // Details (Continent)
            Expanded(
              flex: 1,
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 6.h),
                child: Row(
                  children: [
                    Icon(
                      Icons.public,
                      color: AppColor.primaryBlue,
                      size: 14.sp,
                    ),
                    SizedBox(width: 4.w),
                    Text(
                      country.continent ?? "غير محدد",
                      style: TextStyle(
                        fontSize: 12.sp,
                        color: AppColor.secondaryGrey,
                        fontWeight: FontWeight.w500,
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
