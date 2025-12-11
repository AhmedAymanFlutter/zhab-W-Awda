import 'package:flutter/material.dart';
import 'package:flutter_application_1/featuer/packageType/data/repo/package_types_repository.dart';
import 'package:flutter_application_1/featuer/packageType/manager/package_types_cubit.dart';
import 'package:flutter_application_1/featuer/packageType/manager/package_types_state.dart';
import 'package:flutter_application_1/featuer/packageType/view/widgets/package_type_card.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/theme/app_color.dart';

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
                      // ✅ استخدام ListView للقائمة العمودية
                      return ListView.separated(
                        physics: const BouncingScrollPhysics(),
                        itemCount: state.types.length,
                        // إضافة مسافة بين كل عنصر والآخر
                        separatorBuilder: (context, index) =>
                            SizedBox(height: 16.h),
                        // مسافة في الأسفل عشان آخر عنصر
                        padding: EdgeInsets.only(bottom: 20.h),
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
