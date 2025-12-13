import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/core/router/routes.dart';
import 'package:flutter_application_1/core/widgets/cusstom_search_bar.dart';
import 'package:flutter_application_1/featuer/home/view/package/data/repo/package_repo.dart';
import 'package:flutter_application_1/featuer/home/view/package/manager/packages_cubit.dart';
import 'package:flutter_application_1/featuer/home/view/package/manager/packages_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:skeletonizer/skeletonizer.dart';
import '../../../../core/theme/app_color.dart';
import '../../../../core/theme/app_text_style.dart';

class PackagesView extends StatelessWidget {
  const PackagesView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => PackagesCubit(PackagesRepository())..fetchPackages(),
      child: Scaffold(
        backgroundColor: AppColor.primaryWhite,
        appBar: AppBar(
          backgroundColor: AppColor.primaryWhite,
          elevation: 0,
          centerTitle: true,
          title: Text(
            "الباقات", // Packages
            style: AppTextStyle.setelMessiriTextStyle(
              fontSize: 20.sp,
              fontWeight: FontWeight.bold,
              color: AppColor.primaryBlue,
            ),
          ),
          leading: IconButton(
            icon: const Icon(Icons.arrow_back, color: AppColor.primaryBlue),
            onPressed: () => Navigator.pop(context),
          ),
        ),
        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w),
          child: Column(
            children: [
              // --- SEARCH BAR ---
              Builder(
                builder: (context) {
                  return ReusableSearchBar(
                    hintText: "بحث عن باقات...",
                    useDebounce: true,
                    onFilterTap: () {},
                    onSearchChanged: (value) {
                      PackagesCubit.get(context).searchLocalPackages(value);
                    },
                  );
                },
              ),

              SizedBox(height: 16.h),

              // --- LIST CONTENT ---
              Expanded(
                child: BlocBuilder<PackagesCubit, PackagesState>(
                  builder: (context, state) {
                    if (state is PackagesLoading) {
                      return Skeletonizer(
                        enabled: true,
                        child: ListView.separated(
                          physics: const BouncingScrollPhysics(),
                          itemCount: 5,
                          separatorBuilder: (context, index) =>
                              SizedBox(height: 12.h),
                          itemBuilder: (context, index) {
                            return Container(
                              height: 200.h,
                              decoration: BoxDecoration(
                                color: Colors.grey,
                                borderRadius: BorderRadius.circular(16.r),
                              ),
                            );
                          },
                        ),
                      );
                    } else if (state is PackagesError) {
                      return Center(child: Text(state.message));
                    } else if (state is PackagesSuccess) {
                      if (state.packages.isEmpty) {
                        return const Center(
                          child: Text("لا توجد باقات مطابقة"),
                        );
                      }

                      return ListView.separated(
                        physics: const BouncingScrollPhysics(),
                        itemCount: state.packages.length,
                        separatorBuilder: (context, index) =>
                            SizedBox(height: 16.h),
                        itemBuilder: (context, index) {
                          final package = state.packages[index];

                          return InkWell(
                            onTap: () => Navigator.pushNamed(
                              context,
                              Routes.packageDetailsView,
                              arguments: package.sId,
                            ),
                            child: Container(
                              height: 200.h,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(16.r),
                                color: Colors.black,
                              ),
                              child: Stack(
                                children: [
                                  // Image
                                  Positioned.fill(
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(16.r),
                                      child: CachedNetworkImage(
                                        imageUrl: package.imageCover ?? "",
                                        fit: BoxFit.cover,
                                        color: Colors.black.withOpacity(0.3),
                                        colorBlendMode: BlendMode.darken,
                                        errorWidget: (context, url, error) =>
                                            const Icon(
                                              Icons.error,
                                              color: Colors.white,
                                            ),
                                      ),
                                    ),
                                  ),
                                  // Text Content
                                  Positioned(
                                    bottom: 12.h,
                                    left: 12.w,
                                    right: 12.w,
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          package.city ?? "باقة مميزة",
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 18.sp,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        if (package.price != null) ...[
                                          SizedBox(height: 4.h),
                                          Text(
                                            "${package.price} ج.م",
                                            style: TextStyle(
                                              color: Colors.amber,
                                              fontSize: 16.sp,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ],
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      );
                    }
                    return const SizedBox();
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
