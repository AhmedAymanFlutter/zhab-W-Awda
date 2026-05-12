import 'package:flutter/material.dart';
import 'package:flutter_application_1/featuer/flightBooking/view/widgets/results/flight_card.dart';
import 'package:flutter_application_1/featuer/flightBooking/data/model/flight_search_model.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class FlightResultsView extends StatelessWidget {
  final List<FlightItinerary> itineraries;
  final String fromCity;
  final String toCity;

  const FlightResultsView({
    super.key,
    required this.itineraries,
    required this.fromCity,
    required this.toCity,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FB),
      appBar: AppBar(
        backgroundColor: const Color(0xFF00276C),
        elevation: 0,
        centerTitle: true,
        iconTheme: const IconThemeData(color: Colors.white),
        title: Column(
          children: [
            Text(
              "$fromCity إلى $toCity",
              style: TextStyle(
                fontSize: 16.sp,
                fontWeight: FontWeight.bold,
                color: Colors.white,
                fontFamily: 'ElMessiri',
              ),
            ),
            Text(
              "${itineraries.length} رحلة متوفرة",
              style: TextStyle(
                fontSize: 12.sp,
                color: Colors.white70,
                fontFamily: 'ElMessiri',
              ),
            ),
          ],
        ),
      ),
      body: Column(
        children: [
          // Filter Header (Optional, could be added later)
          Container(
            padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
            color: Colors.white,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Icon(
                      Icons.filter_list,
                      size: 18.sp,
                      color: const Color(0xFF00276C),
                    ),
                    SizedBox(width: 8.w),
                    Text(
                      "تصفية",
                      style: TextStyle(
                        fontSize: 14.sp,
                        fontFamily: 'ElMessiri',
                        color: const Color(0xFF00276C),
                      ),
                    ),
                  ],
                ),
                Text(
                  "ترتيب حسب: الأفضل",
                  style: TextStyle(
                    fontSize: 14.sp,
                    fontFamily: 'ElMessiri',
                    color: Colors.grey,
                  ),
                ),
              ],
            ),
          ),

          Expanded(
            child: ListView.builder(
              padding: EdgeInsets.all(16.w),
              itemCount: itineraries.length,
              itemBuilder: (context, index) {
                return FlightCard(
                  itinerary: itineraries[index],
                  onTap: () {
                    // Navigate to details if needed
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
