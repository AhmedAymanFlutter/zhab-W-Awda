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
      _showSnackBar("Cannot rate: Package ID not found");
      return;
    }

    showDialog(
      context: context,
      builder: (context) => RatePackageDialog(packageId: packageId),
    );
  }

  void _showSnackBar(String message) {
    if (!mounted) return;
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text(message)));
  }

  @override
  Widget build(BuildContext context) {
    final packageArgs = _extractPackageArguments();

    return BlocProvider(
      create: (context) => _createCubit(packageArgs),
      child: Scaffold(
        backgroundColor: Colors.white,
        bottomNavigationBar: const OfferBookingBar(),
        body: BlocBuilder<PackagesCubit, PackagesState>(
          builder: (context, state) => _buildBody(state, packageArgs),
        ),
      ),
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

  Widget _buildBody(PackagesState state, PackageArguments args) {
    if (state is PackageDetailsLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    if (state is PackageDetailsError) {
      return _buildErrorView(state.message);
    }

    if (state is PackageDetailsSuccess) {
      return _buildSuccessView(state, args);
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

  Widget _buildSuccessView(PackageDetailsSuccess state, PackageArguments args) {
    final packageData = state.package;
    final pkg = packageData.pkg;
    final branches = packageData.branches ?? [];

    if (branches.isNotEmpty) {
      _initializeTabController(branches.length);
    }

    final currentBranch = branches.isNotEmpty
        ? branches[_selectedBranchIndex]
        : null;
    final packageSlug = args.packageSlug ?? pkg?.slug;

    return CustomScrollView(
      slivers: [
        _buildAppBar(pkg),
        if (branches.isNotEmpty) _buildBranchTabs(branches),
        _buildContent(pkg, currentBranch, packageSlug),
      ],
    );
  }

  Widget _buildAppBar(dynamic pkg) {
    return SliverAppBar(
      expandedHeight: 400.h,
      pinned: true,
      stretch: true,
      backgroundColor: Colors.transparent,
      leading: _buildGlassButton(
        icon: Icons.arrow_back_ios_new,
        onPressed: () => Navigator.pop(context),
        iconColor: Colors.black,
      ),
      actions: [
        _buildGlassButton(
          icon: Icons.star_border,
          onPressed: () => _showRateDialog(pkg?.sId),
          iconColor: Colors.white,
        ),
      ],
      flexibleSpace: FlexibleSpaceBar(
        stretchModes: const [
          StretchMode.zoomBackground,
          StretchMode.blurBackground,
        ],
        background: _buildHeaderImage(pkg),
      ),
    );
  }

  Widget _buildGlassButton({
    required IconData icon,
    required VoidCallback onPressed,
    required Color iconColor,
  }) {
    return Container(
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
              icon: Icon(icon, color: iconColor, size: 20.sp),
              onPressed: onPressed,
              padding: EdgeInsets.zero,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildHeaderImage(dynamic pkg) {
    return Stack(
      fit: StackFit.expand,
      children: [
        CachedNetworkImage(
          imageUrl: pkg?.imageCover ?? "https://via.placeholder.com/300",
          fit: BoxFit.cover,
          placeholder: (context, url) =>
              const Center(child: CircularProgressIndicator()),
          errorWidget: (context, url, error) => const Icon(Icons.error),
        ),
        Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [Colors.transparent, Colors.black.withOpacity(0.7)],
            ),
          ),
        ),
        Positioned(
          bottom: 20.h,
          right: 20.w,
          child: Text(
            pkg?.name ?? "اسم الباقة",
            style:
                AppTextStyle.setelMessiriWhite(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ).copyWith(
                  shadows: [
                    BoxShadow(
                      blurRadius: 10,
                      color: Colors.black.withOpacity(0.5),
                    ),
                  ],
                ),
          ),
        ),
      ],
    );
  }

  Widget _buildBranchTabs(List<dynamic> branches) {
    return SliverPersistentHeader(
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
              .map((b) => Tab(text: b.name?.split('-').last.trim() ?? "Branch"))
              .toList(),
          onTap: (index) {
            setState(() {
              _selectedBranchIndex = index;
            });
          },
        ),
      ),
    );
  }

  Widget _buildContent(
    dynamic pkg,
    dynamic currentBranch,
    String? packageSlug,
  ) {
    return SliverToBoxAdapter(
      child: Padding(
        padding: EdgeInsets.all(20.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (currentBranch != null) _buildPriceSection(currentBranch),
            if (pkg?.descText != null) _buildDescriptionSection(pkg),
            if (currentBranch?.includes?.isNotEmpty ?? false)
              _buildIncludesSection(currentBranch),
            if (currentBranch?.excludes?.isNotEmpty ?? false)
              _buildExcludesSection(currentBranch),
            if (currentBranch?.days?.isNotEmpty ?? false)
              _buildItinerarySection(currentBranch),
            if (packageSlug?.isNotEmpty ?? false)
              ReviewsSection(packageSlug: packageSlug!),
            SizedBox(height: 40.h),
          ],
        ),
      ),
    );
  }

  Widget _buildPriceSection(dynamic branch) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "${branch.price} ج.م",
              style: AppTextStyle.setelMessiriTextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: AppColor.primaryBlue,
              ),
            ),
            PackageInfoChip(
              icon: Icons.nights_stay,
              label: "${branch.nightsCount} ليالي",
            ),
          ],
        ),
        SizedBox(height: 20.h),
      ],
    );
  }

  Widget _buildDescriptionSection(dynamic pkg) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "عن الباقة",
          style: AppTextStyle.setelMessiriBlack(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(height: 8.h),
        HtmlWidget(
          pkg.description ?? pkg.descText ?? "",
          textStyle: AppTextStyle.setelMessiriSecondlightGrey(
            fontSize: 14,
            fontWeight: FontWeight.normal,
          ).copyWith(height: 1.5),
        ),
        SizedBox(height: 20.h),
      ],
    );
  }

  Widget _buildIncludesSection(dynamic branch) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "ما تشمله الباقة",
          style: AppTextStyle.setelMessiriBlack(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(height: 8.h),
        ...branch.includes!.map(
          (item) => PackageFeatureItem(text: item, isIncluded: true),
        ),
        SizedBox(height: 20.h),
      ],
    );
  }

  Widget _buildExcludesSection(dynamic branch) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "ما لا تشمله الباقة",
          style: AppTextStyle.setelMessiriBlack(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(height: 8.h),
        ...branch.excludes!.map(
          (item) => PackageFeatureItem(text: item, isIncluded: false),
        ),
        SizedBox(height: 20.h),
      ],
    );
  }

  Widget _buildItinerarySection(dynamic branch) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "برنامج الرحلة",
          style: AppTextStyle.setelMessiriBlack(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(height: 16.h),
        ...branch.days!.map((day) => PackageItineraryItem(day: day)),
        SizedBox(height: 20.h),
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
  bool shouldRebuild(_SliverAppBarDelegate oldDelegate) => false;
}
