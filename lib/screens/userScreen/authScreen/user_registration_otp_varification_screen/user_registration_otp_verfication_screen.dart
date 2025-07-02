// Dart
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:pinput/pinput.dart';

import '../../../../constant/app_assert_icons.dart';
import '../../../../constant/app_colors.dart';
import '../../../../constant/app_string.dart';
import '../../../../utils/gap.dart';
import '../../../../widgets/buttons/app_button.dart';
import '../../../../widgets/texts/app_text.dart';
import 'controller/user_registration_otp_verification_screen_controller.dart';

class UserRegistrationOtpVerificationScreen extends StatelessWidget {
  const UserRegistrationOtpVerificationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(UserRegistrationOtpVerificationController());

    return Scaffold(
      backgroundColor: AppColors.instance.userPhoneBackground,
      appBar: AppBar(
        backgroundColor: AppColors.instance.userPhoneBackground,
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: SvgPicture.asset(AppAssertIcons.backIcon),
        ),
        title: AppText(
          text: AppString.instance.back,
          fontSize: 16,
          fontWeight: FontWeight.w500,
          fontFamily: 1,
        ),
        titleSpacing: -7,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(10),
        child: Column(
          children: [
            Center(
              child: AppText(
                text: AppString.instance.otpVerification,
                fontSize: 32,
                fontWeight: FontWeight.w700,
                fontFamily: 2,
              ),
            ),
            Gap(height: 15),
            Pinput(
              controller: controller.otpController,
              length: 6,
              pinAnimationType: PinAnimationType.slide,
              defaultPinTheme: PinTheme(
                width: 50,
                height: 50,
                textStyle: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey),
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
            ),
            Gap(height: 15),
            Obx(() {
              return AppButton(
                title: controller.isLoading.value
                    ? "Verifying..."
                    : AppString.instance.verify,
                onTap: () {
                  controller.verifyOtp(); // Call the OTP verification method
                },
                backgroundColor: AppColors.instance.green500,
                borderradius: 10,
                height: 50,
                isLoading: controller.isLoading.value, // Show loading indicator
              );
            }),
            Gap(height: 20),
            Obx(() {
              if (!controller.canResend.value) {
                return AppText(
                  text: "Resend OTP in ${controller.timer.value}s",
                  fontSize: 16,
                  fontWeight: FontWeight.w400,
                  fontFamily: 1,
                  color: Colors.grey,
                );
              } else {
                return TextButton(
                  onPressed: controller.resendOtp,
                  child: AppText(
                    text: "Resend OTP",
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: AppColors.instance.green500,
                  ),
                );
              }
            }),
          ],
        ),
      ),
    );
  }
}
