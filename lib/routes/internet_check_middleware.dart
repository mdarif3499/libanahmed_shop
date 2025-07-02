// ignore: file_names
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../screens/errorScreen/error_screen.dart';
import '../services/connectivity_service/connectivity_service.dart';
import 'app_routes.dart';

class InternetCheckMiddleWare extends GetMiddleware {
  final ConnectivityService connectivityService = Get.find<ConnectivityService>();

  @override
  RouteSettings? redirect(String? route) {
    if (connectivityService.connectionStatus.contains(ConnectivityResult.none)) {
      return RouteSettings(name: AppRoutes.errorScreen);
    }
    return super.redirect(route);
  }

  @override
  GetPage? onPageCalled(GetPage? page) {
    if (connectivityService.connectionStatus.contains(ConnectivityResult.none)) {
      return GetPage(name: AppRoutes.errorScreen, page: () => ErrorScreen());
    }
    return super.onPageCalled(page);
  }

  @override
  GetPageBuilder? onPageBuildStart(GetPageBuilder? page) {
    if (connectivityService.connectionStatus.contains(ConnectivityResult.none)) {
      return () => ErrorScreen();
    }
    return super.onPageBuildStart(page);
  }

  //@override
  // Future<GetNavConfig?> redirectDelegate(GetNavConfig route) async {
  //   // Check if there is no internet connection
  //   if (connectivityService.connectionStatus == ConnectivityResult.none) {
  //     // Redirect to error screen if no internet connection
  //     return GetNavConfig(
  //       currentTreeBranch: route.currentTreeBranch,
  //       destination: GetPage(
  //         name: AppRoutes.errorScreen,
  //         page: () => ErrorScreen(),
  //         binding: BindingsBuilder(() {}),
  //       ),
  //     );
  //   } else {
  //     // Continue with the default routing if there is internet connection
  //     return super.redirectDelegate(route);
  //   }
  // }
}
