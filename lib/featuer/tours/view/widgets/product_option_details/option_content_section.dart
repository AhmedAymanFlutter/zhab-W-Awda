import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class OptionContentSection extends StatelessWidget {
  final List<String> items;
  final String? aboutText;
  final String categoryTitle;

  const OptionContentSection({
    super.key,
    required this.items,
    this.aboutText,
    required this.categoryTitle,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          if (aboutText != null && aboutText!.isNotEmpty) ...[
            Text(
              "حول الباقة",
              style: TextStyle(
                fontSize: 18.sp,
                fontWeight: FontWeight.bold,
                fontFamily: 'ElMessiri',
                color: Colors.black,
              ),
            ),
            SizedBox(height: 8.h),
            Text(
              aboutText!,
              textAlign: TextAlign.right,
              style: TextStyle(
                fontSize: 14.sp,
                color: Colors.grey[700],
                fontFamily: 'ElMessiri',
                height: 1.6,
              ),
            ),
            SizedBox(height: 24.h),
          ],
          Text(
            "تفاصيل",
            style: TextStyle(
              fontSize: 18.sp,
              fontWeight: FontWeight.bold,
              fontFamily: 'ElMessiri',
              color: Colors.black,
            ),
          ),
          SizedBox(height: 12.h),
          ...items.map((item) => _buildDetailItem(item)),
        ],
      ),
    );
  }

  Widget _buildDetailItem(String text) {
    return Padding(
      padding: EdgeInsets.only(bottom: 12.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Text(
              text,
              textAlign: TextAlign.right,
              style: TextStyle(
                fontSize: 14.sp,
                color: Colors.grey[800],
                fontFamily: 'ElMessiri',
                height: 1.4,
              ),
            ),
          ),
          SizedBox(width: 12.w),
          Icon(
            Icons.check_circle_outline_rounded,
            size: 20.sp,
            color: Colors.green[600],
          ),
        ],
      ),
    );
  }
}
