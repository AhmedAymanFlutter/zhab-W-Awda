class OnboardingPage {
  final String title;
  final String description;
  final String illustrationPath;

  const OnboardingPage({
    required this.title,
    required this.description,
    required this.illustrationPath,
  });
}

final List<OnboardingPage> onboardingPages = [
  const OnboardingPage(
    title: 'اكتشف وجهات جديدة',
    description:
        'تصفح أفضل الأماكن السياحية والفنادق الفاخرة في مصر وخارجها بسهولة.',
    illustrationPath: 'assets/photo/onboarding1.png',
  ),
  const OnboardingPage(
    title: 'حجوزات بضغطة زر',
    description:
        'احجز رحلتك، فندقك، وجولاتك السياحية في دقائق من مكان واحد بأفضل الأسعار.',
    illustrationPath: 'assets/photo/onboarding2.png',
  ),
  const OnboardingPage(
    title: 'استمتع برحلة لا تُنسى',
    description:
        'عش تجربة سفر مميزة مع برامج سياحية منظمة وخدمة عملاء معك طوال الرحلة.',
    illustrationPath: 'assets/photo/onboarding3.png',
  ),
];
