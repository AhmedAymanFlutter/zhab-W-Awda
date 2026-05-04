import 'package:flutter/material.dart';
import 'package:flutter_application_1/featuer/hotels/data/model/get_hotel_details_model.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/theme/app_text_style.dart';

class HotelPoliciesSection extends StatelessWidget {
  final List<Policies>? policies;

  const HotelPoliciesSection({super.key, this.policies});

  @override
  Widget build(BuildContext context) {
    if (policies == null || policies!.isEmpty) return const SizedBox.shrink();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "سياسات الفندق",
          style: AppTextStyle.setelMessiriBlack(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(height: 8.h),
        const Divider(color: Color(0xFFEEEEEE), thickness: 1),
        SizedBox(height: 16.h),
        SizedBox(
          height: 230.h, // Adjusted to fit card + shadows
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            itemCount: policies!.length,
            separatorBuilder: (context, index) => SizedBox(width: 16.w),
            itemBuilder: (context, index) => _buildPolicyCard(policies![index]),
          ),
        ),
      ],
    );
  }

  Widget _buildPolicyCard(Policies policy) {
    IconData icon;
    switch (policy.title) {
      case "خيارات الدفع":
        icon = Icons.credit_card_outlined;
        break;
      case "سياسة الإلغاء":
        icon = Icons.cancel_presentation_outlined;
        break;
      case "سياسة الأطفال":
        icon = Icons.child_care_outlined;
        break;
      default:
        icon = Icons.policy_outlined;
    }

    return Container(
      width: 272.w,
      height: 213.h,
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 20.h),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(color: const Color(0xFFF3F4F6), width: 0.8),
        boxShadow: const [
          BoxShadow(
            color: Color(0x21000000),
            blurRadius: 7,
            offset: Offset(0, 2),
            spreadRadius: -1,
          ),
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            padding: EdgeInsets.all(12.w),
            decoration: BoxDecoration(
              color: const Color(0xFFE8EDF2),
              borderRadius: BorderRadius.circular(12.r),
            ),
            child: Icon(
              icon,
              color: const Color(0xff033042),
              size: 24.sp,
            ),
          ),
          SizedBox(height: 12.h),
          Text(
            policy.title ?? "",
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 16.sp,
              fontWeight: FontWeight.bold,
              color: const Color(0xff033042),
            ),
          ),
          SizedBox(height: 8.h),
          Text(
            policy.description ?? "",
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 12.sp,
              color: Colors.grey[700],
              height: 1.5,
            ),
          ),
        ],
      ),
    );
  }
}
