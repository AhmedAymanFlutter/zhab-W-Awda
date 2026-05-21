import 'package:flutter/material.dart';
import 'package:flutter_application_1/core/theme/app_color.dart';
import 'package:flutter_application_1/core/widgets/cusstom_search_bar.dart';
import 'package:flutter_application_1/core/network/network_error_manager.dart';
import 'package:flutter_application_1/core/widgets/network_retry_wrapper.dart';
import 'package:flutter_application_1/featuer/hotels/data/model/getHotel_model.dart';
import 'package:flutter_application_1/featuer/hotels/data/repo/hotels_repository.dart';
import 'package:flutter_application_1/featuer/hotels/manager/hotels_cubit.dart';
import 'package:flutter_application_1/featuer/home/view/widgets/recommended_hotel_card.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:skeletonizer/skeletonizer.dart';

import '../manager/hotels_state.dart';
import 'widget/hotel_filter_bottom_sheet.dart';

class HotelsView extends StatelessWidget {
  final String? countryName;

  const HotelsView({super.key, this.countryName});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          HotelsCubit(HotelsRepository())..fetchHotels(country: countryName),
      child: Scaffold(
        backgroundColor: AppColor.offWhite,
        body: Directionality(
          textDirection: TextDirection.rtl,
          child: SafeArea(
            child: ValueListenableBuilder<String?>(
              valueListenable: NetworkErrorManager.connectionErrorNotifier,
              builder: (context, errorMessage, child) {
                return NetworkRetryWrapper(
                  hasError: errorMessage != null,
                  errorMessage: errorMessage,
                  onRetry: () async {
                    await BlocProvider.of<HotelsCubit>(context)
                        .fetchHotels(country: countryName);
                    NetworkErrorManager.clearError();
                  },
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16.w),
                    child: Column(
                      children: [
                        SizedBox(height: 16.h),
                        Builder(
                          builder: (context) {
                            return ReusableSearchBar(
                              onSearchChanged: (value) {
                                HotelsCubit.get(context).fetchHotels(query: value);
                              },
                              onFilterTap: () {
                                final cubit = HotelsCubit.get(context);
                                showModalBottomSheet(
                                  context: context,
                                  isScrollControlled: true,
                                  backgroundColor: Colors.transparent,
                                  builder: (context) {
                                    return HotelFilterBottomSheet(
                                      onApply: (
                                        city,
                                        search,
                                        checkIn,
                                        checkOut,
                                        adults,
                                        children,
                                      ) {
                                        cubit.fetchHotels(
                                          city: city,
                                          query: search,
                                          checkIn: checkIn,
                                          checkOut: checkOut,
                                          adults: adults,
                                          children: children,
                                        );
                                      },
                                    );
                                  },
                                );
                              },
                              hintText: "ابحث عن الفنادق...",
                              useDebounce: true,
                            );
                          },
                        ),
                        SizedBox(height: 24.h),
                        // Title
                        Text(
                          "أفضل الفنادق لإقامة مريحة",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontFamily: 'ElMessiri',
                            fontSize: 22.sp,
                            fontWeight: FontWeight.bold,
                            color: Colors.black87,
                          ),
                        ),
                        SizedBox(height: 8.h),
                        // Subtitle
                        Text(
                          "اختر من بين مجموعة مميزة من الفنادق والمنتجعات الفاخرة حول\nالعالم، توفر لك خيارات متنوعة تناسب العائلات ورحلات العمل\nوالاستجمام، مع مواقع مميزة وخدمات عالية الجودة لضمان\nإقامة لا تُنسى.",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontFamily: 'ElMessiri',
                            fontSize: 13.sp,
                            height: 1.5,
                            fontWeight: FontWeight.normal,
                            color: Colors.black87.withOpacity(0.7),
                          ),
                        ),
                        SizedBox(height: 24.h),
                        Expanded(
                          child: BlocBuilder<HotelsCubit, HotelsState>(
                            builder: (context, state) {
                              if (state is HotelsLoading) {
                                return Skeletonizer(
                                  enabled: true,
                                  child: ListView.separated(
                                    physics: const BouncingScrollPhysics(),
                                    itemCount: 4,
                                    separatorBuilder: (context, index) =>
                                        SizedBox(height: 16.h),
                                    itemBuilder: (context, index) {
                                      return RecommendedHotelCard(
                                        hotel: HotelItem(name: "Loading"),
                                      );
                                    },
                                  ),
                                );
                              } else if (state is HotelsError) {
                                return Center(child: Text(state.message));
                              } else if (state is HotelsSuccess) {
                                if (state.hotels.isEmpty) {
                                  return const Center(
                                    child: Text("لم يتم العثور على فنادق تطابق بحثك"),
                                  );
                                }
                                return ListView.separated(
                                  physics: const BouncingScrollPhysics(),
                                  itemCount: state.hotels.length,
                                  separatorBuilder: (context, index) =>
                                      SizedBox(height: 16.h),
                                  itemBuilder: (context, index) {
                                    return RecommendedHotelCard(
                                      hotel: state.hotels[index],
                                    );
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
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
