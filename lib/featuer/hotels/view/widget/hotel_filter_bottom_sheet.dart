import 'package:flutter/material.dart';
import 'package:flutter_application_1/core/theme/app_color.dart';
import 'package:flutter_application_1/core/theme/app_text_style.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';

class HotelFilterBottomSheet extends StatefulWidget {
  final Function(
    String? city,
    String? search,
    String? checkIn,
    String? checkOut,
    int? adults,
    int? children,
  )
  onApply;

  const HotelFilterBottomSheet({super.key, required this.onApply});

  @override
  State<HotelFilterBottomSheet> createState() => _HotelFilterBottomSheetState();
}

class _HotelFilterBottomSheetState extends State<HotelFilterBottomSheet> {
  final TextEditingController _cityController = TextEditingController();
  final TextEditingController _searchController = TextEditingController();
  DateTime? _checkIn;
  DateTime? _checkOut;
  int _adults = 1;
  int _children = 0;

  @override
  void dispose() {
    _cityController.dispose();
    _searchController.dispose();
    super.dispose();
  }

  void _presentDatePicker(bool isCheckIn) {
    showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2030),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: ColorScheme.light(primary: AppColor.primaryBlue),
          ),
          child: child!,
        );
      },
    ).then((pickedDate) {
      if (pickedDate == null) return;
      setState(() {
        if (isCheckIn) {
          _checkIn = pickedDate;
          // Reset checkout if it's before checkin
          if (_checkOut != null && _checkOut!.isBefore(_checkIn!)) {
            _checkOut = null;
          }
        } else {
          _checkOut = pickedDate;
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.fromLTRB(
        20.w,
        20.h,
        20.w,
        20.h + MediaQuery.of(context).viewInsets.bottom,
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(24.r)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(0, -2),
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header
          Center(
            child: Container(
              width: 40.w,
              height: 4.h,
              decoration: BoxDecoration(
                color: Colors.grey[300],
                borderRadius: BorderRadius.circular(2.r),
              ),
            ),
          ),
          SizedBox(height: 20.h),
          Text(
            "تصفية الفنادق",
            style: AppTextStyle.setelMessiriBlack(
              fontSize: 20.sp,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 20.h),

          // Search & City Fields
          _buildTextField("بحث (اسم الفندق)", _searchController, Icons.search),
          SizedBox(height: 12.h),
          _buildTextField("المدينة", _cityController, Icons.location_city),
          SizedBox(height: 16.h),

          // Dates
          Text(
            "التاريخ",
            style: AppTextStyle.setelMessiriBlack(
              fontSize: 16.sp,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 8.h),
          Row(
            children: [
              Expanded(
                child: _buildDateSelector(
                  "تاريخ الوصول",
                  _checkIn,
                  () => _presentDatePicker(true),
                ),
              ),
              SizedBox(width: 12.w),
              Expanded(
                child: _buildDateSelector(
                  "تاريخ المغادرة",
                  _checkOut,
                  () => _presentDatePicker(false),
                ),
              ),
            ],
          ),
          SizedBox(height: 16.h),

          // Guests
          Text(
            "الضيوف",
            style: AppTextStyle.setelMessiriBlack(
              fontSize: 16.sp,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 8.h),
          Row(
            children: [
              Expanded(
                child: _buildCounter(
                  "البالغين",
                  _adults,
                  (val) => setState(() => _adults = val),
                  1,
                ),
              ),
              SizedBox(width: 12.w),
              Expanded(
                child: _buildCounter(
                  "الأطفال",
                  _children,
                  (val) => setState(() => _children = val),
                  0,
                ),
              ),
            ],
          ),
          SizedBox(height: 24.h),

          // Apply Button
          SizedBox(
            width: double.infinity,
            height: 50.h,
            child: ElevatedButton(
              onPressed: () {
                final dateFormat = DateFormat('yyyy-MM-dd');
                widget.onApply(
                  _cityController.text.isEmpty ? null : _cityController.text,
                  _searchController.text.isEmpty
                      ? null
                      : _searchController.text,
                  _checkIn != null ? dateFormat.format(_checkIn!) : null,
                  _checkOut != null ? dateFormat.format(_checkOut!) : null,
                  _adults,
                  _children,
                );
                Navigator.pop(context);
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColor.primaryBlue,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12.r),
                ),
                elevation: 0,
              ),
              child: Text(
                "تطبيق الفلتر",
                style: TextStyle(
                  color: Colors.white,
                  fontFamily: 'elMessiri',
                  fontSize: 16.sp,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTextField(
    String label,
    TextEditingController controller,
    IconData icon,
  ) {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFFF5F6F8),
        borderRadius: BorderRadius.circular(12.r),
      ),
      child: TextField(
        controller: controller,
        style: TextStyle(fontFamily: 'elMessiri', fontSize: 14.sp),
        decoration: InputDecoration(
          hintText: label,
          hintStyle: TextStyle(
            color: Colors.grey[500],
            fontFamily: 'elMessiri',
            fontSize: 14.sp,
          ),
          prefixIcon: Icon(icon, color: Colors.grey[500], size: 20.sp),
          border: InputBorder.none,
          contentPadding: EdgeInsets.symmetric(
            horizontal: 16.w,
            vertical: 14.h,
          ),
        ),
      ),
    );
  }

  Widget _buildDateSelector(String label, DateTime? date, VoidCallback onTap) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12.r),
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 12.h, horizontal: 12.w),
        decoration: BoxDecoration(
          color: const Color(0xFFF5F6F8),
          borderRadius: BorderRadius.circular(12.r),
          border: Border.all(
            color: date != null
                ? AppColor.primaryBlue.withOpacity(0.5)
                : Colors.transparent,
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              label,
              style: TextStyle(
                color: Colors.grey[600],
                fontSize: 10.sp,
                fontFamily: 'elMessiri',
              ),
            ),
            SizedBox(height: 4.h),
            Row(
              children: [
                Icon(
                  Icons.calendar_today_outlined,
                  size: 16.sp,
                  color: AppColor.primaryBlue,
                ),
                SizedBox(width: 8.w),
                Text(
                  date != null
                      ? DateFormat('yyyy/MM/dd').format(date)
                      : "--/--/--",
                  style: TextStyle(
                    fontSize: 12.sp,
                    fontWeight: FontWeight.w600,
                    fontFamily: 'elMessiri',
                    color: Colors.black87,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCounter(
    String label,
    int value,
    Function(int) onChanged,
    int min,
  ) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 8.h, horizontal: 12.w),
      decoration: BoxDecoration(
        color: const Color(0xFFF5F6F8),
        borderRadius: BorderRadius.circular(12.r),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: TextStyle(
                  color: Colors.grey[600],
                  fontSize: 12.sp,
                  fontFamily: 'elMessiri',
                ),
              ),
              Text(
                "$value",
                style: TextStyle(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'elMessiri',
                ),
              ),
            ],
          ),
          Row(
            children: [
              InkWell(
                onTap: () {
                  if (value > min) onChanged(value - 1);
                },
                child: Container(
                  padding: EdgeInsets.all(4.w),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(color: Colors.black12, blurRadius: 2),
                    ],
                  ),
                  child: Icon(Icons.remove, size: 16.sp),
                ),
              ),
              SizedBox(width: 8.w),
              InkWell(
                onTap: () => onChanged(value + 1),
                child: Container(
                  padding: EdgeInsets.all(4.w),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(color: Colors.black12, blurRadius: 2),
                    ],
                  ),
                  child: Icon(Icons.add, size: 16.sp),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
