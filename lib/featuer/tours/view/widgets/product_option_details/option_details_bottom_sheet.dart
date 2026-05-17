import 'package:flutter/material.dart';
import 'package:flutter_application_1/featuer/tours/data/model/get_tour_id_model.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../core/theme/app_color.dart';
import '../../../../../core/theme/app_text_style.dart';
import 'option_content_section.dart';
import 'option_details_header.dart';
import 'option_tab_bar.dart';

class OptionDetailsBottomSheet extends StatefulWidget {
  final ProductOption option;
  final String? tourDescription;

  const OptionDetailsBottomSheet({
    super.key,
    required this.option,
    this.tourDescription,
  });

  @override
  State<OptionDetailsBottomSheet> createState() =>
      _OptionDetailsBottomSheetState();
}

class _OptionDetailsBottomSheetState extends State<OptionDetailsBottomSheet> {
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.85,
      padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 12.h),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(30.r),
          topRight: Radius.circular(30.r),
        ),
      ),
      child: Column(
        children: [
          OptionDetailsHeader(title: widget.option.title ?? ""),
          SizedBox(height: 24.h),
          OptionTabBar(
            selectedIndex: _selectedIndex,
            onTabChanged: (index) {
              setState(() {
                _selectedIndex = index;
              });
            },
          ),
          SizedBox(height: 24.h),
          Expanded(child: _buildTabContent()),
          SizedBox(height: 20.h),
          ElevatedButton(
            onPressed: () {
              // Implementation for booking
              Navigator.pop(context);
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColor.primaryBlue3,
              minimumSize: Size(double.infinity, 50.h),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(25.r),
              ),
              elevation: 0,
            ),
            child: Text(
              "احجز الآن",
              style: AppTextStyle.setelMessiriWhite(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          SizedBox(height: 20.h),
        ],
      ),
    );
  }

  Widget _buildTabContent() {
    switch (_selectedIndex) {
      case 0:
        return OptionContentSection(
          items: widget.option.packageDescription ?? [],
          aboutText: widget.tourDescription,
          categoryTitle: "وصف الباقة",
        );
      case 1:
        return OptionContentSection(
          items: widget.option.howToUse ?? [],
          categoryTitle: "كيفية الإستخدام",
        );
      case 2:
        return OptionContentSection(
          items: widget.option.termsAndConditions ?? [],
          categoryTitle: "الشروط والأحكام",
        );
      default:
        return const SizedBox.shrink();
    }
  }
}
