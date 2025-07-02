import 'package:ahmed_shop/utils/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'routes/app_routes.dart';
import 'routes/app_routes_files.dart';

class MainAppEntry extends StatelessWidget {
  const MainAppEntry({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Ahmed Shop",
      enableLog: true,
      initialRoute: AppRoutes.initial,
      theme: appThemeData,
      getPages: appRoutesFile,
      defaultTransition: Transition.rightToLeft,
      themeMode: ThemeMode.light,
      defaultGlobalState: true,
      transitionDuration: const Duration(microseconds: 200),
    );
  }
}
