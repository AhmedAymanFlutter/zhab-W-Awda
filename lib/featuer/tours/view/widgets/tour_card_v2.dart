import 'package:flutter/material.dart';
import 'package:flutter_application_1/core/router/routes.dart';
import 'package:flutter_application_1/featuer/tours/data/model/get_all_tours_model.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'tour_card_components/tour_arrow_icon.dart';
import 'tour_card_components/tour_background_image.dart';
import 'tour_card_components/tour_bookmark_button.dart';
import 'tour_card_components/tour_bottom_content.dart';
import 'tour_card_components/tour_gradient_overlay.dart';

class TourCardV2 extends StatelessWidget {
  final TourItem tour;

  const TourCardV2({super.key, required this.tour});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.pushNamed(
          context,
          Routes.tourDetailsView,
          arguments: tour.sId,
        );
      },
      child: Container(
        width: 240.w,
        height: 291.h,
        decoration: BoxDecoration(
          color: const Color(0xFFEAE9EB),
          borderRadius: BorderRadius.circular(20.r),
          boxShadow: const [
            BoxShadow(
              color: Color(0x40000000), // #00000040
              offset: Offset(0, 4),
              blurRadius: 8,
              spreadRadius: 0,
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(20.r),
          child: Stack(
            fit: StackFit.expand,
            children: [
              TourBackgroundImage(imageUrl: tour.imageCover),
              const TourGradientOverlay(),
              const Positioned(top: 16, right: 16, child: TourBookmarkButton()),
              const Positioned(top: 16, left: 16, child: TourArrowIcon()),
              Positioned(
                bottom: 16,
                left: 16,
                right: 16,
                child: TourBottomContent(tour: tour),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
