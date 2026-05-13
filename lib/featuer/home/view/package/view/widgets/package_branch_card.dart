import 'package:flutter/material.dart';
import 'package:flutter_application_1/featuer/home/view/package/data/model/package_details_model.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../../core/theme/app_color.dart';
import '../../../../../../core/theme/app_text_style.dart';

class PackageBranchCard extends StatelessWidget {
  final PackageBranch branch;
  final bool isSelected;
  final VoidCallback? onTap;

  const PackageBranchCard({
    super.key,
    required this.branch,
    this.isSelected = false,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        width: 327.w, // Adjusted width to match the aspect ratio in the image better
        height: 340.h,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(24.r),
          border: isSelected ? Border.all(color: AppColor.primaryBlue3, width: 2) : null,
          boxShadow: [
            BoxShadow(
              color: const Color(0x14000000),
              blurRadius: 15.r,
              offset: const Offset(0, 8),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            // Branch Image with Price Badge
            Stack(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.vertical(top: Radius.circular(24.r)),
                  child: Image.network(
                    branch.days?.first.city?.imageCover ?? "",
                    height: 180.h,
                    width: double.infinity,
                    fit: BoxFit.cover,
                    errorBuilder: (_, __, ___) => Container(
                      height: 180.h,
                      color: Colors.grey[200],
                      child: const Icon(Icons.image_not_supported),
                    ),
                  ),
                ),
                Positioned(
                  top: 12.h,
                  right: 12.w,
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
                    decoration: BoxDecoration(
                      color: AppColor.primaryBlue3,
                      borderRadius: BorderRadius.circular(20.r),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          "ريال",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 14.sp,
                            fontWeight: FontWeight.bold,
                            fontFamily: 'ElMessiri',
                          ),
                        ),
                        SizedBox(width: 4.w),
                        Text(
                          "${branch.price?.toInt() ?? 0}",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 18.sp,
                            fontWeight: FontWeight.bold,
                            fontFamily: 'ElMessiri',
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            
            Padding(
              padding: EdgeInsets.all(16.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    branch.name ?? "",
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    textAlign: TextAlign.right,
                    style: AppTextStyle.setelMessiriBlack(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 8.h),
                  Text(
                    branch.cities?.map((c) => c.name).join('، ') ?? "",
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    textAlign: TextAlign.right,
                    style: AppTextStyle.setelMessiriSecondlightGrey(
                      fontSize: 14,
                      fontWeight: FontWeight.normal,
                    ),
                  ),
                  SizedBox(height: 16.h),
                  // Stats Row with Separators
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      _buildStatItem("${branch.daysCount} أيام", Icons.wb_sunny_outlined),
                      _buildSeparator(),
                      _buildStatItem("${branch.nightsCount} ليالي", Icons.nightlight_outlined),
                      _buildSeparator(),
                      _buildStatItem("عروسان", Icons.people_outline),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStatItem(String label, IconData icon) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          label,
          style: AppTextStyle.setelMessiriSecondlightGrey(
            fontSize: 13,
            fontWeight: FontWeight.normal,
          ),
        ),
        SizedBox(width: 4.w),
        Icon(icon, size: 16.sp, color: Colors.grey[600]),
      ],
    );
  }

  Widget _buildSeparator() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 12.w),
      child: Container(
        width: 1,
        height: 14.h,
        color: Colors.grey[300],
      ),
    );
  }
}
