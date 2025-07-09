import 'package:ahmed_shop/routes/app_routes.dart';
import 'package:ahmed_shop/services/repository/customer_auth_repository/auth_repository.dart';
import 'package:ahmed_shop/services/storage_services/storage_services.dart';
import 'package:ahmed_shop/widgets/app_snack_bar/app_snack_bar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ResetPasswordScreenController extends GetxController {
  final AuthRepository authRepository = AuthRepository();

  // Controller for new password input
  final newPasswordController = TextEditingController();

  // Controller for confirm password input
  final confirmPasswordController = TextEditingController();

  RxBool isLoading = false.obs;

  @override
  void onClose() {
    newPasswordController.dispose();
    confirmPasswordController.dispose();
    super.onClose();
  }

  // Reset Password API call
  Future<void> resetPassword() async {
    try {
      isLoading.value = true;

      // Validate passwords
      if (newPasswordController.text.trim().isEmpty) {
        AppSnackBar.error("New password is required.");
        return;
      }
      if (confirmPasswordController.text.trim().isEmpty) {
        AppSnackBar.error("Confirm password is required.");
        return;
      }
      if (newPasswordController.text != confirmPasswordController.text) {
        AppSnackBar.error("Passwords do not match.");
        return;
      }
      var forgotToken = StorageServices.instance.getForgotPasswordToken();
      if (forgotToken.isEmpty) {
        AppSnackBar.error("Invalid or expired token. Please try again.");
        return;
      }
      var response = await authRepository.resetPassword(
          newPassword: newPasswordController.text.trim(),
          confirmPassword: confirmPasswordController.text.trim(),
          token: forgotToken);
      AppSnackBar.success("Password reset successfully.");
      // Clear the token from storage
      Get.toNamed(AppRoutes.createAccount);
      return;
    // Navigate back to the previous screen
    } catch (e) {
      AppSnackBar.error("An error occurred. Please try again.");
    } finally {
      isLoading.value = false;
    }
  }
}
