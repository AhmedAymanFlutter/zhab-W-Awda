import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/core/theme/app_text_style.dart';
import 'package:flutter_application_1/featuer/bookings/data/model/booking_details_model.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class BookingDestinationsList extends StatelessWidget {
  final List<CityDetail> cities;

  const BookingDestinationsList({super.key, required this.cities});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16.r),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Text(
                "الوجهات المشمولة",
                style: AppTextStyle.setelMessiriBlack(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(width: 8.w),
              Container(
                padding: EdgeInsets.all(6.w),
                decoration: BoxDecoration(
                  color: const Color(0xFFE6F7FF),
                  borderRadius: BorderRadius.circular(8.r),
                ),
                child: const Icon(
                  Icons.location_on_outlined,
                  color: Color(0xFF1890FF),
                ),
              ),
            ],
          ),
          SizedBox(height: 16.h),
          SizedBox(
            height: 140.h,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              reverse: true, // For RTL feel in horizontal list
              itemCount: cities.length,
              itemBuilder: (context, index) {
                final city = cities[index];
                return _buildDestinationCard(city);
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDestinationCard(CityDetail city) {
    return Container(
      width: 140.w,
      margin: EdgeInsets.only(left: 12.w),
      child: Stack(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(12.r),
            child: CachedNetworkImage(
              imageUrl: city.imageCover ?? "",
              height: 140.h,
              width: 140.w,
              fit: BoxFit.cover,
              placeholder: (context, url) => Container(color: Colors.grey[200]),
              errorWidget: (context, url, error) => const Icon(Icons.error),
            ),
          ),
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12.r),
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [Colors.transparent, Colors.black.withOpacity(0.7)],
              ),
            ),
          ),
          Positioned(
            bottom: 12.h,
            right: 12.w,
            child: Text(
              city.name ?? "",
              style: AppTextStyle.setelMessiriWhite(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
