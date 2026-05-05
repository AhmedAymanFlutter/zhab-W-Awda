import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AuthBackground extends StatelessWidget {
  final Widget child;

  const AuthBackground({
    super.key,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color(0xff94BCEB),
              Color(0xffF8FAFF),
              Color(0xffE2E7FF),
            ],
          ),
        ),
        child: Stack(
          children: [
            // Back button
            Positioned(
              top: 50.h,
              right: 20.w,
              child: IconButton(
                icon: const Icon(Icons.arrow_forward, color: Colors.black),
                onPressed: () => Navigator.maybePop(context),
              ),
            ),
            // Main Container at exact design position
            Positioned(
              top: 125.h,
              left: 16.w,
              right: 16.w,
              child: Container(
                width: 343.w,
                height: 564.h,
                padding: EdgeInsets.all(24.w),
                decoration: BoxDecoration(
                  color: const Color(0x99FFFFFF),
                  borderRadius: BorderRadius.circular(12.r),
                  border: Border.all(color: Colors.white, width: 1),
                ),
                child: child,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
