import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/core/router/routes.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:skeletonizer/skeletonizer.dart';
import '../../../../../core/theme/app_color.dart';
import '../../../../../core/theme/app_text_style.dart';
import '../../package/data/model/get_all_packages_model.dart'; // Ensure correct path

class PackageCard extends StatelessWidget {
  final PackageItem package;

  const PackageCard({super.key, required this.package});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (package.sId != null) {
          Navigator.pushNamed(
            context,
            Routes.packageDetailsView,
            arguments: package.sId,
          );
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text("تفاصيل الباقة غير متوفرة حالياً")),
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
            // --- Image ---
            Expanded(
              flex: 3,
              child: Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.vertical(
                    top: Radius.circular(16.r),
                  ),
                  color: Colors.grey.shade200,
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.vertical(
                    top: Radius.circular(16.r),
                  ),
                  child: CachedNetworkImage(
                    imageUrl:
                        package.imageCover ?? "https://via.placeholder.com/200",
                    fit: BoxFit.cover,
                    placeholder: (context, url) =>
                        const Center(child: Icon(FontAwesomeIcons.image)),
                    errorWidget: (context, url, error) =>
                        const Icon(FontAwesomeIcons.image),
                  ),
                ),
              ),
            ),

            // --- Text Content ---
            Expanded(
              flex: 2,
              child: Padding(
                padding: EdgeInsets.all(8.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      package.name ?? "اسم الباقة",
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: AppTextStyle.setelMessiriBlack(
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const Spacer(),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          _getDurationText(),
                          style: AppTextStyle.setelMessiriSecondlightGrey(
                            fontSize: 10,
                            fontWeight: FontWeight.normal,
                          ),
                        ),
                        Text(
                          "${package.price} ج.م",
                          style: AppTextStyle.setelMessiriTextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
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

  String _getDurationText() {
    if (package.header != null) {
      return "${package.header!.dayNumber ?? 0} أيام";
    }
    return "لفترة محدودة";
  }
}
