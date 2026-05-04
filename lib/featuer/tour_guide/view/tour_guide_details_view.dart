import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_application_1/featuer/countries/data/repo/countries_repository.dart';
import 'package:flutter_application_1/featuer/tour_guide/manager/tour_guide_cubit.dart';
import 'package:flutter_application_1/featuer/tour_guide/manager/tour_guide_state.dart';
import 'package:flutter_application_1/featuer/tour_guide/data/repo/tour_guide_repository.dart';
import 'package:flutter_application_1/core/widgets/offer_booking_bar.dart';
import 'widgets/guide_hero_header.dart';
import 'widgets/guide_introduction.dart';
import 'widgets/guide_sections_list.dart';
import 'widgets/guide_quick_info_section.dart';

class TourGuideDetailsView extends StatelessWidget {
  final String slug;

  const TourGuideDetailsView({super.key, required this.slug});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => TourGuideCubit(
        TourGuideRepository(),
        CountriesRepository(),
      )..getTourGuideDetails(slug),
      child: Scaffold(
        backgroundColor: Colors.white,
        bottomNavigationBar: const OfferBookingBar(),
        body: Directionality(
          textDirection: TextDirection.rtl,
          child: BlocBuilder<TourGuideCubit, TourGuideState>(
            builder: (context, state) {
              if (state is TourGuideLoading) {
                return const Center(child: CircularProgressIndicator());
              } else if (state is TourGuideError) {
                return Center(child: Text(state.message));
              } else if (state is TourGuideSuccess) {
                final guideData = state.guideData;
                final countryData = state.countryData;
                
                return CustomScrollView(
                  physics: const BouncingScrollPhysics(),
                  slivers: [
                    // 1. Hero Header
                    GuideHeroHeader(country: countryData),

                    SliverToBoxAdapter(
                      child: Padding(
                        padding: EdgeInsets.all(24.w),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // 2. Introduction
                            GuideIntroduction(text: countryData.description ?? countryData.descText ?? ""),

                            SizedBox(height: 24.h),

                            // 2.5 Quick Info Cards
                            GuideQuickInfoSection(country: countryData),
                            SizedBox(height: 32.h),

                            // 4. Cities
                            if (guideData.cities != null && guideData.cities!.isNotEmpty)
                              GuideSectionsList(
                                title: "أبرز المدن",
                                items: guideData.cities!
                                    .map(
                                      (c) => GuideSectionItem(
                                        title: c.name ?? "",
                                        subTitle: c.descText ?? "",
                                        imageUrl:
                                            (c.images != null &&
                                                c.images!.isNotEmpty)
                                            ? c.images!.first
                                            : "",
                                      ),
                                    )
                                    .toList(),
                              ),

                            SizedBox(height: 32.h),

                            // 5. Restaurants
                            if (guideData.restaurants != null &&
                                guideData.restaurants!.isNotEmpty)
                              GuideSectionsList(
                                title: "أفضل المطاعم",
                                items: guideData.restaurants!
                                    .map(
                                      (r) => GuideSectionItem(
                                        title: r.name ?? "",
                                        subTitle: r.description ?? "",
                                        imageUrl: r.imageCover ?? "",
                                      ),
                                    )
                                    .toList(),
                              ),

                            SizedBox(height: 32.h),

                            // 6. Things To Do
                            if (guideData.thingsToDo != null &&
                                guideData.thingsToDo!.isNotEmpty)
                              GuideSectionsList(
                                title: "أنشطة مقترحة",
                                items: guideData.thingsToDo!
                                    .map(
                                      (t) => GuideSectionItem(
                                        title: t.name ?? "",
                                        subTitle: t.description ?? "",
                                        imageUrl: t.imageCover ?? "",
                                      ),
                                    )
                                    .toList(),
                              ),

                            SizedBox(height: 32.h),

                            // 7. Hotels
                            if (guideData.hotels != null && guideData.hotels!.isNotEmpty)
                              GuideSectionsList(
                                title: "فنادق موصى بها",
                                items: guideData.hotels!
                                    .map(
                                      (h) => GuideSectionItem(
                                        title: h.hotelName ?? "",
                                        subTitle:
                                            h.description ?? h.overview ?? "",
                                        imageUrl:
                                            (h.images != null &&
                                                h.images!.isNotEmpty)
                                            ? h.images!.first
                                            : "",
                                      ),
                                    )
                                    .toList(),
                              ),

                            SizedBox(height: 100.h),
                          ],
                        ),
                      ),
                    ),
                  ],
                );
              }
              return const SizedBox();
            },
          ),
        ),
      ),
    );
  }
}

class GuideSectionItem {
  final String title;
  final String subTitle;
  final String imageUrl;

  GuideSectionItem({
    required this.title,
    required this.subTitle,
    required this.imageUrl,
  });
}
