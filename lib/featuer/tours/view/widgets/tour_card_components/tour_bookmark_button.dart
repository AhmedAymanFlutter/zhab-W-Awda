import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

class TourBookmarkButton extends StatefulWidget {
  const TourBookmarkButton({super.key});

  @override
  State<TourBookmarkButton> createState() => _TourBookmarkButtonState();
}

class _TourBookmarkButtonState extends State<TourBookmarkButton> {
  bool isBookmarked = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        setState(() {
          isBookmarked = !isBookmarked;
        });
      },
      child: isBookmarked
          ? Container(
              width: 32.w,
              height: 32.w,
              decoration: BoxDecoration(
                color: Colors.black.withOpacity(0.4),
                shape: BoxShape.circle,
              ),
              child: Center(
                child: SvgPicture.asset(
                  'assets/icon/filled.svg',
                  width: 16.w,
                ),
              ),
            )
          : Container(
              width: 32.w,
              height: 32.w,
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
              ),
              child: Center(
                child: SvgPicture.asset(
                  'assets/icon/bookmark-02 (1).svg',
                  width: 20.w,
                  colorFilter: const ColorFilter.mode(
                    Colors.white,
                    BlendMode.srcIn,
                  ),
                ),
              ),
            ),
    );
  }
}
