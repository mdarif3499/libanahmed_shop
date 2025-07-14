import 'package:ahmed_shop/constant/app_assert_image.dart';
import 'package:ahmed_shop/constant/app_colors.dart';
import 'package:ahmed_shop/screens/splashScreen/controller/splash_screen_controller.dart';
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
      backgroundColor: AppColors.instance.white,
      body: Center(
        child: Image.asset(
          AppAssertImage.instance.appLogo,
          height: AppSize.height(value: 374),
          width: AppSize.width(value: 374),
        ),
      ),
    );
  }
}
