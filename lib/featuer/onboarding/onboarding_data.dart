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
    // مقترح للصورة: شخص ينظر لخريطة أو يحمل حقيبة سفر
    illustrationPath: 'assets/photo/onboarding1.png',
  ),
  const OnboardingPage(
    title: 'حجوزات بضغطة زر',
    description:
        'احجز رحلتك، فندقك، وجولاتك السياحية في دقائق من مكان واحد بأفضل الأسعار.',
    // مقترح للصورة: شخص يمسك موبايل وفيه علامة صح أو طائرة
    illustrationPath: 'assets/photo/onboarding2.png',
  ),
  const OnboardingPage(
    title: 'استمتع برحلة لا تُنسى',
    description:
        'عش تجربة سفر مميزة مع برامج سياحية منظمة وخدمة عملاء معك طوال الرحلة.',
    // مقترح للصورة: شخص يلتقط صورة سيلفي أو مسترخي على الشاطئ
    illustrationPath: 'assets/photo/onboarding3.png',
  ),
];
