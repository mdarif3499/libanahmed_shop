import 'package:ahmed_shop/routes/app_routes.dart';
import 'package:ahmed_shop/widgets/texts/app_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../constant/app_colors.dart';
import '../../utils/app_size.dart';
import '../../utils/gap.dart';
import 'controller/error_screen_controller.dart';

class ErrorScreen extends StatelessWidget {
  const ErrorScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    AppSize.size = size;
    return GetBuilder(
      init: ErrorScreenController(),
      builder: (controller) {
        return Scaffold(
          body: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Obx(
                  () => Icon(
                    controller.isInternetProblem.value
                        ? Icons.signal_wifi_off_outlined
                        : Icons.error_outline_rounded,
                    size: AppSize.width(value: 100),
                  ),
                ),
                const Gap(height: 20),
                Obx(() => AppText(text: controller.errorMessage.value)),
                Obx(() => controller.isInternetProblem.value
                    ? Padding(
                        padding: EdgeInsets.all(AppSize.width(value: 10)),
                        child: const AppText(
                          text: "Check your internet connection",
                        ))
                    : const SizedBox()),
                const Gap(height: 30),
                GestureDetector(
                    onTap: () async {
                      await Get.offAllNamed(AppRoutes.onboardScreenTwo);
                    },
                    child: AppText(
                      text: "Try again...",
                      color: AppColors.instance.primary,
                    )),
              ],
            ),
          ),
        );
      },
    );
  }
}
