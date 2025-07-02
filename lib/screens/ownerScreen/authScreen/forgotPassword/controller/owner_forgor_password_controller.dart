import 'package:ahmed_shop/routes/app_routes.dart';
import 'package:ahmed_shop/services/repository/owner_auth_repository/owner_auth_repository.dart';
import 'package:ahmed_shop/utils/error_log.dart';
import 'package:ahmed_shop/widgets/app_snack_bar/app_snack_bar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class OwnerForgorPasswordController extends GetxController{
  final OwnerAuthRepository authRepository = OwnerAuthRepository();

  // Controller for email input
  final emailController = TextEditingController();

  RxBool isLoading = false.obs;

  @override
  void onClose() {
    emailController.dispose();
    super.onClose();
  }

  // Forgot Password API call
  Future<void> forgotPassword() async {
    try {
      isLoading.value = true;

      // Validate email
      if (emailController.text.trim().isEmpty) {
        AppSnackBar.error("Email is required.");
        return;
      }

      var response = await authRepository.forgotPassword(
        email: emailController.text.trim(),
      );

      if (response != null && response["success"] == true) {
        // Extract the forgetToken from the response

        AppSnackBar.success("Password reset email sent successfully.");
        Get.toNamed(AppRoutes.ownerFotgotPasswordOtpScreen);
        // Get.toNamed();
      }
    } catch (e) {
      errorLog("forgotPassword controller function", e);
      AppSnackBar.error("An error occurred. Please try again.");
    }
  }
} 