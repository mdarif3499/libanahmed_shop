import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../../routes/app_routes.dart';
import '../../../../../services/repository/customer_auth_repository/auth_repository.dart';
import '../../../../../utils/error_log.dart';
import '../../../../../widgets/app_snack_bar/app_snack_bar.dart';

class UserForgotPasswordScreenController extends GetxController {
  final AuthRepository authRepository = AuthRepository();

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
