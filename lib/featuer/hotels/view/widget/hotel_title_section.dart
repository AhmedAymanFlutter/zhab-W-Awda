import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/theme/app_text_style.dart';

class HotelTitleSection extends StatelessWidget {
  final String? name;
  final String? city;
  final String? country;

  const HotelTitleSection({
    super.key,
    required this.name,
    required this.city,
    required this.country,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          name ?? "Hotel Name",
          style: AppTextStyle.setelMessiriBlack(
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(height: 8.h),
        Row(
          children: [
            Icon(Icons.location_on, color: Colors.grey, size: 18.sp),
            SizedBox(width: 4.w),
            Expanded(
              child: Text(
                "${city ?? ''}, ${country ?? ''}",
                style: AppTextStyle.setelMessiriSecondlightGrey(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
