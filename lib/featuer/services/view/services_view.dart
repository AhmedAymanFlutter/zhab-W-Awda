import 'package:flutter/material.dart';
import 'package:flutter_application_1/core/widgets/CustomHomeAppBar.dart';
import 'package:flutter_application_1/featuer/services/view/widgets/service_details_bottom_sheet.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter_application_1/featuer/services/manager/services_cubit.dart';
import 'package:flutter_application_1/featuer/services/manager/services_state.dart';
import 'package:flutter_application_1/featuer/services/view/widgets/service_detailed_card.dart';
import 'package:flutter_application_1/featuer/services/view/widgets/contact_banner.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:skeletonizer/skeletonizer.dart';
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
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(Icons.arrow_forward_ios, size: 16.sp, color: Colors.black),
              SizedBox(width: 8.w),
              Text(
                "خدماتنا",
                style: AppTextStyle.setelMessiriBlack(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
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
            BlocBuilder<ServicesCubit, ServicesState>(
              buildWhen: (previous, current) =>
                  current is ServicesLoading ||
                  current is ServicesSuccess ||
                  current is ServicesError,
              builder: (context, state) {
                if (state is ServicesLoading) {
                  return Skeletonizer(
                    enabled: true,
                    child: _buildServicesList(
                      List.generate(4, (index) => null), // Showing 4 skeletons
                    ),
                  );
                } else if (state is ServicesError) {
                  return Center(
                    child: Column(
                      children: [
                        Text(state.message),
                        TextButton(
                          onPressed: () =>
                              context.read<ServicesCubit>().fetchServices(),
                          child: const Text("إعادة المحاولة"),
                        ),
                      ],
                    ),
                  );
                } else if (state is ServicesSuccess) {
                  return _buildServicesList(state.services);
                }
                return const SizedBox();
              },
            ),
            SizedBox(height: 40.h),
          ],
        ),
      ),
    );
  }

  Widget _buildServicesList(List<dynamic> services) {
    return ListView.separated(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: services.length,
      separatorBuilder: (context, index) => SizedBox(height: 16.h),
      itemBuilder: (context, index) {
        final service = services[index];
        return ServiceDetailedCard(
          title: service?.name ?? "تحميل...",
          description:
              service?.description ??
              "نقدم خدمة تأجير سيارات مريحة ومرنة لتسهيل تنقلك خلال رحلتك بأفضل الأسعار.",
          iconUrl: service?.imageCover,
          onDetailsTap: () {
            showServiceDetailsBottomSheet(
              context,
              title: service?.name ?? "الخدمة",
              description: service?.description ?? "وصف الخدمة غير متوفر.",
            );
          },
          onBookTap: () async {
            final title = service?.name ?? "الخدمة";
            final Uri url = Uri.parse(
              "https://wa.me/?text=مرحباً، أريد الاستفسار/الحجز عن خدمة: $title",
            );
            if (await canLaunchUrl(url)) {
              await launchUrl(url, mode: LaunchMode.externalApplication);
            }
          },
        );
      },
    );
  }
}
