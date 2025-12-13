import 'package:flutter/material.dart';
import 'package:flutter_application_1/core/router/routes.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:cached_network_image/cached_network_image.dart'; // 👈 هام جداً
import '../../../../../core/theme/app_color.dart';
import '../data/model/get_all_offers_model.dart';

class OffersSlider extends StatefulWidget {
  final List<OfferItem> offers;

  const OffersSlider({super.key, required this.offers});

  @override
  State<OffersSlider> createState() => _OffersSliderState();
}

class _OffersSliderState extends State<OffersSlider> {
  final PageController _controller = PageController();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: 160.h,
          child: PageView.builder(
            controller: _controller,
            itemCount: widget.offers.length,
            itemBuilder: (context, index) {
              final offer = widget.offers[index];

              return InkWell(
                onTap: () {
                  Navigator.pushNamed(
                    context,
                    Routes.offerDetailsView,
                    arguments: offer.sId,
                  );
                },
                child: Skeletonizer(
                  enabled: widget.offers.isEmpty,
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16.w),
                    child: Row(
                      children: [
                        Expanded(
                          child: Container(
                            decoration: BoxDecoration(
                              color: AppColor.primaryRed.withOpacity(0.1),
                              borderRadius: BorderRadius.circular(16.r),
                            ),
                            child: Skeletonizer(
                              enabled: widget.offers.isEmpty,
                              child: Stack(
                                children: [
                                  Positioned.fill(
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(16.r),
                                      child: CachedNetworkImage(
                                        imageUrl:
                                            offer.imageCover ??
                                            "https://images.unsplash.com/photo-1476514525535-07fb3b4ae5f1?auto=format&fit=crop&w=500&q=80",
                                        fit: BoxFit.cover,
                                        color: Colors.black.withOpacity(0.3),
                                        colorBlendMode: BlendMode.darken,
                                        placeholder: (context, url) =>
                                            const Center(
                                              child: Icon(
                                                FontAwesomeIcons.image,
                                              ),
                                            ),
                                        errorWidget: (context, url, error) =>
                                            const Icon(FontAwesomeIcons.image),
                                      ),
                                    ),
                                  ),
                                  Center(
                                    child: Text(
                                      offer.name ?? "عرض خاص",
                                      textAlign: TextAlign.center,
                                      style: const TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                  Positioned(
                                    bottom: 10,
                                    right: 10,
                                    child: Text(
                                      "${offer.price} ج.م",
                                      style: const TextStyle(
                                        color: Colors.yellow,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
        ),
        SizedBox(height: 10.h),

        // Indicators
        if (widget.offers.length > 1)
          SmoothPageIndicator(
            controller: _controller,
            count: widget.offers.length,
            effect: ExpandingDotsEffect(
              activeDotColor: AppColor.primaryBlue,
              dotColor: AppColor.lightGrey,
              dotHeight: 6.h,
              dotWidth: 6.w,
              spacing: 5,
            ),
          ),
      ],
    );
  }
}
