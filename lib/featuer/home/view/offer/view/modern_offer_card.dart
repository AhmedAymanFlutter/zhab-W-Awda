import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/core/router/routes.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../../../../../core/theme/app_color.dart';
import '../../../../../core/theme/app_text_style.dart';
import '../data/model/get_all_offers_model.dart';

class ModernOfferCard extends StatelessWidget {
  final OfferItem offer;

  const ModernOfferCard({super.key, required this.offer});

  @override
  Widget build(BuildContext context) {
    // Calculate discount if possible
    String? discountPercentage;
    if (offer.price != null && offer.oldPrice != null) {
      try {
        double price = double.parse(offer.price!);
        double oldPrice = double.parse(offer.oldPrice!);
        if (oldPrice > price) {
          int discount = ((oldPrice - price) / oldPrice * 100).round();
          discountPercentage = "$discount%";
        }
      } catch (e) {
        // Ignore parsing errors
      }
    }

    return InkWell(
      onTap: () {
        Navigator.pushNamed(
          context,
          Routes.offerDetailsView,
          arguments: offer.sId,
        );
      },
      child: Container(
        width: double.infinity,
        margin: EdgeInsets.symmetric(
          horizontal: 5.w,
        ), // Small margin for slider
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20.r),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 10,
              offset: const Offset(0, 5),
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(20.r),
          child: Stack(
            fit: StackFit.expand,
            children: [
              // 1. Background Image
              CachedNetworkImage(
                imageUrl:
                    offer.imageCover ?? "https://via.placeholder.com/400x200",
                fit: BoxFit.cover,
                placeholder: (context, url) => Container(
                  color: Colors.grey[200],
                  child: const Center(
                    child: Icon(FontAwesomeIcons.image, color: Colors.grey),
                  ),
                ),
                errorWidget: (context, url, error) => Container(
                  color: Colors.grey[200],
                  child: const Center(
                    child: Icon(
                      FontAwesomeIcons.circleExclamation,
                      color: Colors.grey,
                    ),
                  ),
                ),
              ),

              // 2. Gradient Overlay
              Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Colors.transparent,
                      Colors.black.withOpacity(0.1),
                      Colors.black.withOpacity(0.8),
                    ],
                    stops: const [0.5, 0.7, 1.0],
                  ),
                ),
              ),

              // 3. Discount Badge (Top Right/Left)
              if (discountPercentage != null)
                Positioned(
                  top: 12.h,
                  right: Directionality.of(context) == TextDirection.rtl
                      ? null
                      : 12.w,
                  left: Directionality.of(context) == TextDirection.rtl
                      ? 12.w
                      : null,
                  child: Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: 10.w,
                      vertical: 6.h,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.redAccent,
                      borderRadius: BorderRadius.circular(20.r),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.redAccent.withOpacity(0.4),
                          blurRadius: 8,
                          offset: const Offset(0, 2),
                        ),
                      ],
                    ),
                    child: Text(
                      "$discountPercentage خصم",
                      style: AppTextStyle.setelMessiriWhite(
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),

              // 4. Content (Bottom)
              Padding(
                padding: EdgeInsets.all(16.w),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      offer.name ?? "عرض خاص",
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: AppTextStyle.setelMessiriWhite(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 6.h),
                    Row(
                      children: [
                        if (offer.price != null)
                          Text(
                            "${offer.price} ج.م",
                            style: AppTextStyle.setelMessiriTextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: AppColor.primaryBlue, // Highlight price
                            ),
                          ),
                        SizedBox(width: 8.w),
                        if (offer.oldPrice != null)
                          Text(
                            "${offer.oldPrice} ج.م",
                            style: TextStyle(
                              fontSize: 12.sp,
                              color: Colors.white70,
                              decoration: TextDecoration.lineThrough,
                              decorationColor: Colors.white70,
                            ),
                          ),
                        const Spacer(),
                        Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: 12.w,
                            vertical: 6.h,
                          ),
                          decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.2),
                            borderRadius: BorderRadius.circular(20.r),
                          ),
                          child: Row(
                            children: [
                              Text(
                                "احجز الآن",
                                style: AppTextStyle.setelMessiriWhite(
                                  fontSize: 10,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              SizedBox(width: 4.w),
                              Icon(
                                Icons.arrow_forward_ios_rounded,
                                color: Colors.white,
                                size: 10.sp,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
