import 'package:erp_easy_chat_state/config/light_theme_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'pages/splash/views/splash_view.dart';

Future<void> main() async {
  // wait for bindings
  WidgetsFlutterBinding.ensureInitialized();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
        designSize: const Size(375, 812),
        minTextAdapt: true,
        splitScreenMode: true,
        useInheritedMediaQuery: true,
        rebuildFactor: (old, data) => true,
        builder: (context, widget) {
          return MaterialApp(
            title: 'ERP Chat',
            useInheritedMediaQuery: true,
            debugShowCheckedModeBanner: false,
            theme: ThemeData(
              primaryColor: LightThemeColors.primaryColor,
              colorScheme: ColorScheme.fromSwatch(accentColor: LightThemeColors.accentColor),
              appBarTheme: const AppBarTheme(
                elevation: 0
              )
            ),
            home: const SplashView(),
          );
        });
  }
}

