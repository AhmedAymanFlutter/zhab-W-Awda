import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:skeletonizer/skeletonizer.dart';
import '../../../../core/theme/app_color.dart';
import '../../../../core/theme/app_text_style.dart';
import '../../../../core/router/routes.dart';
import '../../../countries/manager/countries_cubit.dart';
import '../../../countries/manager/countries_state.dart';

class HomeDestinationsSection extends StatelessWidget {
  const HomeDestinationsSection({super.key});

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
                onTap: () => Navigator.pushNamed(context, Routes.countriesView),
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
                "الوجهات الأكثر شهرة",
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
          height: 88.w,
          child: BlocBuilder<CountriesCubit, CountriesState>(
            builder: (context, state) {
              if (state is CountriesLoading) {
                return ListView.separated(
                  padding: EdgeInsets.symmetric(horizontal: 16.w),
                  scrollDirection: Axis.horizontal,
                  itemCount: 6,
                  separatorBuilder: (_, __) => SizedBox(width: 16.w),
                  itemBuilder: (context, index) {
                    return Skeletonizer(
                      enabled: true,
                      child: _buildDestinationItem(
                        name: "دولة",
                        imageUrl: null,
                      ),
                    );
                  },
                );
              } else if (state is CountriesSuccess) {
                if (state.countries.isEmpty) return const SizedBox();
                return ListView.separated(
                  physics: const BouncingScrollPhysics(),
                  padding: EdgeInsets.symmetric(horizontal: 16.w),
                  scrollDirection: Axis.horizontal,
                  itemCount: state.countries.length,
                  separatorBuilder: (_, __) => SizedBox(width: 16.w),
                  itemBuilder: (context, index) {
                    final country = state.countries[index];
                    return GestureDetector(
                      onTap: () {
                        if (country.slug != null) {
                          Navigator.pushNamed(context, Routes.tourGuideDetailsView, arguments: country.slug);
                        }
                      },
                      child: _buildDestinationItem(
                        name: country.name ?? "",
                        imageUrl: country.imageCover,
                      ),
                    );
                  },
                );
              } else if (state is CountriesError) {
                return Center(child: Text(state.message));
              }
              return const SizedBox();
            },
          ),
        ),
      ],
    );
  }

  Widget _buildDestinationItem({required String name, String? imageUrl}) {
    return Container(
      width: 88.w,
      height: 88.w,
      decoration: BoxDecoration(
        color: Colors.grey[200],
        borderRadius: BorderRadius.circular(10.r),
        image: imageUrl != null && imageUrl.isNotEmpty
            ? DecorationImage(
                image: NetworkImage(imageUrl),
                fit: BoxFit.cover,
              )
            : null,
      ),
      child: Stack(
        fit: StackFit.expand,
        children: [
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10.r),
              gradient: LinearGradient(
                begin: Alignment.bottomCenter,
                end: Alignment.topCenter,
                colors: [
                  Colors.black.withOpacity(0.5),
                  Colors.black.withOpacity(0.1),
                ],
              ),
            ),
          ),
          Center(
            child: Text(
              name,
              textAlign: TextAlign.center,
              style: AppTextStyle.setelMessiriWhite(
                fontSize: 14,
                fontWeight: FontWeight.bold,
              ),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }
}
