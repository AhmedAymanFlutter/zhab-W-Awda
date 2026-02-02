import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import '../../../../core/theme/app_text_style.dart';

class HotelDescription extends StatelessWidget {
  final String? description;

  const HotelDescription({super.key, required this.description});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Description",
          style: AppTextStyle.setelMessiriBlack(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(height: 8.h),
        HtmlWidget(
          description ?? "No description available.",
          textStyle: AppTextStyle.setelMessiriSecondlightGrey(
            fontSize: 14,
            fontWeight: FontWeight.bold,
          ).copyWith(height: 1.5),
        ),
      ],
    );
  }
}
