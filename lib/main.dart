import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/core/network/api_endpoiont.dart';
import 'package:flutter_application_1/core/network/local_data.dart';
import 'package:flutter_application_1/core/router/app_router.dart';
import 'package:flutter_application_1/core/router/routes.dart';
import 'package:flutter_application_1/core/theme/app_color.dart';
import 'package:flutter_application_1/core/di/dependency_injection.dart';
import 'package:flutter_application_1/featuer/Auth/manager/user_cubit.dart';
import 'package:flutter_application_1/featuer/global_setting/manager/settings_cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_sign_in/google_sign_in.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await LocalData.loadTokens();
  await GoogleSignIn.instance.initialize(
    clientId: defaultTargetPlatform == TargetPlatform.android
        ? null
        : EndPoints.clientId,
    serverClientId: EndPoints.clientId,
  );
  setupDI();
  runApp(MyApp(appRouter: AppRouter()));
}

class MyApp extends StatelessWidget {
  final AppRouter appRouter;
  const MyApp({super.key, required this.appRouter});
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(375, 812),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return MultiBlocProvider(
          providers: [
            BlocProvider(
              create: (context) => getIt<UserCubit>(),
              lazy: false,
            ),
            BlocProvider(
              create: (context) => getIt<SettingsCubit>(),
            ),
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
            initialRoute: Routes.splash,
            onGenerateRoute: appRouter.onGenerateRoute,
          ),
        );
      },
    );
  }
}
