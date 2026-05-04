import 'package:flutter/material.dart';
import 'package:flutter_application_1/featuer/home/view/package/data/model/package_details_model.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../../core/theme/app_color.dart';
import '../../../../../../core/theme/app_text_style.dart';

class PackageBranchCard extends StatelessWidget {
  final PackageBranch branch;
  final bool isSelected;
  final VoidCallback onTap;

  const PackageBranchCard({
    super.key,
    required this.branch,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 266.w,
        height: 286.h,
        padding: EdgeInsets.all(20.w),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(24.r),
          border: Border.all(
            color: isSelected ? AppColor.primaryBlue : const Color(0xFFEAE9EB),
            width: isSelected ? 2.w : 1.w,
          ),
          boxShadow: [
            BoxShadow(
              color: const Color(0x14000000), // #00000014
              offset: const Offset(0, 4),
              blurRadius: 8,
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              branch.name ?? "اسم الفرع",
              style: AppTextStyle.setelMessiriBlack(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
            SizedBox(height: 12.h),
            _buildInfoRow(
              Icons.calendar_today_outlined,
              "${branch.daysCount} أيام",
            ),
            SizedBox(height: 8.h),
            _buildInfoRow(
              Icons.nights_stay_outlined,
              "${branch.nightsCount} ليالي",
            ),
            const Spacer(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "السعر يبدأ من",
                      style: TextStyle(
                        fontSize: 12.sp,
                        color: Colors.grey[600],
                      ),
                    ),
                    Text(
                      "${branch.price} ريال",
                      style: AppTextStyle.setelMessiriBlack(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ).copyWith(color: AppColor.primaryBlue),
                    ),
                  ],
                ),
                if (isSelected)
                  const CircleAvatar(
                    backgroundColor: AppColor.primaryBlue,
                    radius: 12,
                    child: Icon(Icons.check, color: Colors.white, size: 16),
                  ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoRow(IconData icon, String text) {
    return Row(
      children: [
        Icon(icon, size: 16.sp, color: Colors.grey[600]),
        SizedBox(width: 8.w),
        Text(
          text,
          style: TextStyle(fontSize: 14.sp, color: Colors.grey[700]),
        ),
      ],
    );
  }
}
