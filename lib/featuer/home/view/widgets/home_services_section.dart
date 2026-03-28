import 'package:flutter/material.dart';
import 'package:flutter_application_1/featuer/services/manager/services_cubit.dart';
import 'package:flutter_application_1/featuer/services/manager/services_state.dart';
import 'package:flutter_application_1/featuer/services/data/service_mapper.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:skeletonizer/skeletonizer.dart';
import '../../../../core/theme/app_color.dart';
import '../../../../core/theme/app_text_style.dart';
import '../../../services/view/widgets/service_icon_item.dart';

class HomeServicesSection extends StatelessWidget {
  final VoidCallback onViewAllTap;

  const HomeServicesSection({super.key, required this.onViewAllTap});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ServicesCubit, ServicesState>(
      buildWhen: (previousState, currentState) {
        return currentState is ServicesLoading ||
            currentState is ServicesSuccess ||
            currentState is ServicesError ||
            currentState is ServicesInitial;
      },
      builder: (context, state) {
        if (state is ServicesLoading) {
          return Skeletonizer(
            enabled: true,
            child: _buildContent(context, List.generate(4, (index) => null)),
          );
        } else if (state is ServicesSuccess) {
          final topServices = state.services.take(4).toList();
          return _buildContent(context, topServices);
        } else if (state is ServicesError) {
          return Center(child: Text(state.message));
        }
        return const SizedBox();
      },
    );
  }

  Widget _buildContent(BuildContext context, List<dynamic> services) {
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 24.w),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: services.map((service) {
              return ServiceIconItem(
                name: service?.name ?? "تحميل",
                assetPath: ServiceMapper.getAssetPath(service?.name),
                iconUrl: service?.imageCover,
                id: service?.id,
              );
            }).toList(),
          ),
        ),
        SizedBox(height: 24.h),
        InkWell(
          onTap: onViewAllTap,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "عرض جميع الخدمات",
                style: AppTextStyle.setelMessiriTextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: AppColor.primaryBlue2,
                ),
              ),
              SizedBox(width: 8.w),
              Icon(
                Icons.arrow_back_ios_new,
                size: 14.sp,
                color: AppColor.primaryBlue2,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
