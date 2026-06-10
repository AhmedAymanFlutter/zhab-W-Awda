import 'package:flutter/material.dart';
import 'package:flutter_application_1/featuer/packageType/manager/package_types_cubit.dart';
import 'package:flutter_application_1/featuer/packageType/manager/package_types_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/theme/app_color.dart';
import 'package:flutter_application_1/featuer/packageType/view/widgets/modern_package_type_card.dart';
import '../../../../core/widgets/cusstom_search_bar.dart';
import '../../../../core/di/dependency_injection.dart';

class PackageTypesView extends StatelessWidget {
  const PackageTypesView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<PackageTypesCubit>()..fetchPackageTypes(),
      child: SafeArea(
        child: Scaffold(
        backgroundColor: AppColor.primaryWhite,

        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w),
          child: Column(
            children: [
              ReusableSearchBar(
                hintText: "Search package types (e.g. Cairo, Luxury...)",
                useDebounce: true,
                onFilterTap: () {},
                onSearchChanged: (value) {
                  // PackageTypesCubit.get(context).searchLocalPackageTypes(value);
                },
              ),
              SizedBox(height: 10.h),
              Expanded(
                child: BlocBuilder<PackageTypesCubit, PackageTypesState>(
                  builder: (context, state) {
                    if (state is PackageTypesLoading) {
                      return const Center(child: CircularProgressIndicator());
                    } else if (state is PackageTypesError) {
                      return Center(child: Text(state.message));
                    } else if (state is PackageTypesSuccess) {
                      return ListView.separated(
                        physics: const BouncingScrollPhysics(),
                        itemCount: state.types.length,
                        padding: EdgeInsets.only(bottom: 20.h),
                        separatorBuilder: (context, index) => SizedBox(height: 16.h),
                        itemBuilder: (context, index) {
                          return ModernPackageTypeCard(
                            packageType: state.types[index],
                            variant: PackageTypeCardVariant.wide,
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
      ),
    );
  }
}
