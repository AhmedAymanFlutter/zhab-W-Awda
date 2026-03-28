import 'package:flutter/material.dart';
import 'package:flutter_application_1/core/theme/app_color.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:percent_indicator/percent_indicator.dart';

class CircularNextButton extends StatefulWidget {
  final double progress;
  final VoidCallback onTap;

  const CircularNextButton({
    super.key,
    required this.progress,
    required this.onTap,
  });

  @override
  State<CircularNextButton> createState() => _CircularNextButtonState();
}

class _CircularNextButtonState extends State<CircularNextButton>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _rotationAnimation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );
    _rotationAnimation =
        Tween<double>(
          begin: 0,
          end: 0.5, // 180 degrees (0.5 * 360 = 180)
        ).animate(
          CurvedAnimation(
            parent: _animationController,
            curve: Curves.easeInOut,
          ),
        );
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  void _handleTap() {
    _animationController.forward().then((_) {
      _animationController.reverse();
    });
    widget.onTap();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _handleTap,
      child: CircularPercentIndicator(
        radius: 46.w,
        lineWidth: 4,
        percent: widget.progress,
        progressColor: Colors.white,
        backgroundColor: Colors.white.withOpacity(0.2),
        circularStrokeCap: CircularStrokeCap.round,
        center: Container(
          width: 75.w,
          height: 75.h,
          decoration: const BoxDecoration(
            shape: BoxShape.circle,
            color: Colors.white,
          ),
          child: RotationTransition(
            turns: _rotationAnimation,
            child: Icon(
              Icons.arrow_forward_ios,
              color: AppColor.primaryBlue3,
              size: 24.sp,
            ),
          ),
        ),
      ),
    );
  }
}
