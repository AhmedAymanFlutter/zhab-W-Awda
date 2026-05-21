import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../../../../data/model/flight_search_model.dart';

class AirlineAndPrice extends StatelessWidget {
  final FlightItinerary itinerary;
  const AirlineAndPrice({super.key, required this.itinerary});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: Row(
            children: [
              if (itinerary.airline?.logo != null)
                CachedNetworkImage(
                  imageUrl: itinerary.airline!.logo!,
                  width: 32.w,
                  height: 32.w,
                  placeholder: (context, url) => const CircularProgressIndicator(),
                  errorWidget: (context, url, error) => Icon(Icons.flight, size: 24.sp),
                ),
              SizedBox(width: 8.w),
              Expanded(
                child: Text(
                  itinerary.airline?.name ?? "",
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1,
                  style: TextStyle(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'ElMessiri',
                  ),
                ),
              ),
            ],
          ),
        ),
        SizedBox(width: 8.w),
        Flexible(
          fit: FlexFit.loose,
          child: Text(
            "${itinerary.totalPrice} ${itinerary.currencyCode}",
            overflow: TextOverflow.ellipsis,
            maxLines: 1,
            textAlign: TextAlign.end,
            style: TextStyle(
              fontSize: 16.sp,
              fontWeight: FontWeight.w900,
              color: const Color(0xFF00276C),
              fontFamily: 'ElMessiri',
            ),
          ),
        ),
      ],
    );
  }
}
