import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/core/router/routes.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../../../../../core/theme/app_color.dart';
import '../../../../../core/theme/app_text_style.dart';
import '../../package/data/model/get_all_packages_model.dart';

class PackageCard extends StatelessWidget {
  final PackageItem package;

  const PackageCard({super.key, required this.package});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (package.slug != null) {
          Navigator.pushNamed(
            context,
            Routes.packageDetailsView,
            arguments: {
              'packageSlug': package.slug,
              'packageTypeSlug': package.packageType?.slug ?? 'general',
              'packageId': package.sId,
            },
          );
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text("تفاصيل الباقة غير متوفرة حالياً")),
          );
        }
      },
      child: Container(
        width: 160.w, // Fixed width for horizontal list
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16.r),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // --- Image ---
            Expanded(
              flex: 4, // More space for image
              child: Stack(
                children: [
                  Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.vertical(
                        top: Radius.circular(16.r),
                      ),
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.vertical(
                        top: Radius.circular(16.r),
                      ),
                      child: CachedNetworkImage(
                        imageUrl:
                            package.imageCover ??
                            "https://via.placeholder.com/200",
                        fit: BoxFit.cover,
                        placeholder: (context, url) =>
                            const Center(child: Icon(FontAwesomeIcons.image)),
                        errorWidget: (context, url, error) =>
                            Center(child: const Icon(FontAwesomeIcons.image)),
                      ),
                    ),
                  ),
                  if (package.header?.dayNumber != null)
                    Positioned(
                      top: 8.h,
                      left: 8.w,
                      child: Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: 8.w,
                          vertical: 4.h,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.black.withOpacity(0.6),
                          borderRadius: BorderRadius.circular(20.r),
                        ),
                        child: Row(
                          children: [
                            Icon(
                              FontAwesomeIcons.clock,
                              color: Colors.white,
                              size: 10.sp,
                            ),
                            SizedBox(width: 4.w),
                            Text(
                              "${package.header?.dayNumber} أيام",
                              style: AppTextStyle.setelMessiriWhite(
                                fontSize: 10,
                                fontWeight: FontWeight.normal,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                ],
              ),
            ),

            // --- Text Content ---
            Expanded(
              flex: 3,
              child: Padding(
                padding: EdgeInsets.all(10.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      package.name ?? "اسم الباقة",
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: AppTextStyle.setelMessiriBlack(
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                      ).copyWith(height: 1.2),
                    ),
                    const Spacer(),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Flexible(
                          child: Text(
                            ' اكتشف المزيد',
                            style: AppTextStyle.setelMessiriTextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w400,
                              color: AppColor.primaryBlue,
                            ),
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.all(4.w),
                          decoration: BoxDecoration(
                            color: AppColor.primaryBlue.withOpacity(0.1),
                            shape: BoxShape.circle,
                          ),
                          child: Icon(
                            Icons.arrow_forward_rounded,
                            size: 14.sp,
                            color: AppColor.primaryBlue,
                          ),
                        ),
                      ],
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
