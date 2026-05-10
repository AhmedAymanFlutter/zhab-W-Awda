import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/theme/app_text_style.dart';

class PrivacyView extends StatelessWidget {
  const PrivacyView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF2F4F7),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        automaticallyImplyLeading: false,
        title: InkWell(
          onTap: () => Navigator.pop(context),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Text(
                "سياسة الخصوصية",
                style: AppTextStyle.setelMessiriBlack(
                  fontSize: 18.sp,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(width: 8.w),
              Icon(
                Icons.arrow_forward_ios,
                size: 18.sp,
                color: const Color(0xFF1A1A1A),
              ),
            ],
          ),
        ),
      ),
      body: SafeArea(
        child: Directionality(
          textDirection: TextDirection.rtl,
          child: Column(
            children: [
              SizedBox(height: 10.h),

              Expanded(
                child: SingleChildScrollView(
                  padding: EdgeInsets.symmetric(
                    horizontal: 15.w,
                    vertical: 10.h,
                  ),
                  child: Container(
                    width: 345.w,
                    padding: EdgeInsets.all(20.w),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(13.r),
                      border: Border.all(
                        color: const Color(0x121A1A1A),
                        width: 1,
                      ),
                      boxShadow: const [
                        BoxShadow(
                          color: Color(0x0D000000),
                          blurRadius: 4,
                          offset: Offset(0, 4),
                        ),
                      ],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "سياسة الخصوصية",
                          style: AppTextStyle.setelMessiriBlack(
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 12.h),
                        Text(
                          "نلتزم في ذهاب وعودة بحماية خصوصية المستخدمين، وتوضح هذه السياسة كيفية جمع البيانات الشخصية واستخدامها بطريقة آمنة تدعم تقديم خدمات أفضل.",
                          style: TextStyle(
                            fontSize: 14.sp,
                            color: Colors.grey[700],
                            height: 1.6,
                            fontFamily: 'ElMessiri',
                          ),
                        ),
                        SizedBox(height: 24.h),

                        _buildSection(
                          "1. البيانات التي نجمعها",
                          "نجمع المعلومات التي تقدمها مثل الاسم، رقم الهاتف، البريد الإلكتروني، وتفاصيل الحجز، بالإضافة إلى بعض البيانات التقنية التي تساعدنا على تحسين الخدمة.",
                        ),
                        _buildSection(
                          "2. استخدام البيانات",
                          "نستخدم البيانات لإتمام المحجوزات، إدارة الطلبات، تحسين تجربة المستخدم، والتواصل معك بخصوص الخدمات أو التحديثات.",
                        ),
                        _buildSection(
                          "3. حماية البيانات",
                          "نطبق إجراءات أمنية وتقنية للحفاظ على سرية بياناتك ومنع الوصول غير المصرح به أو استخدامها بشكل غير قانوني.",
                        ),
                        _buildSection(
                          "4. مشاركة البيانات",
                          "قد يتم مشاركة البيانات مع شركاء الخدمة مثل شركات الطيران أو الفنادق فقط لإتمام الحجز، أو عند الالتزام بالمتطلبات القانونية.",
                        ),
                        _buildSection(
                          "5. التعاقد والدفع",
                          "• يتم تحديد تفاصيل الأسعار وآليات الدفع لكل مشروع بشكل منفصل وفقاً للاتفاق بين الطرفين.\n• قد تختلف سياسات الدفع والاسترداد حسب نوع الخدمة المقدمة، ويتم توضيحها في الاتفاق الخاص بكل مشروع.",
                        ),
                        _buildSection(
                          "6. التعاقد والدفع",
                          "• يتم تحديد تفاصيل الأسعار وآليات الدفع لكل مشروع بشكل منفصل وفقاً للاتفاق بين الطرفين.\n• قد تختلف سياسات الدفع والاسترداد حسب نوع الخدمة المقدمة، ويتم توضيحها في الاتفاق الخاص بكل مشروع.",
                        ),
                        _buildSection(
                          "7. التحديث والتعديل",
                          "يحق لنا تعديل شروط الاستخدام في أي وقت، وتعد استمرارك في استخدام الموقع موافقة ضمنية على التعديلات.",
                        ),

                        SizedBox(height: 20.h),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSection(String title, String content) {
    return Padding(
      padding: EdgeInsets.only(bottom: 24.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: AppTextStyle.setelMessiriBlack(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 8.h),
          Text(
            content,
            style: TextStyle(
              fontSize: 14.sp,
              color: Colors.grey[700],
              height: 1.6,
              fontFamily: 'ElMessiri',
            ),
          ),
        ],
      ),
    );
  }
}
