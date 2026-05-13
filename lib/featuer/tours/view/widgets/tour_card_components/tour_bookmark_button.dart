import 'package:flutter/material.dart';
import 'package:flutter_application_1/featuer/tours/data/model/get_all_tours_model.dart';
import 'package:flutter_application_1/featuer/tours/manager/tours_cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

class TourBookmarkButton extends StatelessWidget {
  final TourItem tour;
  const TourBookmarkButton({super.key, required this.tour});

  @override
  Widget build(BuildContext context) {
    final bool isBookmarked = tour.isSaved ?? false;

    return GestureDetector(
      onTap: () {
        context.read<ToursCubit>().toggleSaveTour(tour.sId ?? tour.id ?? "");
      },
      child: isBookmarked
          ? Container(
              width: 32.w,
              height: 32.w,
              decoration: BoxDecoration(
                color: Colors.black.withOpacity(0.4),
                shape: BoxShape.circle,
              ),
              child: Center(
                child: SvgPicture.asset('assets/icon/filled.svg', width: 16.w),
              ),
            )
          : Container(
              width: 32.w,
              height: 32.w,
              decoration: const BoxDecoration(shape: BoxShape.circle),
              child: Center(
                child: SvgPicture.asset(
                  'assets/icon/bookmark-02 (1).svg',
                  width: 20.w,
                  colorFilter: const ColorFilter.mode(
                    Colors.white,
                    BlendMode.srcIn,
                  ),
                ),
              ),
            ),
    );
  }
}
