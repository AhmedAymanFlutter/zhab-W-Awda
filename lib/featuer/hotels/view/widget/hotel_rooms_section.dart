import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/featuer/hotels/data/model/get_hotel_details_model.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../../../core/theme/app_color.dart';
import '../../../../core/theme/app_text_style.dart';
import 'package:flutter_application_1/core/utils/whatsapp_helper.dart';
import 'package:flutter_application_1/featuer/global_setting/manager/settings_cubit.dart';
import 'package:flutter_application_1/featuer/global_setting/manager/settings_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HotelRoomsSection extends StatelessWidget {
  final List<Rooms>? rooms;
  final String? hotelName;

  const HotelRoomsSection({super.key, this.rooms, this.hotelName});

  void _launchWhatsAppRoom(BuildContext context, Rooms room) {
    final settingsState = context.read<SettingsCubit>().state;
    String phoneNumber = "+201090124803"; // Default fallback

    if (settingsState is SettingsSuccess) {
      final whatsAppSetting = settingsState.settings.socialMedia?.whatsApp;
      if (whatsAppSetting != null && whatsAppSetting.url != null) {
        phoneNumber = whatsAppSetting.url!.replaceAll(RegExp(r'[^0-9+]'), '');
      }
    }

    WhatsAppHelper.launchWhatsApp(
      phone: phoneNumber,
      message:
          "مرحباً، أود الاستفسار عن حجز غرفة: ${room.title ?? 'غير محدد'} في فندق: ${hotelName ?? 'غير محدد'}",
    );
  }

  @override
  Widget build(BuildContext context) {
    if (rooms == null || rooms!.isEmpty) return const SizedBox.shrink();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Container(
              padding: EdgeInsets.all(8.w),
              decoration: BoxDecoration(
                color: const Color(0xFFE8EDF2),
                borderRadius: BorderRadius.circular(8.r),
              ),
              child: Icon(
                Icons.hotel_outlined,
                color: AppColor.primaryBlue,
                size: 20.sp,
              ),
            ),
            SizedBox(width: 12.w),
            Text(
              "الغرف",
              style: AppTextStyle.setelMessiriBlack(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const Spacer(),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 6.h),
              decoration: BoxDecoration(
                border: Border.all(color: AppColor.primaryBlue),
                borderRadius: BorderRadius.circular(20.r),
              ),
              child: Row(
                children: [
                  Icon(Icons.sort, color: AppColor.primaryBlue, size: 16.sp),
                  SizedBox(width: 4.w),
                  Text(
                    "ترتيب حسب السعر",
                    style: TextStyle(
                      fontSize: 12.sp,
                      color: AppColor.primaryBlue,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        SizedBox(height: 16.h),
        ListView.separated(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: rooms!.length,
          separatorBuilder: (context, index) => SizedBox(height: 12.h),
          itemBuilder: (context, index) =>
              _buildRoomCard(context, rooms![index]),
        ),
      ],
    );
  }

  Widget _buildRoomCard(BuildContext context, Rooms room) {
    return Container(
      padding: EdgeInsets.only(top: 6.h, bottom: 6.h, right: 4.w, left: 4.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8.r),
        boxShadow: const [
          BoxShadow(
            color: Color(0x17000000),
            blurRadius: 2,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          // Image on the Right (in RTL)
          ClipRRect(
            borderRadius: BorderRadius.circular(8.r),
            child: CachedNetworkImage(
              imageUrl: room.image ?? "",
              width: 70.w,
              height: 70.h,
              fit: BoxFit.cover,
              errorWidget: (context, url, error) => Container(
                color: Colors.grey[200],
                width: 70.w,
                height: 70.h,
                child: const Icon(Icons.image_not_supported_outlined),
              ),
            ),
          ),
          SizedBox(width: 12.w),
          // Content in the middle
          Expanded(
            flex: 2,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  room.title ?? "غرفة ديلوكس مطلة على المدينة",
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontSize: 13.sp,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
                Text(
                  "جناح فاخر على البحر",
                  style: TextStyle(fontSize: 11.sp, color: Colors.grey[600]),
                ),
                SizedBox(height: 4.h),
                Row(
                  children: [
                    Icon(Icons.people_outline, size: 12.sp, color: Colors.grey),
                    SizedBox(width: 2.w),
                    Text(
                      "${room.maxAdults} بالغين",
                      style: TextStyle(fontSize: 10.sp, color: Colors.grey),
                    ),
                    SizedBox(width: 8.w),
                    Icon(Icons.square_foot, size: 12.sp, color: Colors.grey),
                    SizedBox(width: 2.w),
                    Text(
                      "${room.area} م²",
                      style: TextStyle(fontSize: 10.sp, color: Colors.grey),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Icon(Icons.money_off, size: 12.sp, color: Colors.green),
                    SizedBox(width: 2.w),
                    Text(
                      "مستردة",
                      style: TextStyle(fontSize: 10.sp, color: Colors.green),
                    ),
                  ],
                ),
              ],
            ),
          ),
          // Price and Button on the left
          Expanded(
            flex: 1,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                FittedBox(
                  fit: BoxFit.scaleDown,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text(
                        "ابتداءً من ",
                        style: TextStyle(fontSize: 10.sp, color: Colors.black),
                      ),
                      Text(
                        "${room.price}",
                        style: TextStyle(
                          fontSize: 16.sp,
                          fontWeight: FontWeight.bold,
                          color: AppColor.primaryBlue,
                        ),
                      ),
                      SizedBox(width: 2.w),
                      SvgPicture.asset(
                        'assets/icon/RSA.svg',
                        height: 14.h,
                        colorFilter: const ColorFilter.mode(
                          AppColor.primaryBlue,
                          BlendMode.srcIn,
                        ),
                      ),
                      Text(
                        " /ليلة",
                        style: TextStyle(fontSize: 10.sp, color: Colors.black),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 8.h),
                InkWell(
                  onTap: () => _launchWhatsAppRoom(context, room),
                  borderRadius: BorderRadius.circular(25.r),
                  child: Container(
                    width: double.infinity,
                    padding: EdgeInsets.symmetric(vertical: 8.h),
                    decoration: BoxDecoration(
                      color: AppColor.primaryBlue,
                      borderRadius: BorderRadius.circular(25.r),
                    ),
                    child: Center(
                      child: Text(
                        "احجز الآن",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 13.sp,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
