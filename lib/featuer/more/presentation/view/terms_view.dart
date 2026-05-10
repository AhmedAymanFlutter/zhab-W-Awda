import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/theme/app_text_style.dart';

class TermsView extends StatelessWidget {
  const TermsView({super.key});

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
                "الشروط والأحكام",
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
                          "الشروط والأحكام",
                          style: AppTextStyle.setelMessiriBlack(
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 12.h),
                        Text(
                          "توضح هذه الصفحة القواعد والشروط المنظمة لاستخدام خدمات ذهاب وعودة، وذلك لضمان تجربة حجز واضحة وآمنة، مع تحديد حقوق والتزامات جميع المستخدمين.",
                          style: TextStyle(
                            fontSize: 14.sp,
                            color: Colors.grey[700],
                            height: 1.6,
                            fontFamily: 'ElMessiri',
                          ),
                        ),
                        SizedBox(height: 24.h),

                        _buildSection(
                          "1. الحجز والتأكيد",
                          "يتم تأكيد الحجز بعد إدخال البيانات المطلوبة بدقة وإتمام عملية الدفع بنجاح، وسيتم إرسال تفاصيل الحجز عبر الوسيلة المحددة، ويجب مراجعتها فور الاستلام.",
                        ),
                        _buildSection(
                          "2. الأسعار والدفع",
                          "تعتمد الأسعار على التوفر وقد تختلف حسب وقت الحجز أو التحديثات من مزودي الخدمة، ويتم عرض السعر النهائي قبل الدفع بشكل واضح ولا يتم تأكيد الحجز إلا بعد السداد.",
                        ),
                        _buildSection(
                          "3. التعديلات",
                          "يمكن تعديل الحجز في بعض الحالات وفق الشروط المتاحة، وقد يتم تطبيق رسوم إضافية حسب نوع التعديل وتوقيته ومدى توفر الخدمة.",
                        ),
                        _buildSection(
                          "4. الإلغاء",
                          "تخضع طلبات الإلغاء لسياسات مزودي الخدمة، وقد تختلف شروط الاسترداد من حجز لآخر، لذلك يُنصح بالاطلاع على التفاصيل قبل تأكيد الحجز.",
                        ),
                        _buildSection(
                          "5. مسؤولية المستخدم",
                          "يتحمل المستخدم مسؤولية صحة جميع البيانات المدخلة، وكذلك استيفاء متطلبات السفر من جواز سفر وتأشيرات وأي مستندات رسمية أخرى.",
                        ),
                        _buildSection(
                          "6. إخلاء المسؤولية",
                          "• لا تتحمل ذهاب وعودة أي مسؤولية عن التأخيرات أو التغييرات الناتجة عن ظروف خارجة عن السيطرة مثل الأحوال الجوية أو قرارات الجهات الرسمية أو شركات النقل.\n• لا تتحمل ذهاب وعودة أي مسؤولية عن التأخيرات أو التغييرات الناتجة عن ظروف خارجة.",
                        ),
                        _buildSection(
                          "7. استخدام الموقع",
                          "يجب استخدام الموقع بشكل قانوني ومسؤول، ويُمنع إساءة استخدام الخدمات أو محاولة الوصول غير المصرح به إلى أي جزء من النظام.",
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
