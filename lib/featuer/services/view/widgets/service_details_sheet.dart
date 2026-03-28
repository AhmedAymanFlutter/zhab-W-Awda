import 'package:flutter/material.dart';
import 'package:flutter_application_1/featuer/services/manager/services_cubit.dart';
import 'package:flutter_application_1/featuer/services/manager/services_state.dart';
import 'package:flutter_application_1/featuer/services/data/service_mapper.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../../core/theme/app_text_style.dart';

class ServiceDetailsSheet extends StatefulWidget {
  final String serviceId;

  const ServiceDetailsSheet({super.key, required this.serviceId});

  @override
  State<ServiceDetailsSheet> createState() => _ServiceDetailsSheetState();
}

class _ServiceDetailsSheetState extends State<ServiceDetailsSheet> {
  @override
  void initState() {
    super.initState();
    context.read<ServicesCubit>().getServiceDetails(widget.serviceId);
  }

  Future<void> _launchWhatsApp(String? phone) async {
    final number = phone ?? "201000000000";
    final url = "https://wa.me/$number";
    if (await canLaunchUrl(Uri.parse(url))) {
      await launchUrl(Uri.parse(url), mode: LaunchMode.externalApplication);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.fromLTRB(24.w, 12.h, 24.w, 32.h),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(24.r),
          topRight: Radius.circular(24.r),
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 40.w,
            height: 4.h,
            decoration: BoxDecoration(
              color: Colors.grey[300],
              borderRadius: BorderRadius.circular(2.r),
            ),
          ),
          SizedBox(height: 20.h),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              IconButton(
                icon: const Icon(Icons.close),
                onPressed: () => Navigator.pop(context),
              ),
              BlocBuilder<ServicesCubit, ServicesState>(
                builder: (context, state) {
                  String title = "تحميل...";
                  if (state is ServiceDetailsSuccess) {
                    title = state.service.name ?? "";
                  }
                  return Text(
                    title,
                    style: AppTextStyle.setelMessiriBlack(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  );
                },
              ),
              const SizedBox(width: 40),
            ],
          ),
          const Divider(),
          SizedBox(height: 16.h),
          BlocBuilder<ServicesCubit, ServicesState>(
            builder: (context, state) {
              final isLoading = state is ServiceDetailsLoading;
              final service = (state is ServiceDetailsSuccess) ? state.service : null;

              return Skeletonizer(
                enabled: isLoading,
                child: Column(
                  children: [
                    if (service != null || isLoading)
                      Padding(
                        padding: EdgeInsets.only(bottom: 16.h),
                        child: SvgPicture.asset(
                          ServiceMapper.getAssetPath(service?.name),
                          width: 48.w,
                          height: 48.h,
                        ),
                      ),
                    Text(
                      service?.description ?? service?.descText ?? 
                      "نقدم مجموعة متكاملة من خدمات السفر التي تساعدك على التخطيط لرحلتك بسهولة، من حجز الطيران والفنادق إلى باقات السفر والدعم المستمر، لنضمن لك تجربة سفر مريحة ومميزة في كل خطوة.",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 14.sp,
                        color: Colors.black87,
                        height: 1.6,
                        fontFamily: 'Tajawal',
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
          SizedBox(height: 32.h),
          ElevatedButton.icon(
            onPressed: () => _launchWhatsApp(null),
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF4CAF50),
              foregroundColor: Colors.white,
              minimumSize: Size(double.infinity, 50.h),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12.r),
              ),
              elevation: 0,
            ),
            icon: const FaIcon(
              FontAwesomeIcons.whatsapp,
              color: Colors.white,
              size: 24,
            ),
            label: Text(
              "تواصل معنا واتساب",
              style: AppTextStyle.setelMessiriWhite(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          SizedBox(height: 12.h),
          OutlinedButton(
            onPressed: () => Navigator.pop(context),
            style: OutlinedButton.styleFrom(
              minimumSize: Size(double.infinity, 50.h),
              side: BorderSide(color: Colors.grey.shade300),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12.r),
              ),
            ),
            child: Text(
              "إلغاء",
              style: AppTextStyle.setelMessiriBlack(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
