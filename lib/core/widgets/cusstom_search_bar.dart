import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ReusableSearchBar extends StatefulWidget {
  final Function(String) onSearchChanged;
  final VoidCallback? onFilterTap;
  final String hintText;
  final bool useDebounce;

  const ReusableSearchBar({
    super.key,
    required this.onSearchChanged,
    this.onFilterTap,
    this.hintText = "Search...",
    this.useDebounce = true,
  });

  @override
  State<ReusableSearchBar> createState() => _ReusableSearchBarState();
}

class _ReusableSearchBarState extends State<ReusableSearchBar> {
  final TextEditingController _controller = TextEditingController();
  Timer? _debounce;

  @override
  void initState() {
    super.initState();
    _controller.addListener(() {
      setState(() {});
    });
  }

  @override
  void dispose() {
    _debounce?.cancel();
    _controller.dispose();
    super.dispose();
  }

  void _onChanged(String value) {
    if (widget.useDebounce) {
      if (_debounce?.isActive ?? false) _debounce!.cancel();
      _debounce = Timer(const Duration(milliseconds: 500), () {
        widget.onSearchChanged(value);
      });
    } else {
      widget.onSearchChanged(value);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        // 1. Search Bar (Takes most of the space)
        Expanded(
          child: Container(
            height: 50.h,
            padding: EdgeInsets.symmetric(horizontal: 16.w),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20.r),
              border: Border.all(color: const Color(0xFFEAE9EB), width: 1.5),
            ),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _controller,
                    onChanged: _onChanged,
                    textAlign: TextAlign.right,
                    style: TextStyle(fontFamily: 'ElMessiri', fontSize: 14.sp),
                    decoration: InputDecoration(
                      hintText: widget.hintText,
                      border: InputBorder.none,
                      isDense: true,
                      hintStyle: TextStyle(
                        color: Colors.grey[400],
                        fontFamily: 'ElMessiri',
                        fontSize: 14.sp,
                      ),
                    ),
                  ),
                ),
                SizedBox(width: 8.w),
                Icon(Icons.search, color: Colors.grey[400], size: 24.sp),
              ],
            ),
          ),
        ),

        // 2. Vertical Divider
        if (widget.onFilterTap != null)
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 8.w),
            child: Container(
              height: 24.h,
              width: 1.5,
              color: const Color(0xFFEAE9EB),
            ),
          ),

        // 3. Filter/Sort Button
        if (widget.onFilterTap != null)
          InkWell(
            onTap: widget.onFilterTap,
            child: Container(
              height: 50.h,
              padding: EdgeInsets.symmetric(horizontal: 12.w),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12.r),
                border: Border.all(color: const Color(0xFFEAE9EB), width: 1.5),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    "تصنيف",
                    style: TextStyle(
                      fontFamily: 'ElMessiri',
                      color: Colors.black87,
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  SizedBox(width: 8.w),
                  Icon(
                    Icons.tune, // Matches the icon in the image
                    size: 20.sp,
                    color: Colors.black87,
                  ),
                ],
              ),
            ),
          ),
      ],
    );
  }
}
