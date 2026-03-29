import 'package:flutter/material.dart';
import '../../../../core/theme/app_text_style.dart';

/// A small stat badge showing a number + label, used in the hero section.
class StatBadge extends StatelessWidget {
  final String number;
  final String label;

  const StatBadge({super.key, required this.number, required this.label});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Text(
          number,
          style: AppTextStyle.setelMessiriWhite(
            fontSize: 22,
            fontWeight: FontWeight.w900,
          ),
        ),
        Text(
          label,
          style: AppTextStyle.setelMessiriWhite(
            fontSize: 11,
            fontWeight: FontWeight.w400,
          ),
        ),
      ],
    );
  }
}
