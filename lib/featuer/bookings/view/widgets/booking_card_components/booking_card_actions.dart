import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

class BookingCardActions extends StatelessWidget {
  final VoidCallback onDetailsTap;
  final VoidCallback onReceiptTap;

  const BookingCardActions({
    super.key,
    required this.onDetailsTap,
    required this.onReceiptTap,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: _buildButton(
            title: "تنزيل الإيصال",
            isPrimary: false,
            onTap: onReceiptTap,
          ),
        ),
        SizedBox(width: 8.w),
        Expanded(
          child: _buildButton(
            title: "عرض التفاصيل",
            isPrimary: true,
            onTap: onDetailsTap,
          ),
        ),
      ],
    );
  }

  Widget _buildButton({
    required String title,
    required bool isPrimary,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      child: Container(
        height: 40.h,
        decoration: BoxDecoration(
          color: isPrimary ? const Color(0xFF00276C) : Colors.white,
          borderRadius: BorderRadius.circular(8.r),
          border: Border.all(
            color: const Color(0xFFD0D5DD),
            width: isPrimary ? 0 : 1,
          ),
        ),
        alignment: Alignment.center,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (!isPrimary) ...[
              SvgPicture.asset(
                'assets/icon/file-download.svg',
                width: 20.w,
                height: 20.h,
                fit: BoxFit.scaleDown,
              ),
              SizedBox(width: 4.w),
            ],
            Text(
              title,
              style: TextStyle(
                color: isPrimary ? Colors.white : const Color(0xFF344054),
                fontSize: 14.sp,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
