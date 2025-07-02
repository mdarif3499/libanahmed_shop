import 'dart:developer';

import 'package:ahmed_shop/constant/app_assert_icons.dart';
import 'package:ahmed_shop/constant/app_colors.dart';
import 'package:ahmed_shop/constant/app_string.dart';
import 'package:ahmed_shop/screens/ownerScreen/authScreen/otpVerification/controller/owner_otp_verification_controller.dart';
import 'package:ahmed_shop/utils/gap.dart';
import 'package:ahmed_shop/widgets/buttons/app_button.dart';
import 'package:ahmed_shop/widgets/texts/app_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:pinput/pinput.dart';

class OwnerOtpVerificationScreen extends StatelessWidget {
  OwnerOtpVerificationScreen({super.key});

  final TextEditingController _otpController = TextEditingController();
  final OwnerOtpVerificationController controller =
      Get.put(OwnerOtpVerificationController());

  @override
  Widget build(BuildContext context) {
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
            Center(
              child: AppText(
                text: AppString.instance.provideYourEmail,
                fontFamily: 2,
                fontSize: 12,
                color: AppColors.instance.greyColor,
                fontWeight: FontWeight.w400,
              ),
            ),
            Gap(height: 15),
            Pinput(
              controller: _otpController,
              length: 6,
              pinAnimationType: PinAnimationType.slide,
              onCompleted: (pin) {
                log("Entered OTP: $pin");
              },
              onChanged: (value) {
                log("OTP value changed: $value");
              },
              defaultPinTheme: PinTheme(
                width: 50, 
                height: 50, 
                textStyle: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey), // Border color
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
            ),
            Gap(height: 15),
            AppButton(
              title: AppString.instance.verify,
              onTap: () {
                controller.verifyOtp(_otpController.text);
              },
              backgroundColor: AppColors.instance.red500,
              borderradius: 10,
              height: 50,
            ),
            Gap(height: 15),
          ],
        ),
      ),    );
  }
}
