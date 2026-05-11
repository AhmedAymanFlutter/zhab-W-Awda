import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/theme/app_color.dart';
import 'widgets/tours_header_section.dart';
import 'widgets/tours_list_view_section.dart';

class ToursView extends StatelessWidget {
  const ToursView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.primaryWhite,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w),
          child: Column(
            children: [
              SizedBox(height: 16.h),
              const ToursHeaderSection(),
              SizedBox(height: 16.h),
              const Expanded(
                child: ToursListViewSection(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
