import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../../core/theme/app_color.dart';
import '../../../../../../core/theme/app_text_style.dart';

class PackageBookingPanel extends StatelessWidget {
  final num? price;
  final String? packageName;
  final VoidCallback? onBookTap;
  final VoidCallback? onWhatsappTap;

  const PackageBookingPanel({
    super.key,
    this.price,
    this.packageName,
    this.onBookTap,
    this.onWhatsappTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 375.w,
      height: 280.h,
      padding: EdgeInsets.only(top: 16.h, left: 16.w, right: 16.w, bottom: 20.h),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: const Color(0x0D000000),
            blurRadius: 16.r,
            offset: const Offset(0, -2),
          ),
        ],
      ),
      child: Column(
        children: [
          // Price and Label
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text(
                        "${price ?? 0}",
                        style: AppTextStyle.setelMessiriBlack(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ).copyWith(color: AppColor.primaryBlue3),
                      ),
                      SizedBox(width: 4.w),
                      Text(
                        "ريال",
                        style: AppTextStyle.setelMessiriBlack(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ).copyWith(color: AppColor.primaryBlue3),
                      ),
                    ],
                  ),
                  Text(
                    "السعر لـ 2 شخص",
                    style: AppTextStyle.setelMessiriSecondlightGrey(
                      fontSize: 12,
                      fontWeight: FontWeight.normal,
                    ),
                  ),
                ],
              ),
              Text(
                "تفاصيل الباقة",
                style: AppTextStyle.setelMessiriBlack(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          SizedBox(height: 16.h),
          
          // Payment Options (Tabby/Tamara)
          Text(
            "التقسيط متاح",
            style: AppTextStyle.setelMessiriSecondlightGrey(
              fontSize: 12,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 8.h),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset('assets/photo/tabby.png', height: 24.h, errorBuilder: (_, __, ___) => const Text("Tabby")),
              SizedBox(width: 12.w),
              Container(width: 1, height: 20.h, color: Colors.grey[300]),
              SizedBox(width: 12.w),
              Image.asset('assets/photo/tamara.png', height: 24.h, errorBuilder: (_, __, ___) => const Text("Tamara")),
            ],
          ),
          
          const Spacer(),
          
          // Action Buttons
          Row(
            children: [
              Expanded(
                flex: 2,
                child: ElevatedButton(
                  onPressed: onBookTap,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColor.primaryBlue3,
                    minimumSize: Size(double.infinity, 50.h),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.r),
                    ),
                  ),
                  child: Text(
                    "سجل الطلب",
                    style: AppTextStyle.setelMessiriWhite(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              SizedBox(width: 12.w),
              Expanded(
                flex: 1,
                child: InkWell(
                  onTap: onWhatsappTap,
                  child: Container(
                    height: 50.h,
                    decoration: BoxDecoration(
                      color: const Color(0xFF4CAF50),
                      borderRadius: BorderRadius.circular(10.r),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SvgPicture.asset(
                          'assets/icon/whatsapp.svg',
                          width: 24.w,
                          height: 24.h,
                        ),
                        SizedBox(width: 4.w),
                        Text(
                          "تواصل",
                          style: AppTextStyle.setelMessiriWhite(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
