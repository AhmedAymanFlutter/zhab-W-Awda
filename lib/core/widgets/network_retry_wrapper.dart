import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_application_1/core/theme/app_color.dart';
import 'package:flutter_application_1/core/theme/app_text_style.dart';

enum NetworkErrorType {
  none,
  noInternet,
  timeout,
  serverError,
}

class NetworkRetryWrapper extends StatefulWidget {
  final Widget child;
  final bool hasError;
  final String? errorMessage;
  final Future<void> Function() onRetry;
  final Widget? loadingWidget;

  const NetworkRetryWrapper({
    super.key,
    required this.child,
    required this.hasError,
    this.errorMessage,
    required this.onRetry,
    this.loadingWidget,
  });

  @override
  State<NetworkRetryWrapper> createState() => _NetworkRetryWrapperState();
}

class _NetworkRetryWrapperState extends State<NetworkRetryWrapper> {
  bool _isRetrying = false;

  NetworkErrorType get _errorType {
    if (!widget.hasError || widget.errorMessage == null) {
      return NetworkErrorType.none;
    }
    final message = widget.errorMessage!.toLowerCase();
    if (message.contains('مهلة') ||
        message.contains('timeout') ||
        message.contains('time out')) {
      return NetworkErrorType.timeout;
    }
    if (message.contains('اتصال') ||
        message.contains('connection') ||
        message.contains('internet') ||
        message.contains('offline')) {
      return NetworkErrorType.noInternet;
    }
    return NetworkErrorType.serverError;
  }

  Future<void> _handleRetry() async {
    if (_isRetrying) return;
    setState(() {
      _isRetrying = true;
    });

    try {
      await widget.onRetry();
    } catch (_) {
      // Errors should be caught by the parent's cubit/repository
    } finally {
      if (mounted) {
        setState(() {
          _isRetrying = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    if (!widget.hasError) {
      return widget.child;
    }

    final errorType = _errorType;
    String title = "خطأ في الاتصال";
    String description = "حدث خطأ غير معروف أثناء تحميل البيانات. يرجى المحاولة مرة أخرى.";
    IconData icon = Icons.wifi_off_rounded;
    Color iconBgColor = const Color(0xFFFEE4E2);
    Color iconColor = const Color(0xFFD92D20);

    if (errorType == NetworkErrorType.noInternet) {
      title = "لا يوجد اتصال بالإنترنت";
      description = "يبدو أنك غير متصل بالإنترنت حالياً. يرجى التحقق من اتصال شبكة Wi-Fi أو بيانات الهاتف والمحاولة مرة أخرى.";
      icon = Icons.wifi_off_rounded;
      iconBgColor = const Color(0xFFFEE4E2);
      iconColor = const Color(0xFFD92D20);
    } else if (errorType == NetworkErrorType.timeout) {
      title = "انتهت مهلة الطلب";
      description = "استغرق الخادم وقتاً أطول من المعتاد للاستجابة. يرجى التحقق من جودة الاتصال وإعادة المحاولة.";
      icon = Icons.hourglass_disabled_rounded;
      iconBgColor = const Color(0xFFFEF0C7);
      iconColor = const Color(0xFFDC6803);
    } else if (errorType == NetworkErrorType.serverError) {
      title = "عذراً، فشل التحميل";
      description = widget.errorMessage ?? "حدث خطأ أثناء جلب البيانات من السيرفر. يرجى المحاولة مرة أخرى.";
      icon = Icons.cloud_off_rounded;
      iconBgColor = const Color(0xFFECE9FF);
      iconColor = AppColor.lightPurple;
    }

    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FA),
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 24.w),
            child: TweenAnimationBuilder<double>(
              tween: Tween<double>(begin: 0.8, end: 1.0),
              duration: const Duration(milliseconds: 400),
              curve: Curves.elasticOut,
              builder: (context, val, child) {
                return Transform.scale(
                  scale: val,
                  child: child,
                );
              },
              child: Container(
                padding: EdgeInsets.all(24.w),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(24.r),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.04),
                      blurRadius: 20,
                      offset: const Offset(0, 10),
                    ),
                  ],
                  border: Border.all(
                    color: Colors.grey.withOpacity(0.1),
                    width: 1,
                  ),
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    // Icon with Pulsing Effect
                    Stack(
                      alignment: Alignment.center,
                      children: [
                        TweenAnimationBuilder<double>(
                          tween: Tween<double>(begin: 1.0, end: 1.2),
                          duration: const Duration(seconds: 2),
                          curve: Curves.easeInOut,
                          builder: (context, value, child) {
                            return Transform.scale(
                              scale: value,
                              child: Container(
                                width: 80.w,
                                height: 80.w,
                                decoration: BoxDecoration(
                                  color: iconBgColor.withOpacity(0.4),
                                  shape: BoxShape.circle,
                                ),
                              ),
                            );
                          },
                        ),
                        Container(
                          width: 64.w,
                          height: 64.w,
                          decoration: BoxDecoration(
                            color: iconBgColor,
                            shape: BoxShape.circle,
                          ),
                          child: Icon(
                            icon,
                            size: 32.sp,
                            color: iconColor,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 24.h),

                    // Title
                    Text(
                      title,
                      textAlign: TextAlign.center,
                      style: AppTextStyle.setelMessiriTextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        color: AppColor.mainBlack,
                      ),
                    ),
                    SizedBox(height: 12.h),

                    // Description
                    Text(
                      description,
                      textAlign: TextAlign.center,
                      style: AppTextStyle.setelMessiriTextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                        color: AppColor.secondeLightGrey,
                      ).copyWith(height: 1.5),
                    ),
                    SizedBox(height: 32.h),

                    // Retry Button
                    AnimatedContainer(
                      duration: const Duration(milliseconds: 200),
                      width: double.infinity,
                      height: 52.h,
                      child: ElevatedButton(
                        onPressed: _isRetrying ? null : _handleRetry,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColor.primaryBlue,
                          foregroundColor: Colors.white,
                          elevation: _isRetrying ? 0 : 3,
                          shadowColor: AppColor.primaryBlue.withOpacity(0.4),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16.r),
                          ),
                          disabledBackgroundColor: AppColor.primaryBlue.withOpacity(0.6),
                        ),
                        child: _isRetrying
                            ? SizedBox(
                                width: 24.w,
                                height: 24.w,
                                child: const CircularProgressIndicator(
                                  color: Colors.white,
                                  strokeWidth: 2.5,
                                ),
                              )
                            : Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(
                                    Icons.refresh_rounded,
                                    size: 20.sp,
                                    color: Colors.white,
                                  ),
                                  SizedBox(width: 8.w),
                                  Text(
                                    "إعادة المحاولة",
                                    style: AppTextStyle.setelMessiriTextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white,
                                    ),
                                  ),
                                ],
                              ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
