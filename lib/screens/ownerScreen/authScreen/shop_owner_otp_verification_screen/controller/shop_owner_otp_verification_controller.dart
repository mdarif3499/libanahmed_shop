import 'dart:async';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../routes/app_routes.dart';
import '../../../../../services/repository/customer_auth_repository/auth_repository.dart';
import '../../../../../utils/error_log.dart';
import '../../../../../widgets/app_snack_bar/app_snack_bar.dart';

class ShopOwnerOtpVerificationController extends GetxController {
  final AuthRepository authRepository = AuthRepository();

  final otpController = TextEditingController();
  RxBool isLoading = false.obs;
  RxBool isOtpResend = false.obs;
  RxInt timer = 60.obs;
  RxBool canResend = false.obs;
  Timer? _countdownTimer;

  @override
  void onInit() {
    super.onInit();
    checkRegistrationToken();
    startTimer();
  }

  void startTimer() {
    timer.value = 60;
    canResend.value = false;
    _countdownTimer?.cancel();
    _countdownTimer = Timer.periodic(Duration(seconds: 1), (t) {
      if (timer.value > 0) {
        timer.value--;
      } else {
        canResend.value = true;
        _countdownTimer?.cancel();
      }
    });
  }

  // Check if valid registration token exists
  Future<void> checkRegistrationToken() async {
    bool hasToken = await authRepository.hasValidRegistrationToken();
    if (!hasToken) {
      AppSnackBar.error("Registration session expired. Please register again.");
      Get.offAllNamed(AppRoutes.onboardScreen);
    }
  }

  Future<void> verifyOtp() async {
    try {
      isLoading.value = true;
      if (otpController.text.trim().isEmpty) {
        AppSnackBar.error("OTP is required");
        return;
      }
      String otp = otpController.text.trim();
      if (otp.length != 6) {
        AppSnackBar.error("Please enter a valid 6-digit OTP");
        return;
      }
      bool hasToken = await authRepository.hasValidRegistrationToken();
      if (!hasToken) {
        AppSnackBar.error(
            "Registration session expired. Please register again.");
        Get.offAllNamed(AppRoutes.onboardScreen);
        return;
      }
      bool isVerified = await authRepository.verifyOtp(otp: otp);
      if (isVerified) {
        log(hasToken.toString());
        AppSnackBar.success("Account verified successfully!");
        Get.offAllNamed(AppRoutes.ownerCreateAccount);
      }
    } catch (e) {
      errorLog("verifyOtp controller function", e);
      AppSnackBar.error("An error occurred during OTP verification.");
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> resendOtp() async {
    try {
      isOtpResend.value = true;
      bool hasToken = await authRepository.hasValidRegistrationToken();
      if (!hasToken) {
        AppSnackBar.error(
            "Registration session expired. Please register again.");
        Get.offAllNamed(AppRoutes.onboardScreen, arguments: {"isLogin": true});
        return;
      }
      bool isResend = await authRepository.resendOtp();
      if (isResend) {
        log(hasToken.toString());
        AppSnackBar.success("Otp Resend Successfully");
        //Get.offAllNamed(AppRoutes.createAccount);
      }
    } catch (e) {
      errorLog("resendOtp controller function", e);
      AppSnackBar.error("Failed to resend OTP. Please try again.");
    } finally {
      isLoading.value = false;
    }
  }

  // Method to go back to registration
  // void goBackToRegistration() {
  //   authRepository.clearRegistrationToken();
  //   Get.offAllNamed(AppRoutes.userRegistration);
  // }

  @override
  void onClose() {
    otpController.dispose();
    _countdownTimer?.cancel();
    super.onClose();
  }
}
