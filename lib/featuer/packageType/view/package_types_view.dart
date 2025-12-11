import 'package:flutter/material.dart';
import 'package:flutter_application_1/featuer/packageType/data/repo/package_types_repository.dart';
import 'package:flutter_application_1/featuer/packageType/manager/package_types_cubit.dart';
import 'package:flutter_application_1/featuer/packageType/manager/package_types_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/theme/app_color.dart';

import 'widgets/package_type_card.dart';

class PackageTypesView extends StatelessWidget {
  const PackageTypesView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          PackageTypesCubit(PackageTypesRepository())..fetchPackageTypes(),
      child: Scaffold(
        backgroundColor: AppColor.primaryWhite,

        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w),
          child: Column(
            children: [
              SizedBox(height: 10.h),
              Expanded(
                child: BlocBuilder<PackageTypesCubit, PackageTypesState>(
                  builder: (context, state) {
                    if (state is PackageTypesLoading) {
                      return const Center(child: CircularProgressIndicator());
                    } else if (state is PackageTypesError) {
                      return Center(child: Text(state.message));
                    } else if (state is PackageTypesSuccess) {
                      return GridView.builder(
                        physics: const BouncingScrollPhysics(),
                        itemCount: state.types.length,
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          crossAxisSpacing: 12.w,
                          mainAxisSpacing: 12.h,
                          childAspectRatio: 1.0, // Square shape works well here
                        ),
                        itemBuilder: (context, index) {
                          return PackageTypeCard(
                            packageType: state.types[index],
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
