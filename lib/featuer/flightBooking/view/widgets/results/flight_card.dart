import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../data/model/flight_search_model.dart';
import 'components/airline_and_price.dart';
import 'components/flight_path.dart';
import 'components/tags_row.dart';
import 'components/book_now_button.dart';
import 'package:url_launcher/url_launcher.dart';


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
              AirlineAndPrice(itinerary: itinerary),
              SizedBox(height: 20.h),

              // Flight Path
              FlightPath(outbound: outbound),

              Divider(height: 32.h, color: Colors.grey.shade100),

              // Tags and Class
              TagsRow(
                isCheapest: itinerary.isCheapest == true,
                isFastest: itinerary.isFastest == true,
                isBest: itinerary.isBest == true,
                cabinClass: itinerary.cabinClass ?? "",
              ),

              SizedBox(height: 16.h),

              // Book Now Button
              BookNowButton(onPressed: _launchWhatsApp),
            ],
          ),
        ),
      ),
    );
  }
}
