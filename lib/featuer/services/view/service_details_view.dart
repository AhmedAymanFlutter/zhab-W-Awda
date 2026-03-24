import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/core/widgets/offer_booking_bar.dart';
import 'package:flutter_application_1/featuer/services/manager/services_cubit.dart';
import 'package:flutter_application_1/featuer/services/manager/services_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../../../../core/theme/app_color.dart';
import '../../../../core/theme/app_text_style.dart';
import '../data/repo/services_repository.dart';

class ServiceDetailsView extends StatelessWidget {
  final String serviceId;

  const ServiceDetailsView({super.key, required this.serviceId});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          ServicesCubit(ServicesRepository())..getServiceDetails(serviceId),
      child: Scaffold(
        backgroundColor: Colors.white,
        bottomNavigationBar: const OfferBookingBar(),
        body: BlocBuilder<ServicesCubit, ServicesState>(
          buildWhen: (previous, current) =>
              current is ServiceDetailsLoading ||
              current is ServiceDetailsSuccess ||
              current is ServiceDetailsError,
          builder: (context, state) {
            if (state is ServiceDetailsLoading) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is ServiceDetailsError) {
              return Center(child: Text(state.message));
            } else if (state is ServiceDetailsSuccess) {
              final service = state.service;

              return CustomScrollView(
                slivers: [
                  // --- 1. Immersive AppBar ---
                  SliverAppBar(
                    expandedHeight: 350.h,
                    pinned: true,
                    stretch: true,
                    backgroundColor: Colors.white,
                    leading: Container(
                      margin: EdgeInsets.all(8.w),
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.3),
                        shape: BoxShape.circle,
                      ),
                      child: IconButton(
                        icon: Icon(
                          Icons.arrow_back_ios_new,
                          color: Colors.white,
                          size: 20.sp,
                        ),
                        onPressed: () => Navigator.pop(context),
                      ),
                    ),
                    flexibleSpace: FlexibleSpaceBar(
                      stretchModes: const [
                        StretchMode.zoomBackground,
                        StretchMode.blurBackground,
                      ],
                      background: Stack(
                        fit: StackFit.expand,
                        children: [
                          CachedNetworkImage(
                            imageUrl:
                                service.imageCover ??
                                "https://via.placeholder.com/600x800",
                            fit: BoxFit.cover,
                            placeholder: (context, url) =>
                                Container(color: Colors.grey[100]),
                            errorWidget: (context, url, error) =>
                                const Icon(Icons.error),
                          ),
                          // Subtle gradient for text visibility
                          Container(
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                begin: Alignment.topCenter,
                                end: Alignment.bottomCenter,
                                colors: [
                                  Colors.black.withOpacity(0.3),
                                  Colors.transparent,
                                  Colors.transparent,
                                  Colors.black.withOpacity(0.7),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),

                  // --- 2. Details Content ---
                  SliverToBoxAdapter(
                    child: Container(
                      transform: Matrix4.translationValues(0, -30, 0),
                      padding: EdgeInsets.symmetric(
                        horizontal: 24.w,
                        vertical: 32.h,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.vertical(
                          top: Radius.circular(32.r),
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.05),
                            blurRadius: 20,
                            offset: const Offset(0, -5),
                          ),
                        ],
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Title
                          Text(
                            service.name ?? "عنوان الخدمة",
                            style: AppTextStyle.setelMessiriBlack(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                            ).copyWith(height: 1.2),
                          ),

                          SizedBox(height: 24.h),

                          // Summary Box (if present)
                          if (service.summary != null &&
                              service.summary!.isNotEmpty)
                            Container(
                              padding: EdgeInsets.all(16.w),
                              decoration: BoxDecoration(
                                color: AppColor.primaryBlue.withOpacity(0.05),
                                borderRadius: BorderRadius.circular(16.r),
                                border: Border.all(
                                  color: AppColor.primaryBlue.withOpacity(0.1),
                                ),
                              ),
                              child: Row(
                                children: [
                                  Icon(
                                    Icons.info_outline_rounded,
                                    color: AppColor.primaryBlue,
                                    size: 24.sp,
                                  ),
                                  SizedBox(width: 12.w),
                                  Expanded(
                                    child: Text(
                                      service.summary!,
                                      style: TextStyle(
                                        fontSize: 14.sp,
                                        color: AppColor.primaryBlue,
                                        fontWeight: FontWeight.w600,
                                        height: 1.4,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),

                          if (service.summary != null) SizedBox(height: 32.h),

                          // Description Section
                          _buildSectionTitle("تفاصيل الخدمة"),
                          SizedBox(height: 12.h),
                          Text(
                            service.description ??
                                service.descText ??
                                "لا توجد تفاصيل إضافية.",
                            style: TextStyle(
                              fontSize: 15.sp,
                              color: Colors.grey[700],
                              height: 1.8,
                              fontFamily: 'Tajawal',
                            ),
                          ),

                          SizedBox(height: 32.h),

                          // Method Section (if present)
                          if (service.method != null &&
                              service.method!.isNotEmpty) ...[
                            _buildSectionTitle("طريقة التقديم"),
                            SizedBox(height: 12.h),
                            Container(
                              padding: EdgeInsets.all(20.w),
                              decoration: BoxDecoration(
                                color: Colors.grey[50], // Very light grey
                                borderRadius: BorderRadius.circular(20.r),
                                border: Border.all(color: Colors.grey[200]!),
                              ),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    padding: EdgeInsets.all(10.w),
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      shape: BoxShape.circle,
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.black.withOpacity(0.05),
                                          blurRadius: 10,
                                        ),
                                      ],
                                    ),
                                    child: Icon(
                                      Icons.assignment_turned_in_rounded,
                                      color: AppColor.primaryBlue,
                                      size: 20.sp,
                                    ),
                                  ),
                                  SizedBox(width: 16.w),
                                  Expanded(
                                    child: Text(
                                      service.method!,
                                      style: TextStyle(
                                        fontSize: 14.sp,
                                        color: Colors.black87,
                                        height: 1.6,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],

                          SizedBox(height: 100.h),
                        ],
                      ),
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

  Widget _buildSectionTitle(String title) {
    return Text(
      title,
      style: AppTextStyle.setelMessiriBlack(
        fontSize: 20,
        fontWeight: FontWeight.bold,
      ),
    );
  }
}
