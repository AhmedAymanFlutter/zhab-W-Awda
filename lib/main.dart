import 'package:flutter/material.dart';
import 'package:flutter_application_1/core/router/app_router.dart';
import 'package:flutter_application_1/core/router/routes.dart';
import 'package:flutter_application_1/core/theme/app_color.dart';
import 'package:flutter_application_1/featuer/Auth/manager/user_cubit.dart';
import 'package:flutter_application_1/featuer/home/view/offer/data/repo/offers_repository.dart.dart';
import 'package:flutter_application_1/featuer/home/view/offer/manager/offers_cubit.dart';
import 'package:flutter_application_1/featuer/home/view/package/data/repo/package_repo.dart';
import 'package:flutter_application_1/featuer/home/view/package/manager/packages_cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

void main() {
  runApp(MyApp(appRouter: AppRouter()));
}

class MyApp extends StatelessWidget {
  final AppRouter appRouter;

  const MyApp({super.key, required this.appRouter});

  @override
  Widget build(BuildContext context) {
    // Initialize ScreenUtil for responsive design (using .sp)
    return ScreenUtilInit(
      designSize: const Size(
        375,
        812,
      ), // Standard iPhone design size, adjust if needed
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return MultiBlocProvider(
          providers: [
            BlocProvider(
              create: (context) =>
                  OffersCubit(OffersRepository())..fetchOffers(),
            ),
            BlocProvider(
              create: (context) =>
                  PackagesCubit(PackagesRepository())..fetchPackages(),
            ),
            BlocProvider(create: (context) => UserCubit()..loadUser()),
          ],
          child: MaterialApp(
            title: 'Zhab W Auda',
            debugShowCheckedModeBanner: false,
            theme: ThemeData(
              fontFamily: 'elMessiri',
              primaryColor: AppColor.primaryBlue,
              scaffoldBackgroundColor: AppColor.mainWhite,
              useMaterial3: true,
            ),
            // Connect Routing
            initialRoute: Routes.splash,
            onGenerateRoute: appRouter.onGenerateRoute,
          ),
        );
      },
    );
  }
}
