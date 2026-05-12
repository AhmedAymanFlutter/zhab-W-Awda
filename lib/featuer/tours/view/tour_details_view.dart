import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../data/repo/tours_repository.dart';
import 'widgets/tour_header_banner.dart';
import 'widgets/tour_details_content_section.dart';
import 'widgets/tour_booking_bottom_bar.dart';
import 'package:flutter_application_1/core/utils/whatsapp_helper.dart';
import 'package:flutter_application_1/featuer/global_setting/manager/settings_cubit.dart';
import 'package:flutter_application_1/featuer/global_setting/manager/settings_state.dart';
import '../manager/tours_cubit.dart';
import '../manager/tours_state.dart';

class TourDetailsView extends StatelessWidget {
  final String tourId;

  const TourDetailsView({super.key, required this.tourId});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          ToursCubit(ToursRepository())..getTourDetails(tourId),
      child: Scaffold(
        backgroundColor: Colors.white,
        body: BlocBuilder<ToursCubit, ToursState>(
          buildWhen: (previous, current) =>
              current is TourDetailsLoading ||
              current is TourDetailsSuccess ||
              current is TourDetailsError,
          builder: (context, state) {
            if (state is TourDetailsLoading) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is TourDetailsError) {
              return Center(child: Text(state.message));
            } else if (state is TourDetailsSuccess) {
              final tour = state.tour;

              return Stack(
                children: [
                  // 1. Full-width Banner Image
                  TourHeaderBanner(tour: tour),

                  // 2. Overlapping Content Card (Scrollable)
                  SingleChildScrollView(
                    child: Column(
                      children: [
                        SizedBox(height: 310.h),
                        TourDetailsContentSection(tour: tour),
                      ],
                    ),
                  ),

                  // 3. Sticky Bottom Booking Bar
                  Positioned(
                    bottom: 0,
                    left: 0,
                    right: 0,
                    child: TourBookingBottomBar(
                      price: tour.price?.amount?.toStringAsFixed(0),
                      oldPrice: ((tour.price?.amount ?? 0) * 1.4)
                          .toStringAsFixed(0),
                      onQuickBookTap: () {
                        _launchWhatsApp(context, tour.title ?? '');
                      },
                      onCheckAvailabilityTap: () {
                        _launchWhatsApp(context, tour.title ?? '');
                      },
                    ),
                  ),

                  // 4. Navigation Buttons (Top Layer to ensure clickability)
                  Positioned(
                    top: 40.h,
                    left: 20.w,
                    right: 20.w,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        // Left buttons: Share & Bookmark
                        Row(
                          children: [
                            _buildCircularButton(Icons.share_outlined, () {}),
                            SizedBox(width: 12.w),
                            _buildCircularButton(Icons.bookmark_border, () {}),
                          ],
                        ),
                        // Right button: Back
                        _buildCircularButton(
                          Icons.arrow_back,
                          () => Navigator.pop(context),
                        ),
                      ],
                    ),
                  ),
                ],
              );
            }
            return const SizedBox();
          },
        ),
      ),
    );
  }

  Widget _buildCircularButton(IconData icon, VoidCallback onTap) {
    return InkWell(
      onTap: onTap,
      child: Container(
        width: 40.h,
        height: 40.h,
        decoration: BoxDecoration(
          color: Colors.black.withOpacity(0.3),
          shape: BoxShape.circle,
        ),
        child: Icon(icon, color: Colors.white, size: 20.sp),
      ),
    );
  }

  void _launchWhatsApp(BuildContext context, String tourTitle) {
    final settingsState = context.read<SettingsCubit>().state;
    String phoneNumber = "+201090124803"; // Default fallback

    if (settingsState is SettingsSuccess) {
      final whatsAppSetting = settingsState.settings.socialMedia?.whatsApp;
      if (whatsAppSetting != null && whatsAppSetting.url != null) {
        // Extract phone from URL or use as is if it's just a number
        phoneNumber = whatsAppSetting.url!.replaceAll(RegExp(r'[^0-9+]'), '');
      }
    }

    WhatsAppHelper.launchWhatsApp(
      phone: phoneNumber,
      message: "مرحباً، أود الاستفسار عن جولة: $tourTitle",
    );
  }
}
