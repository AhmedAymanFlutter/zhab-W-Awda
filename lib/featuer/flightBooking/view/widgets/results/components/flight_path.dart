import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class FlightPath extends StatelessWidget {
  final dynamic outbound;
  const FlightPath({super.key, required this.outbound});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        _LocationColumn(
          time: outbound?.formattedTimes?['departure'] ?? "",
          code: outbound?.origin?.code ?? "",
          city: outbound?.origin?.city ?? "",
          crossAxisAlignment: CrossAxisAlignment.start,
        ),
        Expanded(
          child: Column(
            children: [
              Text(
                outbound?.totalDuration ?? "",
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
                outbound?.stopsLabel ?? "",
                style: TextStyle(
                  fontSize: 11.sp,
                  color: outbound?.stopsCount == 0 ? Colors.green : Colors.orange,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'ElMessiri',
                ),
              ),
            ],
          ),
        ),
        _LocationColumn(
          time: outbound?.formattedTimes?['arrival'] ?? "",
          code: outbound?.destination?.code ?? "",
          city: outbound?.destination?.city ?? "",
          crossAxisAlignment: CrossAxisAlignment.end,
        ),
      ],
    );
  }
}

class _LocationColumn extends StatelessWidget {
  final String time;
  final String code;
  final String city;
  final CrossAxisAlignment crossAxisAlignment;

  const _LocationColumn({
    required this.time,
    required this.code,
    required this.city,
    required this.crossAxisAlignment,
  });

  @override
  Widget build(BuildContext context) {
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
}
