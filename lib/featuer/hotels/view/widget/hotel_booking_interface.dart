import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/theme/app_color.dart';

class HotelBookingInterface extends StatelessWidget {
  const HotelBookingInterface({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(20.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 15,
            offset: const Offset(0, 5),
          ),
        ],
        border: Border.all(color: Colors.grey[100]!),
      ),
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: _buildInfoField(
                  label: "تسجيل الوصول",
                  value: "الأحد، 2 مارس",
                  icon: Icons.calendar_today_outlined,
                ),
              ),
              SizedBox(width: 12.w),
              Expanded(
                child: _buildInfoField(
                  label: "تسجيل المغادرة",
                  value: "الخميس، 6 مارس",
                  icon: Icons.calendar_today_outlined,
                ),
              ),
            ],
          ),
          SizedBox(height: 16.h),
          Row(
            children: [
              Expanded(
                child: _buildInfoField(
                  label: "عدد الليالي",
                  value: "4 ليالي",
                  isDropdown: true,
                ),
              ),
              SizedBox(width: 12.w),
              Expanded(
                child: _buildInfoField(
                  label: "عدد الضيوف",
                  value: "2 بالغين، 0 طفل",
                  isDropdown: true,
                ),
              ),
            ],
          ),
          SizedBox(height: 20.h),
          SizedBox(
            width: double.infinity,
            height: 50.h,
            child: ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColor.primaryBlue,
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12.r),
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.search),
                  SizedBox(width: 8.w),
                  Text(
                    "بحث",
                    style: TextStyle(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInfoField({
    required String label,
    required String value,
    IconData? icon,
    bool isDropdown = false,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: 12.sp,
            color: Colors.grey[600],
          ),
          textAlign: TextAlign.center,
        ),
        SizedBox(height: 8.h),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 10.h),
          decoration: BoxDecoration(
            color: Colors.grey[50],
            borderRadius: BorderRadius.circular(12.r),
            border: Border.all(color: Colors.grey[200]!),
          ),
          child: Row(
            children: [
              if (icon != null) ...[
                Icon(icon, size: 16.sp, color: AppColor.primaryBlue),
                SizedBox(width: 8.w),
              ],
              Expanded(
                child: Text(
                  value,
                  style: TextStyle(
                    fontSize: 13.sp,
                    fontWeight: FontWeight.w600,
                    color: Colors.black,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              if (isDropdown)
                Icon(Icons.keyboard_arrow_down, size: 18.sp, color: Colors.grey),
            ],
          ),
        ),
      ],
    );
  }
}
