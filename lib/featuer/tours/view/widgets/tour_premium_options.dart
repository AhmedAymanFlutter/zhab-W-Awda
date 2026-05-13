import 'package:flutter/material.dart';
import 'package:flutter_application_1/featuer/tours/data/model/get_tour_id_model.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/theme/app_text_style.dart';
import 'tour_package_card.dart';

class TourPremiumOptions extends StatelessWidget {
  final List<ProductOption> options;
  final String? tourDescription;

  const TourPremiumOptions({super.key, required this.options, this.tourDescription});

  @override
  Widget build(BuildContext context) {
    if (options.isEmpty) return const SizedBox.shrink();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Text(
          "الباقات المتاحة لرحلتك السياحية",
          style: AppTextStyle.setelMessiriBlack(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(height: 16.h),
        
        ListView.separated(
          shrinkWrap: true,
          padding: EdgeInsets.zero,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: options.length,
          separatorBuilder: (context, index) => SizedBox(height: 16.h),
          itemBuilder: (context, index) {
            return Center(
              child: TourPackageCard(
                option: options[index],
                tourDescription: tourDescription,
              ),
            );
          },
        ),
        SizedBox(height: 32.h),
      ],
    );
  }
}

