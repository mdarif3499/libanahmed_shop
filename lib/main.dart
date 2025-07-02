import 'dart:io';

import 'package:ahmed_shop/services/connectivity_service/connectivity_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import 'main_entry_app.dart';

String? userTimezone;

Future<void> main() async {
  /////////////////  binding initialized call  /////////////

  WidgetsFlutterBinding.ensureInitialized();

  /////////// set system orientations
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitDown,
    DeviceOrientation.portraitUp,
  ]);
  HttpOverrides.global = MyHttpOverrides();
  /////////////  storage initial  /////////////
  await GetStorage.init();
  ///////////// internet connectivity status check /////////////
  Get.put(ConnectivityService());
  runApp(const MainAppEntry());
}

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}
