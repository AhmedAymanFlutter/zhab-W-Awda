import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/core/router/routes.dart';
import 'package:flutter_application_1/featuer/packageType/data/model/get_package_type_model.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../../../../core/theme/app_text_style.dart';

class PackageTypeCard extends StatelessWidget {
  final PackageTypeItem packageType;

  const PackageTypeCard({super.key, required this.packageType});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.pushNamed(
          context,
          Routes.packageTypeDetailsView,
          arguments: {'slug': packageType.slug, 'title': packageType.name},
        );
      },
      child: Container(
        // ✅ يجب تحديد ارتفاع للكارت عند استخدامه داخل ListView مع Expanded
        height: 200.h,
        width: double.infinity,
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
                child: CachedNetworkImage(
                  imageUrl:
                      packageType.imageCover ??
                      "https://via.placeholder.com/200",
                  fit: BoxFit.cover,
                  width: double.infinity,
                  placeholder: (context, url) =>
                      const Center(child: Icon(FontAwesomeIcons.image)),
                  errorWidget: (context, url, error) =>
                      Icon(FontAwesomeIcons.image),
                ),
              ),
            ),

            // Content
            Expanded(
              flex: 1,
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 10.w),
                child: Center(
                  child: Text(
                    packageType.name ?? "نوع الباقة",
                    textAlign: TextAlign.center,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: AppTextStyle.setelMessiriBlack(
                      fontSize: 16, // كبرنا الخط شوية بما إن الكارت بقى عريض
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
