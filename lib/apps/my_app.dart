import 'dart:math';

import 'package:flutter/services.dart';

import '../common/common.dart';
import '../pages/home_screen.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  //是否为平板判断
  bool isTablet(BuildContext context) {
    var size = MediaQuery.of(context).size;
    var diagonal =
        sqrt((size.width * size.width) + (size.height * size.height));
    var isTablet = diagonal > 1100.0; // 对角线长度的阈值来判断是否为平板
    return isTablet;
  }

  @override
  Widget build(BuildContext context) {
    if (isTablet(context)) {
      // 如果是平板，允许自动旋转
      SystemChrome.setPreferredOrientations([
        DeviceOrientation.portraitUp,
        DeviceOrientation.portraitDown,
        DeviceOrientation.landscapeLeft,
        DeviceOrientation.landscapeRight,
      ]);
    } else {
      // 如果是手机，禁用自动旋转
      SystemChrome.setPreferredOrientations([
        DeviceOrientation.portraitUp,
        DeviceOrientation.portraitDown,
      ]);
    }

    return ScreenUtilInit(
      designSize: Config.mobilSize,
      builder: (context, child) => MaterialApp(
        routes: Routes,
        title: 'Demo',
        debugShowCheckedModeBanner: true,
        theme: ThemeData(
          useMaterial3: true,
          colorScheme: ColorScheme.fromSeed(
            seedColor: const Color.fromARGB(255, 192, 166, 111),
            brightness: Brightness.light,
          ),
        ),
        darkTheme: ThemeData(
          useMaterial3: true,
          colorScheme: ColorScheme.fromSeed(
            seedColor: const Color.fromARGB(255, 226, 133, 26),
            brightness: Brightness.dark,
          ),
        ),
        // initialRoute: AppRoutes.menu,
        home: const HomeScreen(),
      ),
    );
  }
}
