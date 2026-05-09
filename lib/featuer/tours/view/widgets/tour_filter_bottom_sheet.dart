import 'package:flutter/material.dart';
import 'package:flutter_application_1/core/theme/app_color.dart';
import 'package:flutter_application_1/core/theme/app_text_style.dart';
import 'package:flutter_application_1/featuer/Cities/data/model/getcitiesModel.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class TourFilterBottomSheet extends StatefulWidget {
  final List<CityItem> cities;
  final Function(String? cityId, String? priceRange) onApply;

  const TourFilterBottomSheet({
    super.key,
    required this.cities,
    required this.onApply,
  });

  @override
  State<TourFilterBottomSheet> createState() => _TourFilterBottomSheetState();
}

class _TourFilterBottomSheetState extends State<TourFilterBottomSheet> {
  String? selectedCityId;
  final List<Map<String, String>> _pricePresets = [
    {'label': 'الكل', 'value': ''},
    {'label': '0 - 50', 'value': '0-50'},
    {'label': '50 - 100', 'value': '50-100'},
    {'label': '100 - 500', 'value': '100-500'},
    {'label': '500+', 'value': '500-10000'},
  ];
  String selectedPriceRange = '';

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.fromLTRB(20.w, 20.h, 20.w, 30.h),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(24.r)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header Indicator
          Center(
            child: Container(
              width: 40.w,
              height: 4.h,
              decoration: BoxDecoration(
                color: Colors.grey[300],
                borderRadius: BorderRadius.circular(2.r),
              ),
            ),
          ),
          SizedBox(height: 20.h),
          Text(
            "تصفية الجولات",
            style: AppTextStyle.setelMessiriBlack(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 20.h),

          // City Selection
          Text(
            "اختر المدينة",
            style: AppTextStyle.setelMessiriBlack(
              fontSize: 16,
              fontWeight: FontWeight.w600,
            ),
          ),
          SizedBox(height: 12.h),
          SizedBox(
            height: 45.h,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              itemCount: widget.cities.length + 1,
              separatorBuilder: (_, __) => SizedBox(width: 10.w),
              itemBuilder: (context, index) {
                if (index == 0) {
                  return _buildFilterChip(
                    label: "الكل",
                    isSelected: selectedCityId == null,
                    onTap: () => setState(() => selectedCityId = null),
                  );
                }
                final city = widget.cities[index - 1];
                return _buildFilterChip(
                  label: city.name ?? "",
                  isSelected: selectedCityId == city.sId,
                  onTap: () => setState(() => selectedCityId = city.sId),
                );
              },
            ),
          ),
          SizedBox(height: 24.h),

          // Price Selection
          Text(
            "نطاق السعر",
            style: AppTextStyle.setelMessiriBlack(
              fontSize: 16,
              fontWeight: FontWeight.w600,
            ),
          ),
          SizedBox(height: 12.h),
          Wrap(
            spacing: 10.w,
            runSpacing: 10.h,
            children: _pricePresets.map((preset) {
              return _buildFilterChip(
                label: preset['label']!,
                isSelected: selectedPriceRange == preset['value'],
                onTap: () =>
                    setState(() => selectedPriceRange = preset['value']!),
              );
            }).toList(),
          ),
          SizedBox(height: 32.h),

          // Apply Button
          SizedBox(
            width: double.infinity,
            height: 54.h,
            child: ElevatedButton(
              onPressed: () {
                widget.onApply(
                  selectedCityId,
                  selectedPriceRange.isEmpty ? null : selectedPriceRange,
                );
                Navigator.pop(context);
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColor.primaryBlue,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16.r),
                ),
                elevation: 0,
              ),
              child: Text(
                "تطبيق",
                style: AppTextStyle.setelMessiriTextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFilterChip({
    required String label,
    required bool isSelected,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12.r),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
        decoration: BoxDecoration(
          color: isSelected ? AppColor.primaryBlue : const Color(0xFFF5F6F8),
          borderRadius: BorderRadius.circular(12.r),
          border: Border.all(
            color: isSelected ? AppColor.primaryBlue : Colors.transparent,
          ),
        ),
        child: Text(
          label,
          style: AppTextStyle.setelMessiriTextStyle(
            fontSize: 14,
            fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
            color: isSelected ? Colors.white : Colors.black87,
          ),
        ),
      ),
    );
  }
}
