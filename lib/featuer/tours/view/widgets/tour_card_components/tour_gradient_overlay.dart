import 'package:flutter/material.dart';

class TourGradientOverlay extends StatelessWidget {
  const TourGradientOverlay({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            Colors.transparent,
            Colors.black.withOpacity(0.2),
            Colors.black.withOpacity(0.85),
          ],
          stops: const [0.3, 0.6, 1.0],
        ),
      ),
    );
  }
}
