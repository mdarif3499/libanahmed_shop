import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../constant/app_colors.dart';
import '../../../../../widgets/buttons/app_button.dart';
import '../../../../../widgets/inputs/app_input_widget.dart';
import '../../../../../widgets/texts/app_text.dart';
import 'controller/user_forgot_password_screen_controller.dart';

class UserForgotPasswordScreen extends StatelessWidget {
  const UserForgotPasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(UserForgotPasswordScreenController());

    return Scaffold(
      backgroundColor: AppColors.instance.userPhoneBackground,
      appBar: AppBar(
        backgroundColor: AppColors.instance.userPhoneBackground,
        title: AppText(
          text: "Forgot Password",
          fontSize: 16,
          fontWeight: FontWeight.w500,
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AppText(
              text: "Email",
              fontSize: 12,
              fontWeight: FontWeight.w500,
            ),
            const SizedBox(height: 10),
            AppInputWidget(
              controller: controller.emailController,
              hintText: "Enter your email",
              isEmail: true,
            ),
            const SizedBox(height: 20),
            Obx(() {
              return AppButton(
                title: controller.isLoading.value ? "Sending..." : "Send Email",
                onTap: controller.isLoading.value
                    ? null
                    : () {
                        controller.forgotPassword();
                      },
                backgroundColor: AppColors.instance.green500,
                borderradius: 10,
                height: 50,
              );
            }),
          ],
        ),
      ),
    );
  }
}
