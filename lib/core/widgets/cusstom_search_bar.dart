import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

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
  bool _showClearButton = false;

  @override
  void initState() {
    super.initState();
    _controller.addListener(() {
      setState(() {
        _showClearButton = _controller.text.isNotEmpty;
      });
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
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      decoration: BoxDecoration(
        color: Colors.grey[200], // Background color
        borderRadius: BorderRadius.circular(12.0),
      ),
      child: Row(
        children: [
          Icon(FontAwesomeIcons.search, size: 16.sp),
          const SizedBox(width: 8),
          Expanded(
            child: TextField(
              controller: _controller,
              onChanged: _onChanged,
              decoration: InputDecoration(
                hintText: widget.hintText,
                border: InputBorder.none,
                isDense: true,
                hintStyle: TextStyle(color: Colors.grey[500]),
              ),
            ),
          ),
          // Clear Button (only shows when text exists)
          if (_showClearButton)
            GestureDetector(
              onTap: () {
                _controller.clear();
                _onChanged(''); // Reset search
              },
              child: Icon(Icons.close, color: Colors.grey[600]),
            ),

          // Optional Filter Button
          if (widget.onFilterTap != null) ...[
            const SizedBox(width: 8),
            Container(
              height: 24,
              width: 1,
              color: Colors.grey[400], // Divider
            ),
            const SizedBox(width: 8),
            InkWell(
              onTap: widget.onFilterTap,
              child: Icon(
                FontAwesomeIcons.filter,
                size: 16.sp,
                color: Theme.of(context).primaryColor,
              ),
            ),
          ],
        ],
      ),
    );
  }
}
