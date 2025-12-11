import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../data/model/get_all_offers_model.dart';

class OfferDetailsAppBar extends StatelessWidget {
  final OfferItem offer;

  const OfferDetailsAppBar({super.key, required this.offer});

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      expandedHeight: 500.h,
      pinned: true,
      stretch: true,
      elevation: 0,
      backgroundColor: Colors.transparent,

      leading: Container(
        decoration: BoxDecoration(
          color: Colors.black.withOpacity(0.35),
          shape: BoxShape.circle,
        ),
        child: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
      ),

      flexibleSpace: FlexibleSpaceBar(
        stretchModes: const [
          StretchMode.zoomBackground,
          StretchMode.blurBackground,
        ],
        background: Padding(
          padding: EdgeInsets.only(left: 12.w, top: 20.h, right: 12.w),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(30.r),
            child: Stack(
              fit: StackFit.expand,
              children: [
                // --- Image ---
                CachedNetworkImage(
                  imageUrl: offer.imageCover?.isNotEmpty == true
                      ? offer.imageCover!
                      : "https://via.placeholder.com/300",
                  fit: BoxFit.cover,
                  placeholder: (context, url) =>
                      const Center(child: CircularProgressIndicator()),
                  errorWidget: (context, url, error) => const Center(
                    child: Icon(Icons.error, color: Colors.white),
                  ),
                ),

                // --- Gradient ---
                Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        Colors.transparent,
                        Colors.black.withOpacity(0.7),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
