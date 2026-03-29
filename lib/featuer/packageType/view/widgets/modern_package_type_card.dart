import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/core/router/routes.dart';
import 'package:flutter_application_1/featuer/packageType/data/model/get_package_type_model.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/theme/app_text_style.dart';

/// Modern package type card with two layout variants:
/// - [PackageTypeCardVariant.tall]  → 284×343, used in the packages list view
/// - [PackageTypeCardVariant.wide]  → 338×213, used in horizontal scrolling sections
enum PackageTypeCardVariant { tall, wide }

class ModernPackageTypeCard extends StatelessWidget {
  final PackageTypeItem packageType;
  final PackageTypeCardVariant variant;
  final String? badge; // e.g. "الأفضل مبيعاً"

  const ModernPackageTypeCard({
    super.key,
    required this.packageType,
    this.variant = PackageTypeCardVariant.wide,
    this.badge,
  });

  @override
  Widget build(BuildContext context) {
    final isTall = variant == PackageTypeCardVariant.tall;
    final double cardHeight = isTall ? 343.h : 213.h;
    final double cardWidth = isTall ? 284.w : 338.w;
    final double borderRadius = isTall ? 24.r : 20.r;

    return GestureDetector(
      onTap: () => Navigator.pushNamed(
        context,
        Routes.packageTypeDetailsView,
        arguments: {'slug': packageType.slug, 'title': packageType.name},
      ),
      child: Container(
        height: cardHeight,
        width: cardWidth,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(borderRadius),
          color: const Color(0xFFEAE9EB),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.25),
              blurRadius: 8,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(borderRadius),
          child: Stack(
            fit: StackFit.expand,
            children: [
              // --- 1. Background Image ---
              CachedNetworkImage(
                imageUrl:
                    packageType.imageCover ?? "https://via.placeholder.com/400",
                fit: BoxFit.cover,
                placeholder: (context, url) =>
                    Container(color: Colors.grey[200]),
                errorWidget: (context, url, error) => Container(
                  color: Colors.grey[200],
                  child: const Icon(Icons.broken_image, color: Colors.grey),
                ),
              ),

              // --- 2. Gradient Overlay (stronger for tall, subtle for wide) ---
              Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Colors.transparent,
                      Colors.black.withValues(alpha: 0.15),
                      Colors.black.withValues(alpha: isTall ? 0.80 : 0.72),
                    ],
                    stops: const [0.4, 0.65, 1.0],
                  ),
                ),
              ),

              // --- 3. Back/Nav button (top-left) ---
              if (isTall)
                Positioned(
                  top: 14.h,
                  left: 14.w,
                  child: Container(
                    padding: EdgeInsets.all(8.w),
                    decoration: BoxDecoration(
                      color: Colors.white.withValues(alpha: 0.25),
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      Icons.arrow_back_ios_new_rounded,
                      color: Colors.white,
                      size: 16.sp,
                    ),
                  ),
                ),

              // --- 4. Badge (optional, top-right for wide card) ---
              if (badge != null && !isTall)
                Positioned(
                  top: 12.h,
                  right: 12.w,
                  child: Container(
                    padding:
                        EdgeInsets.symmetric(horizontal: 10.w, vertical: 5.h),
                    decoration: BoxDecoration(
                      color: Colors.white.withValues(alpha: 0.9),
                      borderRadius: BorderRadius.circular(20.r),
                    ),
                    child: Text(
                      badge!,
                      style: AppTextStyle.setelMessiriBlack(
                        fontSize: 11,
                        fontWeight: FontWeight.bold,
                      ).copyWith(color: const Color(0xFF1A2A4A)),
                    ),
                  ),
                ),

              // --- 5. Title + description at bottom ---
              Positioned(
                bottom: 0,
                left: 0,
                right: 0,
                child: Padding(
                  padding: EdgeInsets.all(16.w),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        packageType.name ?? "نوع الباقة",
                        textDirection: TextDirection.rtl,
                        style: AppTextStyle.setelMessiriWhite(
                          fontSize: isTall ? 20 : 18,
                          fontWeight: FontWeight.bold,
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                      if (packageType.descText != null &&
                          packageType.descText!.isNotEmpty)
                        Padding(
                          padding: EdgeInsets.only(top: 4.h),
                          child: Text(
                            packageType.descText!,
                            textDirection: TextDirection.rtl,
                            style: AppTextStyle.setelMessiriWhite(
                              fontSize: 11,
                              fontWeight: FontWeight.w400,
                            ).copyWith(
                              color: Colors.white70,
                              height: 1.5,
                            ),
                            maxLines: isTall ? 3 : 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
