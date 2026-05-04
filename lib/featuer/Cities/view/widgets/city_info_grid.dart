import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/theme/app_color.dart';
import '../../data/model/get_city_details_model.dart';

class CityInfoGrid extends StatelessWidget {
  final CityObj city;

  const CityInfoGrid({super.key, required this.city});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(child: _buildInfoItem(Icons.calendar_month_rounded, "أفضل شهر", city.favMonth?.isNotEmpty == true ? city.favMonth!.first : "-")),
        _buildDivider(),
        Expanded(child: _buildInfoItem(Icons.explore_outlined, "المنطقة", city.country?.name ?? "-")),
        _buildDivider(),
        Expanded(child: _buildInfoItem(Icons.photo_library_outlined, "الصور", "${city.images?.length ?? 0} صورة")),
      ],
    );
  }

  Widget _buildInfoItem(IconData icon, String label, String value) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, color: AppColor.primaryBlue, size: 24.sp),
        SizedBox(height: 8.h),
        Text(
          label,
          style: TextStyle(fontSize: 11.sp, color: Colors.grey.shade600),
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
        SizedBox(height: 4.h),
        Text(
          value,
          style: TextStyle(fontSize: 13.sp, fontWeight: FontWeight.bold, color: Colors.black),
          textAlign: TextAlign.center,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
      ],
    );
  }

  Widget _buildDivider() {
    return Container(
      width: 1,
      height: 40.h,
      color: Colors.grey.withOpacity(0.2),
    );
  }
}
