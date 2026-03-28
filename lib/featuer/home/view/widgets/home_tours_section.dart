import 'package:flutter/material.dart';
import 'package:flutter_application_1/core/router/routes.dart';
import 'package:flutter_application_1/core/theme/app_color.dart';
import 'package:flutter_application_1/core/theme/app_text_style.dart';
import 'package:flutter_application_1/featuer/tours/manager/tours_cubit.dart';
import 'package:flutter_application_1/featuer/tours/manager/tours_state.dart';
import 'package:flutter_application_1/featuer/tours/view/widgets/tour_card_v2.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:skeletonizer/skeletonizer.dart';
import '../../../../featuer/tours/data/model/get_all_tours_model.dart';

class HomeToursSection extends StatelessWidget {
  const HomeToursSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 32.w),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              InkWell(
                onTap: () => Navigator.pushNamed(context, Routes.toursView),
                child: Text(
                  "عرض الكل",
                  style: TextStyle(
                    decoration: TextDecoration.underline,
                    decorationColor: AppColor.primaryBlue,
                    fontSize: 12.sp,
                    fontWeight: FontWeight.w600,
                    color: AppColor.primaryBlue,
                  ),
                ),
              ),
              Text(
                "الجولات",
                style: AppTextStyle.setelMessiriBlack(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: 16.h),
        SizedBox(
          height: 360.h, // Slightly more than card height (343) for shadow/padding
          child: BlocBuilder<ToursCubit, ToursState>(
            builder: (context, state) {
              if (state is ToursLoading) {
                return ListView.separated(
                  padding: EdgeInsets.symmetric(horizontal: 16.w),
                  scrollDirection: Axis.horizontal,
                  itemCount: 3,
                  separatorBuilder: (_, __) => SizedBox(width: 16.w),
                  itemBuilder: (context, index) {
                    return Skeletonizer(
                      enabled: true,
                      child: TourCardV2(
                        tour: TourItem(
                          title: "رحلة سياحية مميزة",
                          price: "3000",
                          imageCover: "",
                        ),
                      ),
                    );
                  },
                );
              } else if (state is ToursSuccess) {
                if (state.tours.isEmpty) return const SizedBox();
                return ListView.separated(
                  physics: const BouncingScrollPhysics(),
                  padding: EdgeInsets.symmetric(horizontal: 24.w),
                  scrollDirection: Axis.horizontal,
                  itemCount: state.tours.length,
                  separatorBuilder: (_, __) => SizedBox(width: 16.w),
                  itemBuilder: (context, index) {
                    return TourCardV2(tour: state.tours[index]);
                  },
                );
              } else if (state is ToursError) {
                return Center(child: Text(state.message));
              }
              return const SizedBox();
            },
          ),
        ),
      ],
    );
  }
}
