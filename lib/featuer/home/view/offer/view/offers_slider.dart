import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:skeletonizer/skeletonizer.dart';
import '../data/model/get_all_offers_model.dart';
import 'modern_offer_card.dart';

class OffersSlider extends StatefulWidget {
  final List<OfferItem> offers;

  const OffersSlider({super.key, required this.offers});

  @override
  State<OffersSlider> createState() => _OffersSliderState();
}

class _OffersSliderState extends State<OffersSlider> {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        CarouselSlider.builder(
          itemCount: widget.offers.length,
          itemBuilder: (context, index, realIndex) {
            final offer = widget.offers[index];

            return Skeletonizer(
              enabled: widget.offers.isEmpty,
              child: ModernOfferCard(offer: offer),
            );
          },
          options: CarouselOptions(
            height: 165.h,
            viewportFraction: 0.9,
            autoPlay: true,
            enlargeCenterPage: true,
            enableInfiniteScroll: true,
            autoPlayCurve: Curves.fastOutSlowIn,
          ),
        ),
      ],
    );
  }
}
