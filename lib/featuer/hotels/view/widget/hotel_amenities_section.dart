import 'package:flutter/material.dart';
import 'package:flutter_application_1/featuer/hotels/data/model/get_hotel_details_model.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class HotelAmenitiesSection extends StatelessWidget {
  final List<Includes>? amenities;

  const HotelAmenitiesSection({super.key, this.amenities});

  @override
  Widget build(BuildContext context) {
    if (amenities == null || amenities!.isEmpty) return const SizedBox.shrink();

    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: amenities!.length,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 4,
        crossAxisSpacing: 16.w,
        mainAxisSpacing: 12.h,
      ),
      itemBuilder: (context, index) {
        final amenity = amenities![index];
        return Row(
          children: [
            Icon(_getIcon(amenity.icon), size: 20.sp, color: Colors.grey[600]),
            SizedBox(width: 8.w),
            Expanded(
              child: Text(
                amenity.title ?? "",
                style: TextStyle(fontSize: 14.sp, color: Colors.grey[700]),
              ),
            ),
          ],
        );
      },
    );
  }

  IconData _getIcon(String? iconName) {
    switch (iconName?.toLowerCase()) {
      case 'wifi':
        return Icons.wifi;
      case 'pool':
        return Icons.pool;
      case 'parking':
        return Icons.local_parking;
      case 'room_service':
        return Icons.room_service;
      case 'spa':
        return Icons.spa;
      case 'fitness_center':
        return Icons.fitness_center;
      case 'restaurant':
        return Icons.restaurant;
      case 'beach_access':
        return Icons.beach_access;
      default:
        return Icons.done;
    }
  }
}
