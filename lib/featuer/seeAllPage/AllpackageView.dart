import 'package:flutter/material.dart';
import 'package:flutter_application_1/core/widgets/cusstom_search_bar.dart';
import 'package:flutter_application_1/featuer/home/view/package/data/repo/package_repo.dart';
import 'package:flutter_application_1/featuer/home/view/package/manager/packages_cubit.dart';
import 'package:flutter_application_1/featuer/home/view/package/manager/packages_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:skeletonizer/skeletonizer.dart';
import '../../../../core/theme/app_color.dart';
import '../../../../core/theme/app_text_style.dart';
import '../home/view/package/view/package_card.dart';

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

                          return SizedBox(
                            height: 220.h,
                            child: PackageCard(package: package),
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
