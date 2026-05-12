import 'package:flutter/material.dart';
import 'package:flutter_application_1/featuer/flightBooking/data/model/flight_destination_model.dart';
import 'package:flutter_application_1/featuer/flightBooking/manager/book_flight_cubit.dart';
import 'package:flutter_application_1/featuer/flightBooking/manager/book_flight_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'custom_flight_input.dart';

class DestinationSearchInput extends StatefulWidget {
  final String label;
  final IconData labelIcon;
  final String hint;
  final TextEditingController controller;
  final bool isFromCity;

  const DestinationSearchInput({
    super.key,
    required this.label,
    required this.labelIcon,
    required this.hint,
    required this.controller,
    required this.isFromCity,
  });

  @override
  State<DestinationSearchInput> createState() => _DestinationSearchInputState();
}

class _DestinationSearchInputState extends State<DestinationSearchInput> {
  final LayerLink _layerLink = LayerLink();
  final FocusNode _focusNode = FocusNode();
  OverlayEntry? _overlayEntry;
  bool _isSearching = false;

  @override
  void initState() {
    super.initState();
    _focusNode.addListener(() {
      if (!_focusNode.hasFocus) {
        _removeOverlay();
      }
    });
  }

  void _showOverlay(List<FlightDestination> results) {
    _removeOverlay();
    if (results.isEmpty && widget.controller.text.length < 2) return;
    _overlayEntry = _createOverlayEntry(results);
    Overlay.of(context).insert(_overlayEntry!);
  }

  void _removeOverlay() {
    _overlayEntry?.remove();
    _overlayEntry = null;
  }

  OverlayEntry _createOverlayEntry(List<FlightDestination> results) {
    RenderBox renderBox = context.findRenderObject() as RenderBox;
    var size = renderBox.size;
    // Capture the cubit here
    final cubit = context.read<BookFlightCubit>();

    return OverlayEntry(
      builder: (overlayContext) => Positioned(
        width: size.width,
        child: CompositedTransformFollower(
          link: _layerLink,
          showWhenUnlinked: false,
          offset: Offset(0, size.height + 5.h),
          child: Material(
            elevation: 4,
            borderRadius: BorderRadius.circular(8.r),
            color: Colors.white,
            child: Container(
              constraints: BoxConstraints(maxHeight: 250.h),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8.r),
                border: Border.all(color: Colors.grey.shade200),
              ),
              child: results.isEmpty
                  ? Padding(
                      padding: EdgeInsets.all(12.w),
                      child: Text(
                        "لا توجد نتائج",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 12.sp,
                          color: Colors.grey,
                          fontFamily: 'ElMessiri',
                        ),
                      ),
                    )
                  : ListView.separated(
                      padding: EdgeInsets.zero,
                      shrinkWrap: true,
                      itemCount: results.length,
                      separatorBuilder: (context, index) =>
                          Divider(height: 1.h, color: Colors.grey.shade100),
                      itemBuilder: (context, index) {
                        final destination = results[index];
                        return ListTile(
                          dense: true,
                          title: Text(
                            destination.name ?? "",
                            style: TextStyle(
                              fontSize: 13.sp,
                              fontWeight: FontWeight.bold,
                              fontFamily: 'ElMessiri',
                            ),
                            textDirection: TextDirection.rtl,
                          ),
                          subtitle: Text(
                            "${destination.cityName}, ${destination.countryName}",
                            style: TextStyle(
                              fontSize: 11.sp,
                              color: Colors.grey,
                              fontFamily: 'ElMessiri',
                            ),
                            textDirection: TextDirection.rtl,
                          ),
                          leading: destination.photo != null
                              ? ClipRRect(
                                  borderRadius: BorderRadius.circular(4.r),
                                  child: Image.network(
                                    destination.photo!,
                                    width: 40.w,
                                    height: 40.h,
                                    fit: BoxFit.cover,
                                    errorBuilder:
                                        (context, error, stackTrace) =>
                                            Icon(Icons.flight, size: 20.sp),
                                  ),
                                )
                              : Icon(Icons.flight, size: 20.sp),
                          onTap: () {
                            widget.controller.text = destination.name ?? "";
                            if (widget.isFromCity) {
                              cubit.fromId = destination.id;
                            } else {
                              cubit.toId = destination.id;
                            }
                            _removeOverlay();
                            _focusNode.unfocus();
                          },
                        );
                      },
                    ),
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<BookFlightCubit, BookFlightState>(
      listener: (context, state) {
        if (state is BookFlightSearchSuccess &&
            state.isFromCity == widget.isFromCity) {
          if (_isSearching && _focusNode.hasFocus) {
            _showOverlay(state.results);
          }
        }
      },
      child: CompositedTransformTarget(
        link: _layerLink,
        child: Focus(
          focusNode: _focusNode,
          child: CustomFlightInput(
            label: widget.label,
            labelIcon: widget.labelIcon,
            hint: widget.hint,
            controller: widget.controller,
            onChanged: (value) {
              final cubit = context.read<BookFlightCubit>();
              if (widget.isFromCity) {
                cubit.fromId = null;
              } else {
                cubit.toId = null;
              }

              if (value.length > 1) {
                _isSearching = true;
                cubit.searchDestinations(
                  value,
                  widget.isFromCity,
                );
              } else {
                _isSearching = false;
                _removeOverlay();
              }
            },
            trailing: _isSearching
                ? BlocBuilder<BookFlightCubit, BookFlightState>(
                    builder: (context, state) {
                      if (state is BookFlightSearchLoading) {
                        return SizedBox(
                          width: 15.w,
                          height: 15.w,
                          child: const CircularProgressIndicator(
                            strokeWidth: 2,
                          ),
                        );
                      }
                      return Icon(
                        Icons.keyboard_arrow_down,
                        color: Colors.grey,
                        size: 18.sp,
                      );
                    },
                  )
                : Icon(
                    Icons.keyboard_arrow_down,
                    color: Colors.grey,
                    size: 18.sp,
                  ),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _removeOverlay();
    _focusNode.dispose();
    super.dispose();
  }
}
