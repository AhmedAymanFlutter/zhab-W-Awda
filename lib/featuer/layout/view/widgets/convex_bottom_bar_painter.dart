import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ConvexBottomBarPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.white
      ..style = PaintingStyle.fill;

    final path = Path();
    double width = size.width;
    double height = size.height;
    double centerWidth = width / 2;

    // Dome wave parameters - steep and tall to perfectly frame the central button
    double curveWidth = 55.w;
    double curveHeight = 35.h;

    path.moveTo(0, 0);
    path.lineTo(centerWidth - curveWidth, 0);

    // Steep and smooth upward dome
    path.cubicTo(
      centerWidth - curveWidth * 0.7,
      0,
      centerWidth - curveWidth * 0.4,
      -curveHeight,
      centerWidth,
      -curveHeight,
    );
    path.cubicTo(
      centerWidth + curveWidth * 0.4,
      -curveHeight,
      centerWidth + curveWidth * 0.7,
      0,
      centerWidth + curveWidth,
      0,
    );

    path.lineTo(width, 0);
    path.lineTo(width, height);
    path.lineTo(0, height);
    path.close();

    // Soft Shadow around the dome and horizontal edges
    canvas.drawShadow(
      path.shift(const Offset(0, -1)),
      Colors.black.withValues(alpha: 0.12),
      12,
      false,
    );
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}
