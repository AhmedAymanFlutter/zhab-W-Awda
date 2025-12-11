import 'package:flutter/material.dart';
import 'package:flutter_application_1/featuer/hotels/data/model/getHotel_model.dart';
import 'package:flutter_application_1/featuer/hotels/data/repo/hotels_repository.dart';
import 'package:flutter_application_1/featuer/hotels/manager/hotels_cubit.dart';
import 'package:flutter_application_1/featuer/hotels/manager/hotels_state.dart';
import 'package:flutter_application_1/featuer/hotels/view/widget/hotel_card.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:skeletonizer/skeletonizer.dart';
import '../../../../core/theme/app_color.dart';

class HotelsView extends StatelessWidget {
  const HotelsView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => HotelsCubit(HotelsRepository())..fetchHotels(),
      child: Scaffold(
        backgroundColor: AppColor.primaryWhite,
        body: SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.w),
            child: Column(
              children: [
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
                              return HotelCard(hotel: HotelItem());
                            },
                          ),
                        );
                      } else if (state is HotelsError) {
                        return Center(child: Text(state.message));
                      } else if (state is HotelsSuccess) {
                        return GridView.builder(
                          physics: const BouncingScrollPhysics(),
                          itemCount: state.hotels.length,
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 2,
                                crossAxisSpacing: 12.w,
                                mainAxisSpacing: 12.h,
                                childAspectRatio:
                                    0.75, // Adjust for card height
                              ),
                          itemBuilder: (context, index) {
                            return HotelCard(hotel: state.hotels[index]);
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
