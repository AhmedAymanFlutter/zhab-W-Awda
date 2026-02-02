import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../core/theme/app_text_style.dart';
import '../data/repo/package_repo.dart';
import '../manager/packages_cubit.dart';
import '../manager/packages_state.dart';
import 'widgets/booking_bottom_bar.dart';
import 'widgets/glass_button.dart';
import 'widgets/package_branch_tabs.dart';
import 'widgets/package_content_view.dart';
import 'widgets/package_header_image.dart';
import 'widgets/rate_package/rate_package_dialog.dart';

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
  void dispose() {
    _tabController?.dispose();
    super.dispose();
  }

  void _initializeTabController(int branchCount) {
    if (_tabController == null || _tabController!.length != branchCount) {
      _tabController?.dispose();
      _tabController = TabController(length: branchCount, vsync: this);
      _tabController!.addListener(_onTabChange);
    }
  }

  void _onTabChange() {
    if (_tabController!.indexIsChanging) {
      setState(() {
        _selectedBranchIndex = _tabController!.index;
      });
    }
  }

  void _showRateDialog(String? packageId) {
    if (packageId == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Cannot rate: Package ID not found")),
      );
      return;
    }

    showDialog(
      context: context,
      builder: (context) => RatePackageDialog(packageId: packageId),
    );
  }

  PackageArguments _extractPackageArguments() {
    if (widget.arguments.containsKey('packageSlug')) {
      return PackageArguments(
        packageSlug: widget.arguments['packageSlug'] as String?,
        packageTypeSlug: widget.arguments['packageTypeSlug'] as String?,
      );
    }
    return PackageArguments(
      packageId: widget.arguments['packageId'] as String?,
    );
  }

  PackagesCubit _createCubit(PackageArguments args) {
    final cubit = PackagesCubit(PackagesRepository());
    if (args.packageSlug != null && args.packageTypeSlug != null) {
      cubit.getPackageDetailsBySlug(
        packageSlug: args.packageSlug!,
        packageTypeSlug: args.packageTypeSlug!,
      );
    } else if (args.packageId != null) {
      cubit.getPackageDetails(args.packageId!);
    }
    return cubit;
  }

  @override
  Widget build(BuildContext context) {
    final packageArgs = _extractPackageArguments();

    return BlocProvider(
      create: (context) => _createCubit(packageArgs),
      child: Scaffold(
        backgroundColor: Colors.white,
        body: BlocBuilder<PackagesCubit, PackagesState>(
          builder: (context, state) => _buildBody(context, state, packageArgs),
        ),
      ),
    );
  }

  Widget _buildBody(
    BuildContext context,
    PackagesState state,
    PackageArguments args,
  ) {
    if (state is PackageDetailsLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    if (state is PackageDetailsError) {
      return _buildErrorView(state.message);
    }

    if (state is PackageDetailsSuccess) {
      return _buildSuccessView(context, state, args);
    }

    return const SizedBox.shrink();
  }

  Widget _buildErrorView(String message) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.error_outline, size: 64.sp, color: Colors.red),
          SizedBox(height: 16.h),
          Text(
            message,
            style: AppTextStyle.setelMessiriBlack(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget _buildSuccessView(
    BuildContext context,
    PackageDetailsSuccess state,
    PackageArguments args,
  ) {
    final packageData = state.package;
    final pkg = packageData.pkg;
    final branches = packageData.branches ?? [];

    if (branches.isNotEmpty) {
      _initializeTabController(branches.length);
    }

    final _ = branches.isNotEmpty ? branches[_selectedBranchIndex] : null;

    final packageSlug = args.packageSlug ?? pkg?.slug;

    return Stack(
      children: [
        // 1. Header Image
        Positioned(
          top: 0,
          left: 0,
          right: 0,
          height: 0.45.sh,
          child: PackageHeaderImage(imageUrl: pkg?.imageCover),
        ),

        // 2. Back & Favorite/Rate Buttons (SafeArea)
        Positioned(
          top: MediaQuery.of(context).padding.top + 10.h,
          left: 20.w,
          right: 20.w,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              GlassButton(
                icon: Icons.arrow_back_ios_new,
                onPressed: () => Navigator.pop(context),
                iconColor: Colors.white,
              ),
              GlassButton(
                icon: Icons.star_border,
                onPressed: () => _showRateDialog(pkg?.sId),
                iconColor: Colors.white,
              ),
            ],
          ),
        ),

        // 3. Content Sheet
        Positioned.fill(
          top: 0.35.sh,
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.vertical(top: Radius.circular(30.r)),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  blurRadius: 20,
                  offset: const Offset(0, -5),
                ),
              ],
            ),
            child: Column(
              children: [
                SizedBox(height: 12.h),

                // Handle Indicator
                Container(
                  width: 40.w,
                  height: 4.h,
                  decoration: BoxDecoration(
                    color: Colors.grey[300],
                    borderRadius: BorderRadius.circular(2.r),
                  ),
                ),
                SizedBox(height: 20.h),

                // Package Name Header
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 24.w),
                  child: Column(
                    children: [
                      Text(
                        pkg?.name ?? "اسم الباقة غير متوفر",
                        style: AppTextStyle.setelMessiriBlack(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(height: 8.h),
                      // Rating
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(Icons.star, color: Colors.amber, size: 18.sp),
                          SizedBox(width: 4.w),
                          Text(
                            "${pkg?.ratingsAverage ?? 4.5}",
                            style: TextStyle(
                              fontSize: 14.sp,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            " (${pkg?.ratingsQuantity ?? 0} reviews)",
                            style: TextStyle(
                              fontSize: 12.sp,
                              color: Colors.grey,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 24.h),

                // Modern Branch Tabs (Only if branches exist)
                if (branches.isNotEmpty) ...[
                  PackageBranchTabs(
                    branches: branches,
                    tabController: _tabController,
                    onTabChanged: (index) {
                      setState(() {
                        _selectedBranchIndex = index;
                      });
                    },
                  ),
                  Divider(color: Colors.grey[100], thickness: 1, height: 30.h),
                ] else ...[
                  Divider(color: Colors.grey[100], thickness: 1, height: 30.h),
                ],

                // Tab View OR Single Content
                Expanded(
                  child: branches.isNotEmpty
                      ? TabBarView(
                          controller: _tabController,
                          children: branches.map((branch) {
                            return PackageContentView(
                              pkg: pkg,
                              branch: branch,
                              packageSlug: packageSlug,
                            );
                          }).toList(),
                        )
                      : PackageContentView(
                          pkg: pkg,
                          branch: null,
                          packageSlug: packageSlug,
                        ),
                ),

                // Footer Booking Bar
                BookingBottomBar(packageName: pkg?.name ?? "Package"),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

// Helper class for package arguments
class PackageArguments {
  final String? packageSlug;
  final String? packageTypeSlug;
  final String? packageId;

  PackageArguments({this.packageSlug, this.packageTypeSlug, this.packageId});
}
