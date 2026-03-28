import 'package:flutter/material.dart';
import 'package:flutter_application_1/core/router/routes.dart';
import 'package:flutter_application_1/featuer/onboarding/circal_btn_widgets.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../core/theme/app_color.dart';
import '../../core/theme/app_text_style.dart';
import 'onboarding_page_widget.dart';
import 'onboarding_data.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _pageController = PageController();
  int _currentPage = 0;

  double get progressValue => (_currentPage + 1) / onboardingPages.length;

  void _onPageChanged(int page) {
    setState(() {
      _currentPage = page;
    });
  }

  void _navigateToNext() {
    Navigator.pushReplacementNamed(context, Routes.loginView);
  }

  void _nextPage() {
    if (_currentPage < onboardingPages.length - 1) {
      _pageController.nextPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    } else {
      _navigateToNext();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Background Image
          Image.asset(
            'assets/photo/onboarding.png',
            height: double.infinity,
            width: double.infinity,
            fit: BoxFit.cover,
          ),
          // Gradient Overlay for readability
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Colors.black.withOpacity(0.1),
                  Colors.black.withOpacity(0.5),
                  AppColor.primaryBlue3.withOpacity(0.9), // Deep Navy for contrast
                ],
                stops: const [0.0, 0.4, 1.0],
              ),
            ),
          ),
          SafeArea(
            child: Column(
              children: [
                Expanded(
                  child: PageView.builder(
                    controller: _pageController,
                    onPageChanged: _onPageChanged,
                    itemCount: onboardingPages.length,
                    itemBuilder: (_, index) =>
                        OnboardingPageWidget(page: onboardingPages[index]),
                  ),
                ),

                // Indicators
                SmoothPageIndicator(
                  controller: _pageController,
                  count: onboardingPages.length,
                  effect: ExpandingDotsEffect(
                    activeDotColor: Colors.white,
                    dotColor: Colors.white.withOpacity(0.3),
                    dotHeight: 8.h,
                    dotWidth: 8.w,
                    expansionFactor: 4,
                    spacing: 8.w,
                  ),
                ),

                SizedBox(height: 40.h),

                // Bottom Controls
                Padding(
                  padding: EdgeInsets.fromLTRB(32.w, 0, 32.w, 32.h),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      // زر تخطي
                      if (_currentPage < onboardingPages.length - 1)
                        TextButton(
                          onPressed: _navigateToNext,
                          child: Text(
                            'تخطي',
                            style: AppTextStyle.setelMessiriWhite(
                              fontSize: 18.sp,
                              fontWeight: FontWeight.w600,
                            ).copyWith(
                              decoration: TextDecoration.underline,
                              decorationColor: Colors.white,
                            ),
                          ),
                        )
                      else
                        const SizedBox(width: 48),
                      CircularNextButton(
                        progress: progressValue,
                        onTap: _nextPage,
                      ),
                    ],
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
