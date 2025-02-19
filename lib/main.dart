import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'core/DI/initializing_dependency.dart';

import 'core/services/shared_pref/shared_pref.dart';
import 'core/utils/app_routes.dart';
import 'core/utils/app_theme.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SharedPref().instantiatePreferences();

  InitializingDependency();
  HttpOverrides.global = MyHttpOverrides();

  runApp(const MyApp());
}

final GlobalKey<NavigatorState> navigatorkey = GlobalKey<NavigatorState>();

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(360, 690),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return GetMaterialApp(
          themeMode: ThemeMode.dark,
          theme: AqarTheme.darkTheme,
          title: 'PureHeart',
          debugShowCheckedModeBanner: false,
          getPages: AppRoutes.routes,
          initialRoute: getInitialRoute(),
          initialBinding: InitializingDependency(),
        );
      },
    );
  }
}

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}
