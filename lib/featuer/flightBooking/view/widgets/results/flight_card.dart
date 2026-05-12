import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../data/model/flight_search_model.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter_svg/flutter_svg.dart';

class FlightCard extends StatelessWidget {
  final FlightItinerary itinerary;
  final VoidCallback onTap;

  const FlightCard({super.key, required this.itinerary, required this.onTap});

  Future<void> _launchWhatsApp() async {
    final outbound = itinerary.outbound;
    if (outbound == null) return;

    final message =
        '''
مرحباً ذهاب وعودة، أود استفسار عن حجز رحلة طيران:
الشركة: ${itinerary.airline?.name ?? ""}
من: ${outbound.origin?.city ?? ""} (${outbound.origin?.code ?? ""})
إلى: ${outbound.destination?.city ?? ""} (${outbound.destination?.code ?? ""})
الموعد: ${outbound.formattedTimes?['departure'] ?? ""}
السعر: ${itinerary.totalPrice} ${itinerary.currencyCode}
الدرجة: ${itinerary.cabinClass ?? ""}
''';

    final url =
        "https://wa.me/201091544321?text=${Uri.encodeComponent(message)}";
    if (await canLaunchUrl(Uri.parse(url))) {
      await launchUrl(Uri.parse(url), mode: LaunchMode.externalApplication);
    }
  }

  @override
  Widget build(BuildContext context) {
    final outbound = itinerary.outbound;
    if (outbound == null) return const SizedBox.shrink();

    return Container(
      margin: EdgeInsets.only(bottom: 16.h),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(16.r),
        child: Padding(
          padding: EdgeInsets.all(16.w),
          child: Column(
            children: [
              // Airline and Price
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      if (itinerary.airline?.logo != null)
                        CachedNetworkImage(
                          imageUrl: itinerary.airline!.logo!,
                          width: 32.w,
                          height: 32.w,
                          placeholder: (context, url) =>
                              const CircularProgressIndicator(),
                          errorWidget: (context, url, error) =>
                              Icon(Icons.flight, size: 24.sp),
                        ),
                      SizedBox(width: 8.w),
                      Text(
                        itinerary.airline?.name ?? "",
                        style: TextStyle(
                          fontSize: 14.sp,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'ElMessiri',
                        ),
                      ),
                    ],
                  ),
                  Text(
                    "${itinerary.totalPrice} ${itinerary.currencyCode}",
                    style: TextStyle(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w900,
                      color: const Color(0xFF00276C),
                      fontFamily: 'ElMessiri',
                    ),
                  ),
                ],
              ),
              SizedBox(height: 20.h),

              // Flight Path
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _buildLocation(
                    outbound.origin?.code ?? "",
                    outbound.origin?.city ?? "",
                    outbound.formattedTimes?['departure'] ?? "",
                    CrossAxisAlignment.start,
                  ),
                  Expanded(
                    child: Column(
                      children: [
                        Text(
                          outbound.totalDuration ?? "",
                          style: TextStyle(
                            fontSize: 12.sp,
                            color: Colors.grey,
                            fontFamily: 'ElMessiri',
                          ),
                        ),
                        SizedBox(height: 4.h),
                        Row(
                          children: [
                            Container(
                              width: 8.w,
                              height: 8.w,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                border: Border.all(
                                  color: const Color(0xFF00276C),
                                ),
                              ),
                            ),
                            Expanded(
                              child: Container(
                                height: 1,
                                color: Colors.grey.shade300,
                              ),
                            ),
                            Icon(
                              Icons.flight_takeoff,
                              size: 16.sp,
                              color: const Color(0xFF00276C),
                            ),
                            Expanded(
                              child: Container(
                                height: 1,
                                color: Colors.grey.shade300,
                              ),
                            ),
                            Container(
                              width: 8.w,
                              height: 8.w,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: const Color(0xFF00276C),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 4.h),
                        Text(
                          outbound.stopsLabel ?? "",
                          style: TextStyle(
                            fontSize: 11.sp,
                            color: outbound.stopsCount == 0
                                ? Colors.green
                                : Colors.orange,
                            fontWeight: FontWeight.bold,
                            fontFamily: 'ElMessiri',
                          ),
                        ),
                      ],
                    ),
                  ),
                  _buildLocation(
                    outbound.destination?.code ?? "",
                    outbound.destination?.city ?? "",
                    outbound.formattedTimes?['arrival'] ?? "",
                    CrossAxisAlignment.end,
                  ),
                ],
              ),

              Divider(height: 32.h, color: Colors.grey.shade100),

              // Tags and Class
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      if (itinerary.isCheapest == true)
                        _buildTag("الأرخص", Colors.green),
                      if (itinerary.isFastest == true)
                        _buildTag("الأسرع", Colors.blue),
                      if (itinerary.isBest == true)
                        _buildTag("الأفضل", Colors.orange),
                    ],
                  ),
                  Text(
                    itinerary.cabinClass ?? "",
                    style: TextStyle(
                      fontSize: 12.sp,
                      color: Colors.grey.shade600,
                      fontFamily: 'ElMessiri',
                    ),
                  ),
                ],
              ),

              SizedBox(height: 16.h),

              // Book Now Button
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: _launchWhatsApp,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF00276C),
                    foregroundColor: Colors.white,
                    padding: EdgeInsets.symmetric(vertical: 12.h),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12.r),
                    ),
                    elevation: 0,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SvgPicture.asset(
                        'assets/icon/whatsapp.svg',
                        width: 20.w,
                        height: 20.w,
                      ),
                      SizedBox(width: 8.w),
                      Text(
                        "احجز الآن",
                        style: TextStyle(
                          fontSize: 14.sp,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'ElMessiri',
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildLocation(
    String code,
    String city,
    String time,
    CrossAxisAlignment crossAxisAlignment,
  ) {
    return Column(
      crossAxisAlignment: crossAxisAlignment,
      children: [
        Text(
          time,
          style: TextStyle(
            fontSize: 18.sp,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
        Text(
          code,
          style: TextStyle(
            fontSize: 14.sp,
            fontWeight: FontWeight.w900,
            color: const Color(0xFF00276C),
          ),
        ),
        Text(
          city,
          style: TextStyle(
            fontSize: 12.sp,
            color: Colors.grey,
            fontFamily: 'ElMessiri',
          ),
        ),
      ],
    );
  }

  Widget _buildTag(String label, Color color) {
    return Container(
      margin: EdgeInsets.only(left: 8.w),
      padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(4.r),
      ),
      child: Text(
        label,
        style: TextStyle(
          fontSize: 10.sp,
          color: color,
          fontWeight: FontWeight.bold,
          fontFamily: 'ElMessiri',
        ),
      ),
    );
  }
}
