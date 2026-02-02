import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../../core/theme/app_color.dart';

class PackageBranchTabs extends StatelessWidget {
  final List<dynamic> branches;
  final TabController? tabController;
  final ValueChanged<int> onTabChanged;

  const PackageBranchTabs({
    super.key,
    required this.branches,
    required this.tabController,
    required this.onTabChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 45.h,
      margin: EdgeInsets.symmetric(horizontal: 20.w),
      decoration: BoxDecoration(
        color: AppColor.primaryRed,
        borderRadius: BorderRadius.circular(12.r),
      ),
      padding: EdgeInsets.all(4.w),
      child: TabBar(
        controller: tabController,
        isScrollable: branches.length > 3,
        labelColor: Colors.white,
        unselectedLabelColor: AppColor.secondaryGrey,
        indicatorSize: TabBarIndicatorSize.tab,
        indicator: BoxDecoration(
          color: AppColor.primaryBlue,
          borderRadius: BorderRadius.circular(10.r),
          boxShadow: [
            BoxShadow(
              color: AppColor.primaryBlue.withOpacity(0.3),
              blurRadius: 4,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        labelStyle: TextStyle(fontWeight: FontWeight.bold, fontSize: 13.sp),
        unselectedLabelStyle: TextStyle(
          fontWeight: FontWeight.w500,
          fontSize: 13.sp,
        ),
        dividerColor: Colors.transparent,
        tabs: branches
            .map((b) => Tab(text: b.name?.split('-').last.trim() ?? "Option"))
            .toList(),
        onTap: onTabChanged,
      ),
    );
  }
}
