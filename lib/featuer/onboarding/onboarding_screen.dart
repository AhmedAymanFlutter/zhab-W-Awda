import 'package:flutter/material.dart';
import 'package:flutter_application_1/core/router/routes.dart';
import 'package:flutter_application_1/featuer/onboarding/circal_btn_widgets.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import '../../core/theme/app_color.dart';
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
    // هنا وجه المستخدم لصفحة تسجيل الدخول أو الرئيسية
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
      backgroundColor: Colors.white,
      body: SafeArea(
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
              effect: const ExpandingDotsEffect(
                activeDotColor: AppColor.primaryBlue,
                dotColor: Color(0xFFD9D9D9),
                dotHeight: 8,
                dotWidth: 8,
                expansionFactor: 3,
                spacing: 6,
              ),
            ),

            const SizedBox(height: 48),

            // Bottom Controls
            Padding(
              padding: const EdgeInsets.fromLTRB(24, 0, 24, 32),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // زر تخطي
                  if (_currentPage < onboardingPages.length - 1)
                    TextButton(
                      onPressed: _navigateToNext,
                      child: Text(
                        'تخطي',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                          color: AppColor.primaryBlue,
                          fontFamily: 'elMessiri',
                          decoration: TextDecoration.underline,
                        ),
                      ),
                    )
                  else
                    const SizedBox(width: 48),

                  // الزر الدائري (تأكد إن الويدجت دي موجودة عندك)
                  CircularNextButton(progress: progressValue, onTap: _nextPage),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
