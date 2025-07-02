import 'package:ahmed_shop/constant/app_colors.dart';
import 'package:ahmed_shop/constant/app_string.dart';
import 'package:ahmed_shop/screens/splashScreen/controller/splash_screen_controller.dart';
import 'package:ahmed_shop/widgets/texts/app_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../utils/app_size.dart';

class UserSplashScreen extends StatelessWidget {
  const UserSplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final UserSplashController controller = Get.put(UserSplashController());

    Size size = MediaQuery.of(context).size;
    AppSize.size = size;

    return Scaffold(
      backgroundColor: AppColors.instance.green500,
      body: Center(
        child: AppText(
          text: AppString.instance.ahmed,
          fontSize: 84,
          color: AppColors.instance.white100,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}
