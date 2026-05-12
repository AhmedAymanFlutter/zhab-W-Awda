import 'package:flutter/material.dart';
import 'package:flutter_application_1/core/widgets/CustomHomeAppBar.dart';
import 'package:flutter_application_1/featuer/services/manager/services_cubit.dart';
import 'package:flutter_application_1/featuer/services/view/widgets/contact_banner.dart';
import 'package:flutter_application_1/featuer/services/view/widgets/services_list_view_section.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/theme/app_text_style.dart';

class ServicesView extends StatefulWidget {
  const ServicesView({super.key});

  @override
  State<ServicesView> createState() => _ServicesViewState();
}

class _ServicesViewState extends State<ServicesView> {
  @override
  void initState() {
    super.initState();
    context.read<ServicesCubit>().fetchServices();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FA),
      appBar: CustomHomeAppBar(
        leading: GestureDetector(
          onTap: () => Navigator.pop(context),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                "خدماتنا",
                style: AppTextStyle.setelMessiriBlack(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(width: 8.w),
              Icon(Icons.arrow_forward_ios, size: 16.sp, color: Colors.black),
            ],
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 24.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Contact Banner at the top
            const ContactBanner(),
            SizedBox(height: 24.h),
            // Title
            Text(
              "خدماتنا لرحلة أفضل",
              style: AppTextStyle.setelMessiriBlack(
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 24.h),
            // List of Services
            const ServicesListViewSection(),
            SizedBox(height: 40.h),
          ],
        ),
      ),
    );
  }
}
