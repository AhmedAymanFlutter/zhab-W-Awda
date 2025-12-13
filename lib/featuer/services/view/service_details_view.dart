import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/core/widgets/offer_booking_bar.dart';
import 'package:flutter_application_1/featuer/services/manager/services_cubit.dart';
import 'package:flutter_application_1/featuer/services/manager/services_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../../../../core/theme/app_color.dart';
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
        bottomNavigationBar: OfferBookingBar(),
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
                  // --- 1. AppBar Image ---
                  SliverAppBar(
                    expandedHeight: 300.h,
                    pinned: true,
                    stretch: true,
                    backgroundColor: AppColor.primaryBlue,
                    leading: Container(
                      margin: EdgeInsets.all(8.w),
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.3),
                        shape: BoxShape.circle,
                      ),
                      child: IconButton(
                        icon: const Icon(Icons.arrow_back, color: Colors.white),
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
                                "https://via.placeholder.com/300",
                            fit: BoxFit.cover,
                            placeholder: (context, url) => const Center(
                              child: Center(
                                child: Icon(FontAwesomeIcons.image, size: 32),
                              ),
                            ),
                            errorWidget: (context, url, error) =>
                                const Icon(Icons.error),
                          ),
                          Container(
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                begin: Alignment.topCenter,
                                end: Alignment.bottomCenter,
                                colors: [
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
                      transform: Matrix4.translationValues(0, -20, 0),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(30.r),
                          topRight: Radius.circular(30.r),
                        ),
                      ),
                      child: Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: 20.w,
                          vertical: 25.h,
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // Title
                            Text(
                              service.name ?? "اسم الخدمة",
                              style: TextStyle(
                                fontSize: 22.sp,
                                fontWeight: FontWeight.bold,
                                color: Colors.black87,
                              ),
                            ),
                            SizedBox(height: 25.h),

                            // Summary (if available)
                            if (service.summary != null) ...[
                              Container(
                                padding: EdgeInsets.all(12.w),
                                decoration: BoxDecoration(
                                  color: AppColor.primaryBlue.withOpacity(0.05),
                                  borderRadius: BorderRadius.circular(12.r),
                                  border: Border.all(
                                    color: AppColor.primaryBlue.withOpacity(
                                      0.1,
                                    ),
                                  ),
                                ),
                                child: Text(
                                  service.summary!,
                                  style: TextStyle(
                                    fontSize: 14.sp,
                                    color: AppColor.primaryBlue,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                              SizedBox(height: 25.h),
                            ],

                            // Description Title
                            Text(
                              "تفاصيل الخدمة",
                              style: TextStyle(
                                fontSize: 18.sp,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(height: 10.h),
                            Text(
                              service.description ??
                                  service.descText ??
                                  "لا يوجد تفاصيل متاحة.",
                              style: TextStyle(
                                fontSize: 14.sp,
                                color: Colors.grey[600],
                                height: 1.6,
                              ),
                            ),

                            SizedBox(height: 20.h),

                            // Method (if available)
                            if (service.method != null) ...[
                              Text(
                                "طريقة التقديم",
                                style: TextStyle(
                                  fontSize: 18.sp,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              SizedBox(height: 10.h),
                              Text(
                                service.method!,
                                style: TextStyle(
                                  fontSize: 14.sp,
                                  color: Colors.grey[600],
                                  height: 1.6,
                                ),
                              ),
                            ],

                            SizedBox(height: 80.h),
                          ],
                        ),
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
}
