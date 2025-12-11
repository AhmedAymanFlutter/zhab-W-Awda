import 'package:flutter/material.dart';
import 'package:flutter_application_1/featuer/services/data/repo/services_repository.dart';
import 'package:flutter_application_1/featuer/services/manager/services_cubit.dart';
import 'package:flutter_application_1/featuer/services/manager/services_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/theme/app_color.dart';

import 'widgets/service_card.dart';

class ServicesView extends StatelessWidget {
  const ServicesView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ServicesCubit(ServicesRepository())..fetchServices(),
      child: Scaffold(
        backgroundColor: AppColor.primaryWhite,
        appBar: AppBar(
          backgroundColor: AppColor.primaryWhite,
          elevation: 0,
          centerTitle: true,
          title: Text(
            "خدماتنا",
            style: TextStyle(
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
              SizedBox(height: 10.h),
              Expanded(
                child: BlocBuilder<ServicesCubit, ServicesState>(
                  builder: (context, state) {
                    if (state is ServicesLoading) {
                      return const Center(child: CircularProgressIndicator());
                    } else if (state is ServicesError) {
                      return Center(child: Text(state.message));
                    } else if (state is ServicesSuccess) {
                      return GridView.builder(
                        physics: const BouncingScrollPhysics(),
                        itemCount: state.services.length,
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          crossAxisSpacing: 12.w,
                          mainAxisSpacing: 12.h,
                          childAspectRatio: 0.85,
                        ),
                        itemBuilder: (context, index) {
                          return ServiceCard(service: state.services[index]);
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
