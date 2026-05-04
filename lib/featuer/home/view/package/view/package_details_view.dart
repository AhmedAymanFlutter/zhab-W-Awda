import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../core/theme/app_text_style.dart';
import '../data/repo/package_repo.dart';
import '../manager/packages_cubit.dart';
import '../manager/packages_state.dart';
import 'widgets/glass_button.dart';
import 'widgets/package_content_view.dart';
import 'widgets/package_header_image.dart';
import 'widgets/package_branch_card.dart';
import 'widgets/package_booking_panel.dart';
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

    final currentBranch = branches.isNotEmpty ? branches[_selectedBranchIndex] : null;

    return Directionality(
      textDirection: TextDirection.rtl,
      child: Stack(
        children: [
          // 1. Content
          Scaffold(
            backgroundColor: Colors.white,
            body: CustomScrollView(
              slivers: [
                // Header Image
                SliverToBoxAdapter(
                  child: SizedBox(
                    height: 300.h,
                    child: PackageHeaderImage(imageUrl: pkg?.imageCover),
                  ),
                ),

                // Package Info & Branches
                SliverToBoxAdapter(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: EdgeInsets.all(24.w),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              pkg?.name ?? "",
                              style: AppTextStyle.setelMessiriBlack(
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(height: 8.h),
                            Text(
                              pkg?.cities?.map((c) => c.name).join('، ') ?? "",
                              style: TextStyle(
                                fontSize: 14.sp,
                                color: Colors.grey[600],
                              ),
                            ),
                          ],
                        ),
                      ),

                      // Branches List
                      if (branches.isNotEmpty) ...[
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 24.w),
                          child: Text(
                            "اختر الفرع المناسب",
                            style: AppTextStyle.setelMessiriBlack(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        SizedBox(height: 16.h),
                        SizedBox(
                          height: 300.h,
                          child: ListView.separated(
                            scrollDirection: Axis.horizontal,
                            padding: EdgeInsets.symmetric(horizontal: 24.w),
                            itemCount: branches.length,
                            separatorBuilder: (context, index) => SizedBox(width: 16.w),
                            itemBuilder: (context, index) {
                              return PackageBranchCard(
                                branch: branches[index],
                                isSelected: _selectedBranchIndex == index,
                                onTap: () {
                                  setState(() {
                                    _selectedBranchIndex = index;
                                  });
                                },
                              );
                            },
                          ),
                        ),
                        SizedBox(height: 24.h),
                      ],

                      // Branch Details Content
                      PackageContentView(
                        pkg: pkg,
                        branch: currentBranch,
                      ),
                    ],
                  ),
                ),
              ],
            ),
            bottomNavigationBar: PackageBookingPanel(
              price: currentBranch?.price,
              packageName: pkg?.name,
            ),
          ),

          // 2. Overlay Buttons (Back, Rate)
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
        ],
      ),
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
