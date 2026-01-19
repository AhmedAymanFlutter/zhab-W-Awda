import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/core/widgets/offer_booking_bar.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'dart:ui';
import '../../../../../core/theme/app_color.dart';
import '../../../../../core/theme/app_text_style.dart';
import '../data/repo/package_repo.dart';
import '../manager/packages_cubit.dart';
import '../manager/packages_state.dart';
import 'widgets/package_feature_item.dart';
import 'widgets/package_info_chip.dart';
import 'widgets/package_itinerary_item.dart';
import 'widgets/rate_package/rate_package_dialog.dart';
import 'widgets/reviews_section.dart';

class PackageDetailsView extends StatefulWidget {
  final Map<String, dynamic> arguments;

  const PackageDetailsView({super.key, required this.arguments});

  @override
  State<PackageDetailsView> createState() => _PackageDetailsViewState();
}

class _PackageDetailsViewState extends State<PackageDetailsView>
    with TickerProviderStateMixin {
  int _selectedBranchIndex = 0;
  TabController? _tabController;

  @override
  Widget build(BuildContext context) {
    // robust argument extraction
    String? packageSlug;
    String? packageTypeSlug;
    String? packageId;

    if (widget.arguments.containsKey('packageSlug')) {
      packageSlug = widget.arguments['packageSlug'];
      packageTypeSlug = widget.arguments['packageTypeSlug'];
    } else {
      if (widget.arguments.containsKey('packageId')) {
        packageId = widget.arguments['packageId'] as String;
      }
    }

    return BlocProvider(
      create: (context) {
        final cubit = PackagesCubit(PackagesRepository());
        if (packageSlug != null && packageTypeSlug != null) {
          cubit.getPackageDetailsBySlug(
            packageSlug: packageSlug,
            packageTypeSlug: packageTypeSlug,
          );
        } else if (packageId != null) {
          cubit.getPackageDetails(packageId);
        }
        return cubit;
      },
      child: Scaffold(
        backgroundColor: Colors.white,
        bottomNavigationBar: OfferBookingBar(),
        body: BlocBuilder<PackagesCubit, PackagesState>(
          builder: (context, state) {
            if (state is PackageDetailsLoading) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is PackageDetailsError) {
              return Center(child: Text(state.message));
            } else if (state is PackageDetailsSuccess) {
              final packageData = state.package;
              final pkg = packageData.pkg;
              final branches = packageData.branches ?? [];

              // Initialize TabController if branches exist
              if (branches.isNotEmpty &&
                  (_tabController == null ||
                      _tabController!.length != branches.length)) {
                _tabController = TabController(
                  length: branches.length,
                  vsync: this,
                );
                _tabController!.addListener(() {
                  if (_tabController!.indexIsChanging) {
                    setState(() {
                      _selectedBranchIndex = _tabController!.index;
                    });
                  }
                });
              }

              // Fallback current branch data
              final currentBranch = branches.isNotEmpty
                  ? branches[_selectedBranchIndex]
                  : null;

              return CustomScrollView(
                slivers: [
                  // --- 1. AppBar with Image ---
                  SliverAppBar(
                    expandedHeight: 400.h,
                    pinned: true,
                    stretch: true,
                    backgroundColor: Colors.transparent,
                    leading: Container(
                      margin: EdgeInsets.all(8.w),
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.2),
                        shape: BoxShape.circle,
                      ),
                      child: ClipOval(
                        child: BackdropFilter(
                          filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                          child: Container(
                            decoration: BoxDecoration(
                              color: Colors.white.withOpacity(0.2),
                              shape: BoxShape.circle,
                              border: Border.all(
                                color: Colors.white.withOpacity(0.2),
                                width: 1,
                              ),
                            ),
                            child: IconButton(
                              icon: Icon(
                                Icons.arrow_back_ios_new,
                                color: Colors.white,
                                size: 20.sp,
                              ),
                              onPressed: () => Navigator.pop(context),
                              padding: EdgeInsets.zero,
                            ),
                          ),
                        ),
                      ),
                    ),
                    actions: [
                      Container(
                        margin: EdgeInsets.all(8.w),
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.2),
                          shape: BoxShape.circle,
                        ),
                        child: ClipOval(
                          child: BackdropFilter(
                            filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                            child: Container(
                              decoration: BoxDecoration(
                                color: Colors.white.withOpacity(0.2),
                                shape: BoxShape.circle,
                                border: Border.all(
                                  color: Colors.white.withOpacity(0.2),
                                  width: 1,
                                ),
                              ),
                              child: IconButton(
                                icon: Icon(
                                  Icons.star_border,
                                  color: Colors.white,
                                  size: 24.sp,
                                ),
                                onPressed: () {
                                  if (pkg?.sId != null) {
                                    showDialog(
                                      context: context,
                                      builder: (context) => RatePackageDialog(
                                        packageId: pkg!.sId!,
                                      ),
                                    );
                                  } else {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(
                                        content: Text(
                                          "Cannot rate: Package ID not found",
                                        ),
                                      ),
                                    );
                                  }
                                },
                                padding: EdgeInsets.zero,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
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
                                pkg?.imageCover ??
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
                          Positioned(
                            bottom: 20.h,
                            right: 20.w,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  pkg?.name ?? "اسم الباقة",
                                  style:
                                      AppTextStyle.setelMessiriWhite(
                                        fontSize: 22,
                                        fontWeight: FontWeight.bold,
                                      ).copyWith(
                                        shadows: [
                                          BoxShadow(
                                            blurRadius: 10,
                                            color: Colors.black.withOpacity(
                                              0.5,
                                            ),
                                          ),
                                        ],
                                      ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),

                  // --- 2. Branch Tabs ---
                  if (branches.isNotEmpty)
                    SliverPersistentHeader(
                      pinned: true,
                      delegate: _SliverAppBarDelegate(
                        TabBar(
                          controller: _tabController,
                          labelColor: AppColor.primaryBlue,
                          unselectedLabelColor: Colors.grey,
                          indicatorColor: AppColor.primaryBlue,
                          indicatorWeight: 3,
                          labelStyle: AppTextStyle.setelMessiriBlack(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                          ),
                          tabs: branches
                              .map(
                                (b) => Tab(
                                  text:
                                      b.name?.split('-').last.trim() ??
                                      "Branch",
                                ),
                              )
                              .toList(),
                          onTap: (index) {
                            setState(() {
                              _selectedBranchIndex = index;
                            });
                          },
                        ),
                      ),
                    ),

                  // --- 3. Content Body ---
                  SliverToBoxAdapter(
                    child: Padding(
                      padding: EdgeInsets.all(20.w),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Price & Info
                          if (currentBranch != null) ...[
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "${currentBranch.price} ج.م",
                                  style: AppTextStyle.setelMessiriTextStyle(
                                    fontSize: 24,
                                    fontWeight: FontWeight.bold,
                                    color: AppColor.primaryBlue,
                                  ),
                                ),
                                PackageInfoChip(
                                  icon: Icons.nights_stay,
                                  label: "${currentBranch.nightsCount} ليالي",
                                ),
                              ],
                            ),
                            SizedBox(height: 20.h),
                          ],

                          // Description
                          if (pkg?.descText != null) ...[
                            Text(
                              "عن الباقة",
                              style: AppTextStyle.setelMessiriBlack(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(height: 8.h),
                            HtmlWidget(
                              pkg?.description ?? pkg?.descText ?? "",
                              textStyle:
                                  AppTextStyle.setelMessiriSecondlightGrey(
                                    fontSize: 14,
                                    fontWeight: FontWeight.normal,
                                  ).copyWith(height: 1.5),
                            ),
                            SizedBox(height: 20.h),
                          ],

                          // --- Includes ---
                          if (currentBranch?.includes != null &&
                              currentBranch!.includes!.isNotEmpty) ...[
                            Text(
                              "ما تشمله الباقة",
                              style: AppTextStyle.setelMessiriBlack(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(height: 8.h),
                            ...currentBranch.includes!.map(
                              (item) => PackageFeatureItem(
                                text: item,
                                isIncluded: true,
                              ),
                            ),
                            SizedBox(height: 20.h),
                          ],

                          // --- Excludes ---
                          if (currentBranch?.excludes != null &&
                              currentBranch!.excludes!.isNotEmpty) ...[
                            Text(
                              "ما لا تشمله الباقة",
                              style: AppTextStyle.setelMessiriBlack(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(height: 8.h),
                            ...currentBranch.excludes!.map(
                              (item) => PackageFeatureItem(
                                text: item,
                                isIncluded: false,
                              ),
                            ),
                            SizedBox(height: 20.h),
                          ],

                          // Itinerary
                          if (currentBranch?.days != null &&
                              currentBranch!.days!.isNotEmpty) ...[
                            Text(
                              "برنامج الرحلة",
                              style: AppTextStyle.setelMessiriBlack(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(height: 16.h),
                            ...currentBranch.days!.map(
                              (day) => PackageItineraryItem(day: day),
                            ),
                            SizedBox(height: 20.h),
                          ],

                          // --- Reviews Section ---
                          // --- Reviews Section ---
                          Builder(
                            builder: (context) {
                              final slug = packageSlug ?? pkg?.slug;
                              if (slug != null && slug.isNotEmpty) {
                                return ReviewsSection(packageSlug: slug);
                              }
                              return const SizedBox();
                            },
                          ),

                          SizedBox(height: 40.h), // Bottom padding
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
}

class _SliverAppBarDelegate extends SliverPersistentHeaderDelegate {
  final TabBar _tabBar;

  _SliverAppBarDelegate(this._tabBar);

  @override
  double get minExtent => _tabBar.preferredSize.height;
  @override
  double get maxExtent => _tabBar.preferredSize.height;

  @override
  Widget build(
    BuildContext context,
    double shrinkOffset,
    bool overlapsContent,
  ) {
    return Container(color: Colors.white, child: _tabBar);
  }

  @override
  bool shouldRebuild(_SliverAppBarDelegate oldDelegate) {
    return false;
  }
}
