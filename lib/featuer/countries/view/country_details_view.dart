import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/core/widgets/html_content_widget.dart';
import 'package:flutter_application_1/featuer/countries/manager/countries_cubit.dart';
import 'package:flutter_application_1/featuer/countries/manager/countries_state.dart';
import 'package:flutter_application_1/core/widgets/offer_booking_bar.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/theme/app_color.dart';
import '../../../../core/theme/app_text_style.dart';
import '../data/repo/countries_repository.dart';

class CountryDetailsView extends StatelessWidget {
  final String countrySlug;

  const CountryDetailsView({super.key, required this.countrySlug});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          CountriesCubit(CountriesRepository())..getCountryDetails(countrySlug),
      child: Scaffold(
        bottomNavigationBar: OfferBookingBar(),
        backgroundColor: const Color(0xFFF8F9FB),
        body: BlocBuilder<CountriesCubit, CountriesState>(
          builder: (context, state) {
            if (state is CountryDetailsLoading) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is CountryDetailsError) {
              return Center(child: Text(state.message));
            } else if (state is CountryDetailsSuccess) {
              final country = state.country;

              return CustomScrollView(
                physics: const BouncingScrollPhysics(),
                slivers: [
                  // --- Header Image with Parallax ---
                  SliverAppBar(
                    expandedHeight: 400.h,
                    pinned: true,
                    stretch: true,
                    backgroundColor: AppColor.primaryBlue,
                    leading: Container(
                      margin: EdgeInsets.all(8.w),
                      decoration: BoxDecoration(
                        color: Colors.black.withOpacity(0.2),
                        shape: BoxShape.circle,
                      ),
                      child: IconButton(
                        icon: const Icon(Icons.arrow_back_ios_new, color: Colors.white, size: 20),
                        onPressed: () => Navigator.pop(context),
                      ),
                    ),
                    flexibleSpace: FlexibleSpaceBar(
                      stretchModes: const [
                        StretchMode.zoomBackground,
                        StretchMode.blurBackground,
                      ],
                      background: Stack(
                        fit: StackFit.expand,
                        children: [
                          CachedNetworkImage(
                            imageUrl: country.imageCover ?? "https://via.placeholder.com/800",
                            fit: BoxFit.cover,
                            placeholder: (context, url) => Container(color: Colors.grey[200]),
                            errorWidget: (context, url, error) => const Icon(Icons.error),
                          ),
                          DecoratedBox(
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                begin: Alignment.topCenter,
                                end: Alignment.bottomCenter,
                                colors: [
                                  Colors.black.withOpacity(0.3),
                                  Colors.transparent,
                                  Colors.black.withOpacity(0.7),
                                ],
                              ),
                            ),
                          ),
                          Positioned(
                            bottom: 40.h,
                            left: 20.w,
                            right: 20.w,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 6.h),
                                  decoration: BoxDecoration(
                                    color: AppColor.primaryBlue,
                                    borderRadius: BorderRadius.circular(20.r),
                                  ),
                                  child: Text(
                                    country.continent ?? "وجهة سياحية",
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 12.sp,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                                SizedBox(height: 12.h),
                                Text(
                                  country.name ?? "اسم الدولة",
                                  style: AppTextStyle.setelMessiriBlack(
                                    fontSize: 32,
                                    fontWeight: FontWeight.bold,
                                  ).copyWith(color: Colors.white),
                                ),
                                if (country.code != null) ...[
                                  SizedBox(height: 4.h),
                                  Text(
                                    "رمز الدولة: ${country.code}",
                                    style: TextStyle(
                                      color: Colors.white.withOpacity(0.8),
                                      fontSize: 14.sp,
                                    ),
                                  ),
                                ],
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),

                  // --- Details Content ---
                  SliverToBoxAdapter(
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.vertical(top: Radius.circular(30.r)),
                      ),
                      child: Padding(
                        padding: EdgeInsets.all(24.w),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // Quick Info Grid
                            Container(
                              padding: EdgeInsets.all(20.w),
                              decoration: BoxDecoration(
                                color: const Color(0xFFF8F9FB),
                                borderRadius: BorderRadius.circular(24.r),
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceAround,
                                children: [
                                  _buildModernInfoItem(Icons.language_rounded, "اللغة", country.language ?? "-"),
                                  _buildDivider(),
                                  _buildModernInfoItem(Icons.currency_exchange_rounded, "العملة", country.currency ?? "-"),
                                  _buildDivider(),
                                  _buildModernInfoItem(Icons.calendar_month_rounded, "أفضل شهر", country.favMonth?.isNotEmpty == true ? country.favMonth!.first : "-"),
                                ],
                              ),
                            ),
                            
                            SizedBox(height: 32.h),
                            
                            // Description Section
                            Text(
                              "عن الدولة",
                              style: AppTextStyle.setelMessiriBlack(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(height: 12.h),
                            HtmlContentWidget(
                              htmlContent: country.description ?? country.descText ?? "لا يوجد وصف متاح حالياً لهذه الدولة.",
                              fontSize: 15.sp,
                            ),
                            
                            SizedBox(height: 32.h),
                            
                            // Best Time to Visit Chips
                            if (country.favTime?.isNotEmpty == true) ...[
                              Text(
                                "أفضل وقت للزيارة",
                                style: AppTextStyle.setelMessiriBlack(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              SizedBox(height: 16.h),
                              Wrap(
                                spacing: 10.w,
                                runSpacing: 10.h,
                                children: country.favTime!.map((time) => Container(
                                  padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
                                  decoration: BoxDecoration(
                                    color: AppColor.primaryBlue.withOpacity(0.05),
                                    borderRadius: BorderRadius.circular(12.r),
                                    border: Border.all(color: AppColor.primaryBlue.withOpacity(0.1)),
                                  ),
                                  child: Text(
                                    time,
                                    style: TextStyle(
                                      color: AppColor.primaryBlue,
                                      fontWeight: FontWeight.w600,
                                      fontSize: 14.sp,
                                    ),
                                  ),
                                )).toList(),
                              ),
                            ],
                            
                            SizedBox(height: 100.h), // Space for bottom bar
                          ],
                        ),
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
    );
  }

  Widget _buildModernInfoItem(IconData icon, String label, String value) {
    return Column(
      children: [
        Icon(icon, color: AppColor.primaryBlue, size: 24.sp),
        SizedBox(height: 8.h),
        Text(
          label,
          style: TextStyle(
            fontSize: 12.sp,
            color: Colors.grey.shade600,
            fontWeight: FontWeight.w500,
          ),
        ),
        SizedBox(height: 4.h),
        Text(
          value,
          style: TextStyle(
            fontSize: 14.sp,
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }

  Widget _buildDivider() {
    return Container(
      width: 1,
      height: 40.h,
      color: Colors.grey.withOpacity(0.2),
    );
  }
}
