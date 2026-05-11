import 'package:flutter/material.dart';
import 'package:flutter_application_1/featuer/services/manager/services_cubit.dart';
import 'package:flutter_application_1/featuer/services/manager/services_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'package:url_launcher/url_launcher.dart';

import 'service_detailed_card.dart';
import 'service_details_bottom_sheet.dart';

class ServicesListViewSection extends StatelessWidget {
  const ServicesListViewSection({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ServicesCubit, ServicesState>(
      buildWhen: (previous, current) =>
          current is ServicesLoading ||
          current is ServicesSuccess ||
          current is ServicesError,
      builder: (context, state) {
        if (state is ServicesLoading) {
          return Skeletonizer(
            enabled: true,
            child: _buildServicesList(
              context,
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
          return _buildServicesList(context, state.services);
        }
        return const SizedBox();
      },
    );
  }

  Widget _buildServicesList(BuildContext context, List<dynamic> services) {
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
