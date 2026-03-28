import 'package:flutter/material.dart';
import 'package:flutter_application_1/featuer/services/manager/services_cubit.dart';
import 'package:flutter_application_1/featuer/services/manager/services_state.dart';
import 'package:flutter_application_1/featuer/services/view/widgets/service_icon_item.dart';
import 'package:flutter_application_1/featuer/services/view/widgets/contact_banner.dart';
import 'package:flutter_application_1/featuer/services/data/service_mapper.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:skeletonizer/skeletonizer.dart';
import '../../../../core/theme/app_color.dart';
import '../../../../core/theme/app_text_style.dart';

class ServicesView extends StatelessWidget {
  const ServicesView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FA),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 24.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: 20.h),
              // Breadcrumbs
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text(
                    "الخدمات",
                    style: TextStyle(
                      fontSize: 14.sp,
                      color: AppColor.primaryBlue2,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    " « الرئيسية ",
                    style: TextStyle(
                      fontSize: 14.sp,
                      color: Colors.grey,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 32.h),
              // Title
              Text(
                "خدماتنا لرحلة أفضل",
                style: AppTextStyle.setelMessiriBlack(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 12.h),
              // Description
              Text(
                "نقدم مجموعة متكاملة من خدمات السفر التي تساعدك على التخطيط لرحلتك بسهولة، من حجز الطيران والفنادق إلى باقات السفر والدعم المستمر، لنضمن لك تجربة سفر مريحة ومميزة في كل خطوة.",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 13.sp,
                  color: Colors.black54,
                  height: 1.5,
                  fontFamily: 'Tajawal',
                ),
              ),
              SizedBox(height: 40.h),
              // Grid of Services
              BlocBuilder<ServicesCubit, ServicesState>(
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
                      child: _buildServicesGrid(List.generate(7, (index) => null)),
                    );
                  } else if (state is ServicesError) {
                    return Center(child: Text(state.message));
                  } else if (state is ServicesSuccess) {
                    return _buildServicesGrid(state.services);
                  }
                  return const SizedBox();
                },
              ),
              SizedBox(height: 40.h),
              // Contact Banner
              const ContactBanner(),
              SizedBox(height: 40.h),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildServicesGrid(List<dynamic> services) {
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: services.length,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 4,
        crossAxisSpacing: 10.w,
        mainAxisSpacing: 24.h,
        childAspectRatio: 0.7,
      ),
      itemBuilder: (context, index) {
        final service = services[index];
        return ServiceIconItem(
          name: service?.name ?? "تحميل",
          assetPath: ServiceMapper.getAssetPath(service?.name),
          iconUrl: service?.imageCover,
          id: service?.id,
        );
      },
    );
  }
}
