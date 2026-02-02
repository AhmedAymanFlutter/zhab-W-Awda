import 'package:flutter/material.dart';
import 'package:flutter_application_1/core/theme/app_color.dart';
import 'package:flutter_application_1/core/widgets/cusstom_search_bar.dart';
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
        backgroundColor: AppColor.primaryWhite,
        body: SafeArea(
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
                              onApply:
                                  (
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
                      hintText: "Search hotels...",
                      useDebounce: true,
                    );
                  },
                ),

                SizedBox(height: 16.h),
                Expanded(
                  child: BlocBuilder<HotelsCubit, HotelsState>(
                    builder: (context, state) {
                      if (state is HotelsLoading) {
                        return Skeletonizer(
                          enabled: true,
                          child: GridView.builder(
                            physics: const BouncingScrollPhysics(),
                            itemCount: 4,
                            gridDelegate:
                                SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 2,
                                  crossAxisSpacing: 12.w,
                                  mainAxisSpacing: 12.h,
                                  childAspectRatio: 0.75,
                                ),
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
                            child: Text("No hotels found matching your search"),
                          );
                        }

                        return GridView.builder(
                          physics: const BouncingScrollPhysics(),
                          itemCount: state.hotels.length,
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 2,
                                crossAxisSpacing: 12.w,
                                mainAxisSpacing: 12.h,
                                childAspectRatio: 0.6,
                              ),
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
        ),
      ),
    );
  }
}
