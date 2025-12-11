import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/core/router/routes.dart';
import 'package:flutter_application_1/featuer/tours/data/model/get_all_tours_model.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/theme/app_color.dart';
import '../../../../core/theme/app_text_style.dart';

class TourCard extends StatelessWidget {
  final TourItem tour;

  const TourCard({super.key, required this.tour});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.pushNamed(
          context,
          Routes.tourDetailsView,
          arguments: tour.sId,
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
              flex: 3,
              child: ClipRRect(
                borderRadius: BorderRadius.vertical(top: Radius.circular(16.r)),
                child: CachedNetworkImage(
                  imageUrl:
                      tour.imageCover ?? "https://via.placeholder.com/200",
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
              flex: 2,
              child: Padding(
                padding: EdgeInsets.all(8.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      tour.title ?? "اسم الجولة",
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: AppTextStyle.setelMessiriBlack(
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 4.h),
                    // Location (City/Country)
                    if (tour.city != null || tour.country != null)
                      Row(
                        children: [
                          Icon(
                            Icons.location_on,
                            color: AppColor.secondaryGrey,
                            size: 12.sp,
                          ),
                          SizedBox(width: 4.w),
                          Expanded(
                            child: Text(
                              "${tour.city?.name ?? ''} ${tour.city != null && tour.country != null ? '-' : ''} ${tour.country?.name ?? ''}",
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: AppTextStyle.setelMessiriSecondlightGrey(
                                fontSize: 10,
                                fontWeight: FontWeight.normal,
                              ),
                            ),
                          ),
                        ],
                      ),
                    const Spacer(),
                    // Days / People info if available
                    if (tour.header != null)
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          if (tour.header!.days != null)
                            Text(
                              "${tour.header!.days} أيام",
                              style: TextStyle(
                                fontSize: 10.sp,
                                color: AppColor.primaryBlue,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          if (tour.header!.people != null)
                            Icon(
                              Icons.people,
                              size: 14.sp,
                              color: AppColor.secondaryGrey,
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
