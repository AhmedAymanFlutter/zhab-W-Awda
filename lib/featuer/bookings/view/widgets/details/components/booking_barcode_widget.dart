import 'package:barcode_widget/barcode_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class BookingBarcodeWidget extends StatelessWidget {
  final String barcodeData;
  final String displayCode;

  const BookingBarcodeWidget({
    super.key,
    required this.barcodeData,
    required this.displayCode,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          BarcodeWidget(
            barcode: Barcode.code128(),
            data: barcodeData,
            width: 200.w,
            height: 50.h,
            drawText: false,
          ),
          SizedBox(height: 4.h),
          Text(
            displayCode,
            style: TextStyle(
              fontSize: 14.sp,
              letterSpacing: 4,
              color: Colors.black,
              fontFamily: 'elMessiri',
            ),
          ),
        ],
      ),
    );
  }
}
