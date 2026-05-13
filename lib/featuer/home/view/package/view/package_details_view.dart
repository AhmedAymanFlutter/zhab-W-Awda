import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../core/theme/app_text_style.dart';
import '../../../../../core/theme/app_color.dart';
import '../data/repo/package_repo.dart';
import '../manager/packages_cubit.dart';
import '../manager/packages_state.dart';
import 'widgets/package_content_view.dart';
import 'widgets/package_header_image.dart';
import 'widgets/package_branch_card.dart';
import 'widgets/package_booking_panel.dart';

class PackageDetailsView extends StatefulWidget {
  final Map<String, dynamic> arguments;

  const PackageDetailsView({super.key, required this.arguments});

  @override
  State<PackageDetailsView> createState() => _PackageDetailsViewState();
}

class _PackageDetailsViewState extends State<PackageDetailsView> {
  int _selectedBranchIndex = 0;

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
        backgroundColor: AppColor.primaryWhite,
        body: BlocBuilder<PackagesCubit, PackagesState>(
          builder: (context, state) {
            if (state is PackageDetailsLoading) {
              return const Center(child: CircularProgressIndicator());
            }

            if (state is PackageDetailsError) {
              return _buildErrorView(state.message);
            }

            if (state is PackageDetailsSuccess) {
              return _buildSuccessView(context, state.package);
            }

            return const SizedBox.shrink();
          },
        ),
      ),
    );
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

  Widget _buildSuccessView(BuildContext context, dynamic packageData) {
    final pkg = packageData.pkg;
    final branches = packageData.branches ?? [];
    final currentBranch = branches.isNotEmpty ? branches[_selectedBranchIndex] : null;

    return Directionality(
      textDirection: TextDirection.rtl,
      child: Stack(
        children: [
          Column(
            children: [
              _buildAppBar(context),
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      SizedBox(height: 16.h),
                      PackageHeaderImage(
                        imageUrl: pkg?.imageCover,
                        rating: pkg?.ratingsAverage,
                      ),
                      SizedBox(height: 24.h),
                      _buildPackageInfo(pkg),
                      SizedBox(height: 24.h),
                      
                      // Branches
                      if (branches.isNotEmpty) ...[
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 24.w),
                          child: Align(
                            alignment: Alignment.centerRight,
                            child: Text(
                              "الباقات المتاحة",
                              style: AppTextStyle.setelMessiriBlack(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                        SizedBox(height: 12.h),
                        SizedBox(
                          height: 360.h,
                          child: ListView.separated(
                            scrollDirection: Axis.horizontal,
                            padding: EdgeInsets.symmetric(horizontal: 24.w),
                            itemCount: branches.length,
                            separatorBuilder: (_, __) => SizedBox(width: 16.w),
                            itemBuilder: (context, index) => PackageBranchCard(
                              branch: branches[index],
                              isSelected: _selectedBranchIndex == index,
                              onTap: () => setState(() => _selectedBranchIndex = index),
                            ),
                          ),
                        ),
                      ],
                      
                      SizedBox(height: 32.h),
                      
                      // Content
                      PackageContentView(pkg: pkg, branch: currentBranch),
                      
                      SizedBox(height: 300.h),
                    ],
                  ),
                ),
              ),
            ],
          ),
          
          // Sticky Bottom Bar
          if (currentBranch != null)
            Positioned(
              bottom: 0,
              child: PackageBookingPanel(
                price: currentBranch.price,
                packageName: pkg?.name,
                onBookTap: () {
                  // Booking logic
                },
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildAppBar(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(
        top: MediaQuery.of(context).padding.top + 10.h,
        bottom: 10.h,
        left: 16.w,
        right: 16.w,
      ),
      color: Colors.white,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          IconButton(
            onPressed: () => Navigator.pop(context),
            icon: const Icon(Icons.arrow_back_ios_new),
          ),
          Text(
            "تفاصيل الباقة",
            style: AppTextStyle.setelMessiriBlack(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(width: 40),
        ],
      ),
    );
  }

  Widget _buildPackageInfo(dynamic pkg) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 24.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            pkg?.name ?? "",
            style: AppTextStyle.setelMessiriBlack(
              fontSize: 22,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 12.h),
          Row(
            children: [
              _buildStatItem(Icons.access_time_outlined, "6 أيام"),
              SizedBox(width: 16.w),
              _buildStatItem(Icons.hotel_outlined, "4 فنادق"),
              SizedBox(width: 16.w),
              _buildStatItem(Icons.location_on_outlined, "3 مدن"),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildStatItem(IconData icon, String label) {
    return Row(
      children: [
        Icon(icon, size: 14.sp, color: Colors.grey),
        SizedBox(width: 4.w),
        Text(
          label,
          style: AppTextStyle.setelMessiriSecondlightGrey(
            fontSize: 12,
            fontWeight: FontWeight.normal,
          ),
        ),
      ],
    );
  }
}

class PackageArguments {
  final String? packageSlug;
  final String? packageTypeSlug;
  final String? packageId;

  PackageArguments({this.packageSlug, this.packageTypeSlug, this.packageId});
}
