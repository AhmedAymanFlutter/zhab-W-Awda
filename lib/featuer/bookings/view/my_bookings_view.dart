import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/network/network_error_manager.dart';
import '../../../../core/widgets/network_retry_wrapper.dart';
import '../../../../core/theme/app_text_style.dart';
import '../manager/bookings_cubit.dart';
import '../manager/bookings_state.dart';
import 'widgets/booking_card.dart';
import 'widgets/bookings_filter_tabs.dart';

class MyBookingsView extends StatefulWidget {
  const MyBookingsView({super.key});

  @override
  State<MyBookingsView> createState() => _MyBookingsViewState();
}

class _MyBookingsViewState extends State<MyBookingsView> {
  bool _isUpcomingActive = true;

  @override
  void initState() {
    super.initState();
    context.read<BookingsCubit>().fetchMyBookings(status: 'not-finished');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF2F4F7),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          "رحلاتي",
          style: AppTextStyle.setelMessiriBlack(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: ValueListenableBuilder<String?>(
        valueListenable: NetworkErrorManager.connectionErrorNotifier,
        builder: (context, errorMessage, child) {
          return NetworkRetryWrapper(
            hasError: errorMessage != null,
            errorMessage: errorMessage,
            onRetry: () async {
              await context.read<BookingsCubit>().fetchMyBookings(
                    status: _isUpcomingActive ? 'not-finished' : 'finished',
                  );
              NetworkErrorManager.clearError();
            },
            child: Column(
              children: [
                SizedBox(height: 24.h),
                BookingsFilterTabs(
                  isUpcomingActive: _isUpcomingActive,
                  onTabChanged: (isUpcoming) {
                    setState(() {
                      _isUpcomingActive = isUpcoming;
                    });
                    context.read<BookingsCubit>().fetchMyBookings(
                          status: isUpcoming ? 'not-finished' : 'finished',
                        );
                  },
                ),
                SizedBox(height: 24.h),
                Expanded(
                  child: BlocBuilder<BookingsCubit, BookingsState>(
                    builder: (context, state) {
                      if (state is BookingsLoading) {
                        return const Center(child: CircularProgressIndicator());
                      } else if (state is BookingsSuccess) {
                        final bookings = state.bookings;

                        if (bookings.isEmpty) {
                          return Center(
                            child: Text(
                              _isUpcomingActive
                                  ? "لا توجد رحلات قادمة"
                                  : "لا توجد رحلات منتهية",
                              style: AppTextStyle.setelMessiriBlack(
                                fontSize: 16,
                                fontWeight: FontWeight.normal,
                              ).copyWith(color: Colors.grey),
                            ),
                          );
                        }

                        return ListView.separated(
                          padding: EdgeInsets.symmetric(horizontal: 16.w),
                          itemCount: bookings.length,
                          separatorBuilder: (_, __) => SizedBox(height: 16.h),
                          itemBuilder: (context, index) {
                            return BookingCard(booking: bookings[index]);
                          },
                        );
                      } else if (state is BookingsError) {
                        return Center(child: Text(state.message));
                      }
                      return const SizedBox();
                    },
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
