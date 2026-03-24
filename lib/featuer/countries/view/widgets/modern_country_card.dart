import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../../../../core/theme/app_text_style.dart';
import '../../data/model/get_countries_model.dart';
import '../country_details_view.dart';

class ModernCountryCard extends StatelessWidget {
  final CountryItem country;

  const ModernCountryCard({super.key, required this.country});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        if (country.slug != null) {
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
        width: 160.w, // Fixed width for horizontal list
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
                    country.imageCover ?? "https://via.placeholder.com/200x300",
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

              // 3. Content (Bottom)
              Padding(
                padding: EdgeInsets.all(12.w),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      country.name ?? "اسم الدولة",
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: AppTextStyle.setelMessiriWhite(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ).copyWith(height: 1.2),
                    ),
                    SizedBox(height: 4.h),
                    if (country.continent != null)
                      Row(
                        children: [
                          Icon(
                            Icons.public,
                            color: Colors.white70,
                            size: 12.sp,
                          ),
                          SizedBox(width: 4.w),
                          Expanded(
                            child: Text(
                              country.continent!,
                              style: TextStyle(
                                fontSize: 12.sp,
                                color: Colors.white70,
                                fontWeight: FontWeight.w500,
                              ),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
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
