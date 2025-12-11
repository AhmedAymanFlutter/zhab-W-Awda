import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/featuer/tours/manager/tours_cubit.dart';
import 'package:flutter_application_1/featuer/tours/manager/tours_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/theme/app_color.dart';
import '../data/repo/tours_repository.dart';

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
        bottomNavigationBar: _buildBottomBookingBar(),
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

              return CustomScrollView(
                slivers: [
                  // --- 1. AppBar Image ---
                  SliverAppBar(
                    expandedHeight: 500.h,
                    pinned: true,
                    stretch: true,
                    backgroundColor: Colors.transparent,
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
                      background: Padding(
                        padding: EdgeInsets.only(
                          left: 12.w,
                          top: 20.h,
                          right: 12.w,
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.all(Radius.circular(30.r)),
                          child: Stack(
                            fit: StackFit.expand,
                            children: [
                              CachedNetworkImage(
                                imageUrl:
                                    tour.imageCover ??
                                    "https://via.placeholder.com/300",
                                fit: BoxFit.cover,
                                placeholder: (context, url) => const Center(
                                  child: CircularProgressIndicator(),
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
                              tour.title ?? "عنوان الجولة",
                              style: TextStyle(
                                fontSize: 22.sp,
                                fontWeight: FontWeight.bold,
                                color: Colors.black87,
                              ),
                            ),
                            SizedBox(height: 8.h),

                            // Location
                            SizedBox(height: 20.h),

                            // Stats Row (Days, People, Type)
                            if (tour.header != null)
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  _buildInfoChip(
                                    Icons.calendar_today,
                                    "${tour.header!.days ?? 0} أيام",
                                  ),
                                  _buildInfoChip(
                                    Icons.people,
                                    "${tour.header!.people ?? 0} أفراد",
                                  ),
                                  _buildInfoChip(
                                    Icons.category,
                                    tour.header!.type ?? "عام",
                                  ),
                                ],
                              ),

                            SizedBox(height: 25.h),
                            Divider(color: Colors.grey.withOpacity(0.2)),
                            SizedBox(height: 15.h),

                            // Description
                            Text(
                              "عن الجولة",
                              style: TextStyle(
                                fontSize: 18.sp,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(height: 10.h),
                            Text(
                              tour.description ??
                                  tour.descText ??
                                  "لا يوجد وصف متاح.",
                              style: TextStyle(
                                fontSize: 14.sp,
                                color: Colors.grey[600],
                                height: 1.6,
                              ),
                            ),
                            SizedBox(height: 20.h),

                            // Program (Paths)
                            if (tour.paths != null &&
                                tour.paths!.isNotEmpty) ...[
                              Text(
                                "برنامج الرحلة",
                                style: TextStyle(
                                  fontSize: 18.sp,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              SizedBox(height: 10.h),
                              ...tour.paths!.map(
                                (path) => _buildPathItem(path),
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

  Widget _buildInfoChip(IconData icon, String label) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 8.h),
      decoration: BoxDecoration(
        color: AppColor.primaryBlue.withOpacity(0.05),
        borderRadius: BorderRadius.circular(10.r),
        border: Border.all(color: AppColor.primaryBlue.withOpacity(0.1)),
      ),
      child: Row(
        children: [
          Icon(icon, color: AppColor.primaryBlue, size: 16.sp),
          SizedBox(width: 6.w),
          Text(
            label,
            style: TextStyle(
              fontSize: 11.sp,
              fontWeight: FontWeight.w600,
              color: AppColor.primaryBlue,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPathItem(dynamic path) {
    return Padding(
      padding: EdgeInsets.only(bottom: 12.h),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(Icons.circle, size: 10.sp, color: AppColor.primaryBlue),
          SizedBox(width: 10.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  path.title ?? "",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 14.sp,
                  ),
                ),
                if (path.description != null)
                  Text(
                    path.description!,
                    style: TextStyle(color: Colors.grey[600], fontSize: 12.sp),
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBottomBookingBar() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 15.h),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, -5),
          ),
        ],
      ),
      child: SafeArea(
        child: ElevatedButton(
          onPressed: () {},
          style: ElevatedButton.styleFrom(
            backgroundColor: AppColor.primaryBlue,
            padding: EdgeInsets.symmetric(vertical: 15.h),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16.r),
            ),
          ),
          child: Text(
            "احجز الآن",
            style: TextStyle(color: Colors.white, fontSize: 16.sp),
          ),
        ),
      ),
    );
  }
}
