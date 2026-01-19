import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../../core/theme/app_color.dart';
import '../../../../../../core/theme/app_text_style.dart';

class PackageTimelineItem extends StatelessWidget {
  final dynamic path;
  final bool isLast;

  const PackageTimelineItem({
    super.key,
    required this.path,
    required this.isLast,
  });

  @override
  Widget build(BuildContext context) {
    return IntrinsicHeight(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Column(
            children: [
              Container(
                width: 12.w,
                height: 12.w,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: AppColor.primaryBlue,
                  boxShadow: [
                    BoxShadow(
                      color: AppColor.primaryBlue.withOpacity(0.3),
                      blurRadius: 4,
                      offset: const Offset(0, 2),
                    ),
                  ],
                  border: Border.all(color: Colors.white, width: 2),
                ),
              ),
              if (!isLast)
                Expanded(
                  child: Container(
                    width: 2.w,
                    margin: EdgeInsets.symmetric(vertical: 4.h),
                    color: AppColor.primaryBlue.withOpacity(0.2),
                  ),
                ),
            ],
          ),
          SizedBox(width: 12.w),
          Expanded(
            child: Padding(
              padding: EdgeInsets.only(bottom: 16.h),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    path.title ?? "",
                    style: AppTextStyle.setelMessiriBlack(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  if (path.description != null)
                    Text(
                      path.description!,
                      style: AppTextStyle.setelMessiriSecondlightGrey(
                        fontSize: 12,
                        fontWeight: FontWeight.normal,
                      ).copyWith(height: 1.4),
                    ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
