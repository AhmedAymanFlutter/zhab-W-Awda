import 'package:flutter/material.dart';
import 'package:flutter_application_1/core/theme/app_color.dart';
import 'package:flutter_application_1/core/theme/app_text_style.dart';
import 'package:flutter_application_1/featuer/tours/data/model/get_all_tours_model.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ToursPaginationWidget extends StatelessWidget {
  final Pagination pagination;
  final Function(int page) onPageChanged;

  const ToursPaginationWidget({
    super.key,
    required this.pagination,
    required this.onPageChanged,
  });

  @override
  Widget build(BuildContext context) {
    if ((pagination.totalPages ?? 0) < 1) return const SizedBox.shrink();

    return Container(
      margin: EdgeInsets.symmetric(vertical: 20.h),
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          // Previous Button
          _buildArrowButton(
            icon: Icons.arrow_back_ios_new,
            isEnabled: pagination.hasPrevPage ?? false,
            onTap: () => onPageChanged((pagination.currentPage ?? 1) - 1),
          ),
          
          SizedBox(width: 12.w),

          // Page Numbers
          Row(
            children: List.generate(pagination.totalPages!, (index) {
              final page = index + 1;
              final isSelected = page == pagination.currentPage;
              
              // Only show first, last, current, and pages around current
              if (page == 1 || 
                  page == pagination.totalPages || 
                  (page >= (pagination.currentPage! - 1) && page <= (pagination.currentPage! + 1))) {
                return _buildPageNumber(page, isSelected);
              } else if (page == 2 || page == pagination.totalPages! - 1) {
                return Padding(
                  padding: EdgeInsets.symmetric(horizontal: 4.w),
                  child: Text("...", style: TextStyle(color: Colors.grey, fontSize: 14.sp)),
                );
              }
              return const SizedBox.shrink();
            }),
          ),

          SizedBox(width: 12.w),

          // Next Button
          _buildArrowButton(
            icon: Icons.arrow_forward_ios,
            isEnabled: pagination.hasNextPage ?? false,
            onTap: () => onPageChanged((pagination.currentPage ?? 1) + 1),
          ),
        ],
      ),
    );
  }

  Widget _buildPageNumber(int page, bool isSelected) {
    return InkWell(
      onTap: () => onPageChanged(page),
      borderRadius: BorderRadius.circular(10.r),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        margin: EdgeInsets.symmetric(horizontal: 4.w),
        width: 36.w,
        height: 36.w,
        decoration: BoxDecoration(
          color: isSelected ? AppColor.primaryBlue : Colors.transparent,
          borderRadius: BorderRadius.circular(10.r),
          border: Border.all(
            color: isSelected ? AppColor.primaryBlue : Colors.grey.withOpacity(0.2),
          ),
        ),
        child: Center(
          child: Text(
            page.toString(),
            style: AppTextStyle.setelMessiriTextStyle(
              fontSize: 14,
              fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
              color: isSelected ? Colors.white : Colors.black87,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildArrowButton({
    required IconData icon,
    required bool isEnabled,
    required VoidCallback onTap,
  }) {
    return IconButton(
      onPressed: isEnabled ? onTap : null,
      icon: Icon(
        icon,
        size: 16.sp,
        color: isEnabled ? AppColor.primaryBlue : Colors.grey[300],
      ),
    );
  }
}
