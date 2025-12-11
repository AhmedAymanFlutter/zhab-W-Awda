import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/core/router/routes.dart';
import 'package:flutter_application_1/featuer/services/data/model/get_services_model.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/theme/app_text_style.dart';

class ServiceCard extends StatelessWidget {
  final ServiceItem service;

  const ServiceCard({super.key, required this.service});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.pushNamed(
          context,
          Routes.serviceDetailsView,
          arguments: service.id,
        );
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
              flex: 3, // الصورة تأخذ مساحة أكبر
              child: ClipRRect(
                borderRadius: BorderRadius.vertical(top: Radius.circular(16.r)),
                child: CachedNetworkImage(
                  imageUrl:
                      service.imageCover ?? "https://via.placeholder.com/200",
                  fit: BoxFit.cover,
                  width: double.infinity,
                  placeholder: (context, url) =>
                      const Center(child: CircularProgressIndicator()),
                  errorWidget: (context, url, error) => const Icon(Icons.error),
                ),
              ),
            ),

            // Content
            Expanded(
              flex: 2, // مساحة النصوص
              child: Padding(
                // تقليل الـ Padding قليلاً لتوفير مساحة (8 بدلاً من 12)
                padding: EdgeInsets.all(8.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment:
                      MainAxisAlignment.center, // توسيط المحتوى عمودياً
                  children: [
                    Text(
                      service.name ?? "اسم الخدمة",
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: AppTextStyle.setelMessiriBlack(
                        fontSize: 13, // تصغير الخط درجة بسيطة إذا لزم الأمر
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 4.h), // تقليل المسافة
                    // ✅ الحل السحري: استخدام Flexible لمنع النص من الخروج عن الحدود
                    Flexible(
                      child: Text(
                        service.summary ??
                            service.description ??
                            "لا يوجد وصف متاح",
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: AppTextStyle.setelMessiriSecondlightGrey(
                          fontSize: 11,
                          fontWeight: FontWeight.normal,
                        ),
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
