import 'dart:async';

import 'package:ahmed_shop/routes/app_routes.dart';
import 'package:ahmed_shop/services/repository/customer_auth_repository/auth_repository.dart';
import 'package:ahmed_shop/services/storage_services/storage_services.dart';
import 'package:ahmed_shop/utils/app_log.dart';
import 'package:ahmed_shop/utils/error_log.dart';
import 'package:ahmed_shop/widgets/app_snack_bar/app_snack_bar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ForgotPasswordOtpScreenController extends GetxController {
  final AuthRepository authRepository = AuthRepository();
  StorageServices appAuthStorage = StorageServices.instance;

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

  Future<void> checkRegistrationToken() async {
    bool hasToken = await authRepository.hasValidForgotPasswordToken();
    if (!hasToken) {
      AppSnackBar.error("Registration session expired. Please register again.");
      Get.offAllNamed(AppRoutes.onboardScreen);
    }
  }

  Future<void> verifyForgotPasswordOtp() async {
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
          "Registration session expired. Please register again.",
        );
        Get.offAllNamed(AppRoutes.onboardScreen);
        return;
      }
      String forgotToken = appAuthStorage.getForgotPasswordToken();
      final isVerified = (await authRepository.verifyForgotPasswordOtp(
        otp: otp,
        token: forgotToken,
      ));
      if (isVerified != null) {
        appLog(hasToken.toString());
        AppSnackBar.success("Account verified successfully!");
        Get.toNamed(AppRoutes.ownerResetPassword);
      }
    } catch (e) {
      errorLog("verifyOtp controller function", e);
      AppSnackBar.error("An error occurred during OTP verification.");
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> resendForgotPasswordOtp() async {
    try {
      isOtpResend.value = true;
      bool hasToken = await authRepository.hasValidForgotPasswordToken();
      if (!hasToken) {
        AppSnackBar.error(
          "Registration session expired. Please register again.",
        );
        Get.offAllNamed(AppRoutes.onboardScreen, arguments: {"isLogin": true});
        return;
      }
      // String forgotToken = appAuthStorage.getForgotPasswordToken();
      bool isResent = await authRepository.resendForgotPasswordOtp();
      if (isResent) {
        AppSnackBar.success("OTP resent successfully!");
        startTimer();
      } else {
        AppSnackBar.error("Failed to resend OTP. Please try again.");
      }
    } catch (e) {
      errorLog("resendOtp controller function", e);
      AppSnackBar.error("An error occurred while resending OTP.");
    } finally {
      isOtpResend.value = false;
    }
  }

  @override
  void onClose() {
    otpController.dispose();
    _countdownTimer?.cancel();
    super.onClose();
  }
}
