import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../../core/theme/app_text_style.dart';

class PackageInclusionsExclusionsSection extends StatelessWidget {
  final List<String>? inclusions;
  final List<String>? exclusions;

  const PackageInclusionsExclusionsSection({
    super.key,
    this.inclusions,
    this.exclusions,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (inclusions != null && inclusions!.isNotEmpty) ...[
          Text(
            "ما تشمله الباقة",
            style: AppTextStyle.setelMessiriBlack(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 16.h),
          ...inclusions!.map((item) => _buildItem(item, true)).toList(),
          SizedBox(height: 32.h),
        ],
        if (exclusions != null && exclusions!.isNotEmpty) ...[
          Text(
            "ما لا تشمله الباقة",
            style: AppTextStyle.setelMessiriBlack(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 16.h),
          ...exclusions!.map((item) => _buildItem(item, false)).toList(),
          SizedBox(height: 32.h),
        ],
      ],
    );
  }

  Widget _buildItem(String text, bool isIncluded) {
    return Padding(
      padding: EdgeInsets.only(bottom: 12.h),
      child: Row(
        children: [
          Container(
            padding: EdgeInsets.all(4.w),
            decoration: BoxDecoration(
              color: isIncluded ? Colors.green.withOpacity(0.1) : Colors.red.withOpacity(0.1),
              shape: BoxShape.circle,
            ),
            child: Icon(
              isIncluded ? Icons.check : Icons.close,
              color: isIncluded ? Colors.green : Colors.red,
              size: 16.sp,
            ),
          ),
          SizedBox(width: 12.w),
          Expanded(
            child: Text(
              text,
              style: TextStyle(
                fontSize: 14.sp,
                color: Colors.grey[800],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
