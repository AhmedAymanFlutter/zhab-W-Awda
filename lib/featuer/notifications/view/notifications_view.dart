import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/widgets/CustomHomeAppBar.dart';
import '../../../../core/theme/app_text_style.dart';
import 'widgets/notification_card.dart';

class NotificationsView extends StatelessWidget {
  const NotificationsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FA),
      appBar: CustomHomeAppBar(
        actions: [
          GestureDetector(
            onTap: () => Navigator.pop(context),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  "الاشعارات",
                  style: AppTextStyle.setelMessiriBlack(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(width: 10.w),
                Icon(Icons.arrow_forward_ios, size: 16.sp, color: Colors.black),
              ],
            ),
          ),
        ],
      ),
      body: ListView(
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 24.h),
        children: [
          Align(
            alignment: Alignment.centerRight,
            child: Text(
              "اليوم",
              style: AppTextStyle.setelMessiriBlack(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          SizedBox(height: 12.h),
          NotificationCard(
            title: "تذكير!",
            subtitle: "تبدأ رحلتك إلى دهب غدًا في الساعة 8:00 صباحًا",
            time: "11:20 صباحًا",
            iconBackgroundColor: const Color(0xFFFEF0C7),
            icon: Icon(
              Icons.info_outline,
              color: const Color(0xFFDC6803),
              size: 20.sp,
            ),
            isUnread: true, // Shows grey background
          ),
          SizedBox(height: 12.h),
          NotificationCard(
            title: "عرض جديد لك!",
            subtitle: "استمتع بخصم على وجهتك المفضلة لفترة محدودة.",
            time: "11:20 صباحًا",
            iconBackgroundColor: const Color(0xFFD1FADF),
            icon: Icon(
              Icons.discount_outlined,
              color: const Color(0xFF039855),
              size: 20.sp,
            ),
          ),
          SizedBox(height: 12.h),
          NotificationCard(
            title: "وجهات جديدة",
            subtitle: "تم إضافة وجهات سياحية جديدة تناسب اهتماماتك.",
            time: "11:20 صباحًا",
            iconBackgroundColor: const Color(0xFFE0F2FE),
            icon: Icon(
              Icons.map_outlined,
              color: const Color(0xFF026AA2),
              size: 20.sp,
            ),
          ),
          SizedBox(height: 24.h),
          Align(
            alignment: Alignment.centerRight,
            child: Text(
              "هذا الاسبوع",
              style: AppTextStyle.setelMessiriBlack(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          SizedBox(height: 12.h),
          NotificationCard(
            title: "وجهات جديدة",
            subtitle: "تم إضافة وجهات سياحية جديدة تناسب اهتماماتك.",
            time: "11:20 صباحًا",
            iconBackgroundColor: const Color(0xFFE0F2FE),
            icon: Icon(
              Icons.chat_bubble_outline,
              color: const Color(0xFF026AA2),
              size: 20.sp,
            ),
          ),
          SizedBox(height: 12.h),
          NotificationCard(
            title: "عرض جديد لك!",
            subtitle: "استمتع بخصم على وجهتك المفضلة لفترة محدودة.",
            time: "11:20 صباحًا",
            iconBackgroundColor: const Color(0xFFD1FADF),
            icon: Icon(
              Icons.discount_outlined,
              color: const Color(0xFF039855),
              size: 20.sp,
            ),
          ),
        ],
      ),
    );
  }
}
