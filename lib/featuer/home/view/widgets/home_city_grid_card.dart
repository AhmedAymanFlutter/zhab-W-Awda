import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/core/router/routes.dart';
import 'package:flutter_application_1/featuer/Cities/data/model/getcitiesModel.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/theme/app_text_style.dart';

class HomeCityGridCard extends StatelessWidget {
  final CityItem city;
  final bool isLarge;

  const HomeCityGridCard({super.key, required this.city, this.isLarge = false});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        if (city.slug != null) {
          Navigator.pushNamed(
            context,
            Routes.cityDetailsView,
            arguments: city.slug,
          );
        }
      },
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20.r),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(20.r),
          child: Stack(
            fit: StackFit.expand,
            children: [
              // Background Image
              CachedNetworkImage(
                imageUrl: city.imageCover ?? "",
                fit: BoxFit.cover,
                placeholder: (context, url) => Container(color: Colors.grey[200]),
                errorWidget: (context, url, error) => Container(
                  color: Colors.grey[300],
                  child: const Icon(Icons.image_not_supported_outlined, color: Colors.grey),
                ),
              ),
              // Gradient Overlay
              DecoratedBox(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.bottomCenter,
                    end: Alignment.topCenter,
                    colors: [
                      Colors.black.withOpacity(0.8),
                      Colors.black.withOpacity(0.2),
                      Colors.transparent,
                    ],
                    stops: const [0.0, 0.4, 0.7],
                  ),
                ),
              ),
              // City Name
              Positioned(
                bottom: 16.h,
                right: 16.w,
                left: 16.w,
                child: Text(
                  city.name ?? "وجهة سياحية",
                  style: AppTextStyle.setelMessiriWhite(
                    fontSize: isLarge ? 20 : 16, 
                    fontWeight: FontWeight.bold,
                  ).copyWith(
                    shadows: [
                      const Shadow(
                        color: Colors.black54,
                        offset: Offset(0, 2),
                        blurRadius: 4,
                      ),
                    ],
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
