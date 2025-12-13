import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/core/router/routes.dart';
import 'package:flutter_application_1/core/widgets/cusstom_search_bar.dart';
import 'package:flutter_application_1/featuer/home/view/offer/data/repo/offers_repository.dart.dart';
import 'package:flutter_application_1/featuer/home/view/offer/manager/offers_cubit.dart';
import 'package:flutter_application_1/featuer/home/view/offer/manager/offers_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:skeletonizer/skeletonizer.dart';
import '../../../../core/theme/app_color.dart';
import '../../../../core/theme/app_text_style.dart';

class OffersView extends StatelessWidget {
  const OffersView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => OffersCubit(OffersRepository())..fetchOffers(),
      child: Scaffold(
        backgroundColor: AppColor.primaryWhite,
        appBar: AppBar(
          backgroundColor: AppColor.primaryWhite,
          elevation: 0,
          centerTitle: true,
          title: Text(
            'العروض',
            style: AppTextStyle.setelMessiriTextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: AppColor.primaryBlue,
            ),
          ),
          leading: IconButton(
            icon: const Icon(Icons.arrow_back, color: AppColor.primaryBlue),
            onPressed: () => Navigator.pop(context),
          ),
        ),
        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w),
          child: Column(
            children: [
              SizedBox(height: 16.h),

              // --- Search Bar ---
              Builder(
                builder: (context) {
                  return ReusableSearchBar(
                    hintText: "بحث عن عروض...",
                    useDebounce: true,
                    onFilterTap: () {},
                    onSearchChanged: (value) {
                      OffersCubit.get(context).searchLocalOffers(value);
                    },
                  );
                },
              ),

              SizedBox(height: 16.h),

              // --- Offer List ---
              Expanded(
                child: BlocBuilder<OffersCubit, OffersState>(
                  builder: (context, state) {
                    if (state is OffersListLoading) {
                      return Skeletonizer(
                        enabled: true,
                        child: ListView.separated(
                          physics: const BouncingScrollPhysics(),
                          itemCount: 5,
                          separatorBuilder: (context, index) =>
                              SizedBox(height: 12.h),
                          itemBuilder: (context, index) {
                            return Container(
                              height: 180.h,
                              decoration: BoxDecoration(
                                color: Colors.grey[300],
                                borderRadius: BorderRadius.circular(16.r),
                              ),
                            );
                          },
                        ),
                      );
                    } else if (state is OffersListError) {
                      return Center(child: Text(state.message));
                    } else if (state is OffersListSuccess) {
                      if (state.offers.isEmpty) {
                        return const Center(
                          child: Text("لا توجد عروض مطابقة للبحث"),
                        );
                      }

                      return ListView.separated(
                        physics: const BouncingScrollPhysics(),
                        itemCount: state.offers.length,
                        separatorBuilder: (context, index) =>
                            SizedBox(height: 12.h),
                        itemBuilder: (context, index) {
                          // 2. Use 'state.offers' (from Cubit) instead of 'offers' (class variable)
                          final offer = state.offers[index];

                          // 3. Wrap Stack in Container to give it Height
                          return InkWell(
                            onTap: () {
                              Navigator.pushNamed(
                                context,
                                Routes.offerDetailsView,
                                arguments: offer.sId,
                              );
                            },
                            child: Container(
                              height: 180.h, // Fixed height for the card
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(16.r),
                                color: Colors.black, // Fallback color
                              ),
                              child: Stack(
                                children: [
                                  // Background Image
                                  Positioned.fill(
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(16.r),
                                      child: CachedNetworkImage(
                                        imageUrl:
                                            offer.imageCover ??
                                            "https://images.unsplash.com/photo-1476514525535-07fb3b4ae5f1?auto=format&fit=crop&w=500&q=80",
                                        fit: BoxFit.cover,
                                        // Dark overlay to make text readable
                                        color: Colors.black.withOpacity(0.4),
                                        colorBlendMode: BlendMode.darken,
                                        placeholder: (context, url) =>
                                            const Center(
                                              child: Icon(
                                                FontAwesomeIcons.image,
                                                color: Colors.white,
                                              ),
                                            ),
                                        errorWidget: (context, url, error) =>
                                            const Icon(
                                              FontAwesomeIcons
                                                  .circleExclamation,
                                              color: Colors.white,
                                            ),
                                      ),
                                    ),
                                  ),

                                  // Offer Name (Centered)
                                  Center(
                                    child: Padding(
                                      padding: EdgeInsets.symmetric(
                                        horizontal: 8.w,
                                      ),
                                      child: Text(
                                        offer.name ?? "عرض خاص",
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 18.sp,
                                          fontWeight: FontWeight.bold,
                                          shadows: [
                                            Shadow(
                                              offset: const Offset(0, 1),
                                              blurRadius: 3.0,
                                              color: Colors.black.withOpacity(
                                                0.7,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),

                                  // Price (Bottom Right)
                                  Positioned(
                                    bottom: 12.h,
                                    right: 12.w,
                                    child: Container(
                                      padding: EdgeInsets.symmetric(
                                        horizontal: 8.w,
                                        vertical: 4.h,
                                      ),
                                      decoration: BoxDecoration(
                                        color: AppColor.primaryBlue.withOpacity(
                                          0.9,
                                        ),
                                        borderRadius: BorderRadius.circular(
                                          8.r,
                                        ),
                                      ),
                                      child: Text(
                                        "${offer.price} ج.م",
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 14.sp,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
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
    );
  }
}
