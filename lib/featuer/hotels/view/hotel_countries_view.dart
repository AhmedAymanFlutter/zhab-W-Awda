import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/theme/app_color.dart';
import '../../../../core/theme/app_text_style.dart';
import '../../../../core/router/routes.dart';
import '../manager/hotels_cubit.dart';
import '../manager/hotels_state.dart';
import '../data/repo/hotels_repository.dart';

class HotelCountriesView extends StatelessWidget {
  const HotelCountriesView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          HotelsCubit(HotelsRepository())..fetchHotelCountries(),
      child: Scaffold(
        backgroundColor: AppColor.primaryWhite,
        appBar: AppBar(
          backgroundColor: AppColor.primaryBlue,
          elevation: 0,
          leading: const BackButton(color: AppColor.primaryWhite),
          title: Text(
            "وجهات الفنادق",
            style: AppTextStyle.setelMessiriBlack(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ).copyWith(color: AppColor.primaryWhite),
          ),
          centerTitle: true,
        ),
        body: BlocBuilder<HotelsCubit, HotelsState>(
          builder: (context, state) {
            if (state is HotelCountriesLoading) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is HotelCountriesError) {
              return Center(child: Text(state.message));
            } else {
              final countries = HotelsCubit.get(context).countries;
              if (countries.isEmpty) {
                return const Center(child: Text("لا توجد وجهات متاحة حالياً"));
              }

              return ListView.separated(
                padding: EdgeInsets.all(16.w),
                itemCount: countries.length,
                separatorBuilder: (context, index) => SizedBox(height: 12.h),
                itemBuilder: (context, index) {
                  final country = countries[index];
                  return GestureDetector(
                    onTap: () {
                      Navigator.pushNamed(
                        context,
                        Routes.hotelsView,
                        arguments: country.country,
                      );
                    },
                    child: Container(
                      padding: EdgeInsets.all(16.w),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(12.r),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.05),
                            blurRadius: 10,
                            offset: const Offset(0, 4),
                          ),
                        ],
                      ),
                      child: Row(
                        children: [
                          Container(
                            padding: EdgeInsets.all(8.w),
                            decoration: BoxDecoration(
                              color: AppColor.primaryBlue.withOpacity(0.1),
                              shape: BoxShape.circle,
                            ),
                            child: Icon(
                              Icons.location_on,
                              color: AppColor.primaryBlue,
                              size: 24.sp,
                            ),
                          ),
                          SizedBox(width: 16.w),
                          Expanded(
                            child: Text(
                              country.country ?? "",
                              style: AppTextStyle.setelMessiriBlack(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          Icon(
                            Icons.arrow_forward_ios,
                            size: 16.sp,
                            color: Colors.grey,
                          ),
                        ],
                      ),
                    ),
                  );
                },
              );
            }
          },
        ),
      ),
    );
  }
}
