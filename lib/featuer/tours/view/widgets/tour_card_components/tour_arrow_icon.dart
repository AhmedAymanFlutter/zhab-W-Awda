import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class TourArrowIcon extends StatelessWidget {
  const TourArrowIcon({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 32.w,
      height: 32.w,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(color: Colors.white, width: 1),
      ),
      child: Center(
        child: Icon(
          Icons.north_west,
          color: Colors.white,
          size: 16.sp,
        ),
      ),
    );
  }
}
